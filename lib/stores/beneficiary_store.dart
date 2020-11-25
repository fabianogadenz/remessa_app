import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/beneficiary_service.dart';

part 'beneficiary_store.g.dart';

class BeneficiaryStore = _BeneficiaryStoreBase with _$BeneficiaryStore;

abstract class _BeneficiaryStoreBase with Store {
  final _homeScreenStore = GetIt.I<HomeScreenStore>();

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
      _homeScreenStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _homeScreenStore.setErrorMessage(e?.message);
      hasError = true;
    } finally {
      isLoading = false;
    }
  }
}
