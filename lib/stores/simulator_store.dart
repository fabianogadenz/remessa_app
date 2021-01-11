import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/currency_model.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/requests/simulator_request_model.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/models/responses/simulator_default_values_response_model.dart';
import 'package:remessa_app/models/responses/simulator_response_model.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/simulator_service.dart';
import 'package:rxdart/rxdart.dart';

part 'simulator_store.g.dart';

class SimulatorStore = _SimulatorStoreBase with _$SimulatorStore;

abstract class _SimulatorStoreBase with Store {
  final _homeScreenStore = GetIt.I<HomeScreenStore>();
  final i18n = GetIt.I<I18n>();

  _clearState() {
    voucherCode = null;
  }

  @observable
  Beneficiary beneficiary;

  @action
  setBeneficiary(Beneficiary value) {
    if (beneficiary == null || beneficiary.id != value.id) {
      isLoading = false;
      beneficiary = value;
      _clearState();
    }
  }

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
    _requests.switchMap<SimulatorResponseModel>((request) async* {
      try {
        yield await SimulatorService.simulate(request);
      } on ErrorModel catch (e) {
        if (e?.fieldErrors != null) {
          setFieldErrors(e?.fieldErrors);
        } else {
          _homeScreenStore.setErrorMessage(e?.mainError?.message ?? '');
        }
        setHasError(true);
      } catch (e) {
        if (e?.message != null) _homeScreenStore.setErrorMessage(e?.message);
        setHasError(true);
      }
    }).listen((event) {
      if (event is SimulatorResponseModel) {
        simulatorResponse = event;
        voucherCode = simulatorResponse?.quote?.voucherCode;
      }
    });
  }

  get request {
    final Currency currency = beneficiary?.currency ??
        simulatorDefaultValuesResponseModel?.precification?.currency;

    return SimulatorRequestModel(
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
      abbreviation: currency.abbreviation ??
          i18n.trans('simulator_screen', ['default_currency_abbr']),
      voucherCode: voucherCode ??
          simulatorDefaultValuesResponseModel
              ?.precification?.quote?.voucherCode,
    );
  }

  @action
  simulate() async {
    if (beneficiary == null) return;

    setHasError(false);
    setFieldErrors(null);

    _requests.add(request);
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
      _homeScreenStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _homeScreenStore.setErrorMessage(e?.message ?? '');
      hasError = true;
    } finally {
      isLoading = false;
    }
  }

  @observable
  String voucherCode;

  @action
  Future<ErrorResponseModel> applyVoucher(String _voucherCode) async {
    ErrorResponseModel voucherError;

    voucherCode = _voucherCode;

    try {
      final voucherValidationResponse =
          await SimulatorService.applyVoucher(request);

      if (voucherValidationResponse) {
        simulatorResponse = await SimulatorService.simulate(request);
      }
    } on ErrorModel catch (e) {
      voucherCode = null;
      voucherError = e.mainError;
    } catch (e) {
      _homeScreenStore.setErrorMessage(e?.message ?? '');
      hasError = true;
    }

    return voucherError;
  }

  dispose() {
    _requests.close();
  }
}
