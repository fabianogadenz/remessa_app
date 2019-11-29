abstract class DashboardScreenEvent {
  const DashboardScreenEvent();
}

class LoadTransactionsEvent extends DashboardScreenEvent {
  final int page;

  LoadTransactionsEvent({this.page});
}
