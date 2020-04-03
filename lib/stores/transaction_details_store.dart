import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/services/transaction_service.dart';

part 'transaction_details_store.g.dart';

class TransactionDetailsStore = _TransactionDetailsStoreBase
    with _$TransactionDetailsStore;

abstract class _TransactionDetailsStoreBase with Store {
  @observable
  TransactionDetailsResponseModel transactionDetails;

  @action
  getTransactionDetailsStore(int transactionId) async {
    transactionDetails =
        await TransactionService.getTransactionDetailsById(transactionId);
  }
}
