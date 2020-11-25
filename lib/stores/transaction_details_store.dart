import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/transaction_service.dart';

part 'transaction_details_store.g.dart';

class TransactionDetailsStore = _TransactionDetailsStoreBase
    with _$TransactionDetailsStore;

abstract class _TransactionDetailsStoreBase with Store {
  final _homeScreenStore = GetIt.I<HomeScreenStore>();
  final navigator = GetIt.I<NavigatorHelper>();

  @observable
  bool hasError = false;

  @observable
  TransactionDetailsResponseModel transactionDetails;

  @action
  getTransactionDetailsStore(int transactionId) async {
    try {
      transactionDetails =
          await TransactionService.getTransactionDetailsById(transactionId);
    } on ErrorModel catch (e) {
      _homeScreenStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _homeScreenStore.setErrorMessage(e?.message);
      hasError = true;
    }
  }
}
