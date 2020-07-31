import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/currency_model.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/requests/simulator_request_model.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/models/responses/simulator_default_values_response_model.dart';
import 'package:remessa_app/models/responses/simulator_response_model.dart';
import 'package:remessa_app/services/simulator_service.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_store.dart';
import 'package:rxdart/rxdart.dart';

part 'simulator_store.g.dart';

class SimulatorStore = _SimulatorStoreBase with _$SimulatorStore;

abstract class _SimulatorStoreBase with Store {
  final _tabControllerStore = GetIt.I<TabControllerStore>();

  @observable
  Beneficiary beneficiary;

  @action
  setBeneficiary(Beneficiary value) => beneficiary = value;

  @observable
  bool isReverse;

  @observable
  bool shouldRefresh;

  @observable
  double quantity;

  @action
  setQuantity(double value) {
    isReverse = true;
    if (quantity != value) {
      quantity = value;
      shouldRefresh = true;
    }
  }

  @observable
  double totalValue;

  @action
  setTotalValue(double value) {
    isReverse = false;
    if (totalValue != value) {
      totalValue = value;
      shouldRefresh = true;
    }
  }

  @observable
  bool hasError = false;

  @action
  setHasError(bool value) => hasError = value;

  @observable
  bool isLoading = false;

  @observable
  List<ErrorResponseModel> fieldErrors;

  @action
  setFieldErrors(List<ErrorResponseModel> value) => fieldErrors = value;

  final _requests = BehaviorSubject<SimulatorRequestModel>();

  @observable
  SimulatorResponseModel simulatorResponse;

  _SimulatorStoreBase() {
    _requests
        .debounceTime(const Duration(milliseconds: 500))
        .switchMap<SimulatorResponseModel>((request) async* {
      try {
        yield await SimulatorService.simulate(request);
      } on ErrorModel catch (e) {
        if (e?.fieldErrors != null) {
          setFieldErrors(e?.fieldErrors);
        } else {
          _tabControllerStore.setErrorMessage(e?.mainError?.message ?? '');
        }
        setHasError(true);
      } catch (e) {
        if (e?.message != null) _tabControllerStore.setErrorMessage(e?.message);
        setHasError(true);
      }
    }).listen((event) {
      if (event is SimulatorResponseModel) simulatorResponse = event;
    });
  }

  @action
  simulate() async {
    if (beneficiary == null) return;

    setHasError(false);
    setFieldErrors(null);

    final Currency currency = beneficiary?.currency ??
        simulatorDefaultValuesResponseModel?.precification?.currency;

    _requests.add(
      SimulatorRequestModel(
        idOperationType: 1,
        idBeneficiary: beneficiary?.id,
        reverse: isReverse ?? false,
        quantity: quantity ??
            simulatorDefaultValuesResponseModel
                ?.precification?.quote?.foreignCurrencyAmount,
        totalValue: totalValue ??
            simulatorDefaultValuesResponseModel
                ?.precification?.quote?.nationalCurrencyTotalAmount,
        idCurrency: currency.id ?? 1,
        abbreviation: currency.abbreviation ?? 'USD',
      ),
    );
  }

  @observable
  SimulatorDefaultValuesResponseModel simulatorDefaultValuesResponseModel;

  @computed
  Currencies get currencies => simulatorDefaultValuesResponseModel?.currencies;

  @action
  getDefaultValues({Currency currency}) async {
    isLoading = true;

    if (beneficiary == null) return;

    try {
      simulatorDefaultValuesResponseModel =
          await SimulatorService.getDefaultValues(
        beneficiary?.id,
        currency?.id ?? beneficiary?.currency?.id,
        currency?.abbreviation ?? beneficiary?.currency?.abbreviation,
      );

      simulatorResponse = simulatorDefaultValuesResponseModel?.precification;
    } on ErrorModel catch (e) {
      _tabControllerStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _tabControllerStore.setErrorMessage(e?.message ?? '');
      hasError = true;
    } finally {
      isLoading = false;
    }
  }

  dispose() {
    _requests.close();
  }
}
