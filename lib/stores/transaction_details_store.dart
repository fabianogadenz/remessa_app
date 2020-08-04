import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/services/transaction_service.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_store.dart';

part 'transaction_details_store.g.dart';

class TransactionDetailsStore = _TransactionDetailsStoreBase
    with _$TransactionDetailsStore;

abstract class _TransactionDetailsStoreBase with Store {
  final _tabControllerStore = GetIt.I<TabControllerStore>();
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
      _tabControllerStore.setErrorMessage(e?.mainError?.message);
      hasError = true;
    } catch (e) {
      _tabControllerStore.setErrorMessage(e?.message);
      hasError = true;
    }
  }
}
