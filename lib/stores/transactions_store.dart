import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/pagination_model.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/services/transaction_service.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';

part 'transactions_store.g.dart';

class TransactionsStore = _TransactionsStoreBase with _$TransactionsStore;

abstract class _TransactionsStoreBase with Store {
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();

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
    openTransactions.clear();
    closedTransactions.clear();

    openTransactionsPagination = null;
    closedTransactionsPagination = null;
  }

  @action
  getTransactions({
    int openTransactionsPage,
    int closedTransactionsPage,
  }) async {
    setIsLoadingTransactions(true);

    clearTransactions();

    try {
      await getOpenTransactions(openTransactionsPage);
      await getClosedTransactions(closedTransactionsPage);
    } on ErrorModel catch (e) {
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: e?.mainError?.message),
      );
    } catch (e) {
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: e?.message),
      );
    }

    setIsLoadingTransactions(false);
  }
}
