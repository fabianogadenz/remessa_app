import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/pagination_model.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/transaction_service.dart';

part 'transactions_store.g.dart';

class TransactionsStore = _TransactionsStoreBase with _$TransactionsStore;

abstract class _TransactionsStoreBase with Store {
  final _homeScreenStore = GetIt.I<HomeScreenStore>();

  @observable
  bool isLoadingTransactions = true;

  @action
  setIsLoadingTransactions(bool value) => isLoadingTransactions = value;

  bool isLoadingOpenTransactions = false;

  @observable
  PaginationModel openTransactionsPagination;

  @observable
  ObservableList<Transaction> openTransactions = ObservableList.of([]);

  @action
  getOpenTransactions(int page) async {
    if (isLoadingOpenTransactions) return;

    isLoadingOpenTransactions = true;

    final TransactionResponseModel openTransactions =
        await TransactionService.getTransactions(
      statusType: StatusType.OPEN,
      flow: Flow.OUTBOUND,
      page: page ?? 1,
    );

    this.openTransactions.addAll(openTransactions.items);
    this.openTransactionsPagination = openTransactions.pagination;

    isLoadingOpenTransactions = false;
  }

  @observable
  PaginationModel closedTransactionsPagination;

  @observable
  ObservableList<Transaction> closedTransactions = ObservableList.of([]);

  bool isLoadingClosedTransactions = false;

  @action
  getClosedTransactions(int page) async {
    if (isLoadingClosedTransactions) return;

    isLoadingClosedTransactions = true;

    final TransactionResponseModel closedTransactions =
        await TransactionService.getTransactions(
      statusType: StatusType.FINISHED,
      flow: Flow.OUTBOUND,
      page: page ?? 1,
    );

    this.closedTransactions.addAll(closedTransactions.items);
    this.closedTransactionsPagination = closedTransactions.pagination;

    isLoadingClosedTransactions = false;
  }

  clearTransactions() {
    isLoadingTransactions = true;
    isLoadingOpenTransactions = false;

    openTransactions.clear();
    closedTransactions.clear();

    openTransactionsPagination = null;
    closedTransactionsPagination = null;

    _homeScreenStore.setErrorMessage('');
  }

  @action
  getTransactions({
    int openTransactionsPage,
    int closedTransactionsPage,
  }) async {
    setIsLoadingTransactions(true);

    try {
      await getOpenTransactions(openTransactionsPage);
      await getClosedTransactions(closedTransactionsPage);
    } on ErrorModel catch (e) {
      _homeScreenStore.setErrorMessage(e?.mainError?.message);
    } catch (e) {
      _homeScreenStore.setErrorMessage(e?.message);
    }

    setIsLoadingTransactions(false);
  }
}
