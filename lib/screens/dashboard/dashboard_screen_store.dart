import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/pagination_model.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/services/transaction_service.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';

part 'dashboard_screen_store.g.dart';

class DashboardScreenStore = _DashboardScreenStore with _$DashboardScreenStore;

abstract class _DashboardScreenStore with Store {
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();

  bool isLoadingOpenTransactions = false;

  @observable
  PaginationModel openTransactionsPagination;

  @observable
  ObservableList<Transaction> openTransactions = ObservableList.of([]);

  @observable
  PaginationModel closedTransactionsPagination;

  @observable
  ObservableList<Transaction> closedTransactions = ObservableList.of([]);

  @observable
  bool isLoading = true;

  @computed
  bool get isEmpty =>
      !isLoading &&
      openTransactions.length == 0 &&
      closedTransactions.length == 0;

  @action
  setIsLoading(bool value) => isLoading = value;

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

  @action
  getClosedTransactions(int page) async {
    final TransactionResponseModel closedTransactions =
        await TransactionService.getTransactions(
      statusType: StatusType.FINISHED,
      flow: Flow.OUTBOUND,
      page: page ?? 1,
    );

    this.closedTransactions.addAll(closedTransactions.items);
    this.closedTransactionsPagination = closedTransactions.pagination;
  }

  @action
  getTransactions({
    int openTransactionsPage,
    int closedTransactionsPage,
  }) async {
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

    setIsLoading(false);
  }
}
