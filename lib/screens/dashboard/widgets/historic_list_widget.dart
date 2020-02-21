import 'package:flutter/material.dart';
import 'package:remessa_app/screens/dashboard/dashboard_screen_store.dart';
import 'package:remessa_app/screens/dashboard/widgets/historic_card_widget.dart';

class HistoricListWidget extends StatelessWidget {
  const HistoricListWidget({
    Key key,
    @required DashboardScreenStore dashboardSreenStore,
  })  : _dashboardSreenStore = dashboardSreenStore,
        super(key: key);

  final DashboardScreenStore _dashboardSreenStore;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == _dashboardSreenStore.closedTransactions.length - 2) {
            final pagination =
                _dashboardSreenStore.closedTransactionsPagination;

            if (pagination != null && pagination.page < pagination.totalPages)
              _dashboardSreenStore.getClosedTransactions(pagination.page + 1);
          }

          final transaction = _dashboardSreenStore.closedTransactions[index];

          return HistoricCardWidget(transaction: transaction);
        },
        childCount: _dashboardSreenStore.closedTransactions.length,
      ),
    );
  }
}
