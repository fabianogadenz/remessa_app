import 'package:flutter/material.dart';

import 'package:remessa_app/screens/dashboard/widgets/historic_card_widget.dart';
import 'package:remessa_app/stores/transactions_store.dart';

class HistoricListWidget extends StatelessWidget {
  const HistoricListWidget({
    Key key,
    @required TransactionsStore transactionsStore,
  })  : _transactionsStore = transactionsStore,
        super(key: key);

  final TransactionsStore _transactionsStore;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index == _transactionsStore.closedTransactions.length - 2) {
            final pagination = _transactionsStore.closedTransactionsPagination;

            if (pagination != null && pagination.page < pagination.totalPages)
              _transactionsStore.getClosedTransactions(pagination.page + 1);
          }

          final transaction = _transactionsStore.closedTransactions[index];

          return HistoricCardWidget(transaction: transaction);
        },
        childCount: _transactionsStore.closedTransactions.length,
      ),
    );
  }
}
