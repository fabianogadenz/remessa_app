import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/services/transaction_service.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import './bloc.dart';

class DashboardScreenBloc
    extends Bloc<DashboardScreenEvent, DashboardScreenState> {
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();

  @override
  DashboardScreenState get initialState => DashboardScreenState.initialState();

  Stream<DashboardScreenState> _mapLoadTransactionsToState(
      LoadTransactionsEvent event) async* {
    if (event.page == null)
      _tabControllerBloc.add(LoadingTabEvent(isLoading: true));

    try {
      final TransactionResponseModel transactions =
          await TransactionService.getTransactions(
        statusType: StatusType.OPEN,
        flow: Flow.OUTBOUND,
        page: event.page ?? 1,
      );

      if (event.page == null)
        _tabControllerBloc.add(LoadingTabEvent(isLoading: false));

      final value = state?.value ?? [];
      value.addAll(transactions.items);

      yield DashboardScreenState(
        pagination: transactions.pagination,
        value: value,
      );
    } on ErrorModel catch (e) {
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: e?.mainError?.message),
      );
    } catch (e) {
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: e?.message),
      );
    }
  }

  @override
  Stream<DashboardScreenState> mapEventToState(
    DashboardScreenEvent event,
  ) async* {
    if (event is LoadTransactionsEvent)
      yield* _mapLoadTransactionsToState(event);
  }
}
