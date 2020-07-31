import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/services/beneficiary_service.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_store.dart';

part 'beneficiary_store.g.dart';

class BeneficiaryStore = _BeneficiaryStoreBase with _$BeneficiaryStore;

abstract class _BeneficiaryStoreBase with Store {
  final _tabControllerStore = GetIt.I<TabControllerStore>();

  @observable
  bool hasError = false;

  @observable
  bool isLoading = true;

  @observable
  BeneficiaryResponseModel beneficiaryResponseModel;

  @action
  getBeneficiaries() async {
    isLoading = true;
    try {
      beneficiaryResponseModel = await BeneficiaryService.getBeneficiaries();
    } on ErrorModel catch (e) {
      _tabControllerStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _tabControllerStore.setErrorMessage(e?.message);
      hasError = true;
    } finally {
      isLoading = false;
    }
  }
}
