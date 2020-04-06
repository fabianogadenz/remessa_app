import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:remessa_app/screens/dashboard/widgets/transaction_card_widget.dart';
import 'package:remessa_app/stores/transactions_store.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionsCarousel extends StatefulWidget {
  const TransactionsCarousel({
    Key key,
    this.transactionsStore,
  }) : super(key: key);

  final TransactionsStore transactionsStore;

  @override
  _TransactionsCarouselState createState() => _TransactionsCarouselState();
}

class _TransactionsCarouselState extends State<TransactionsCarousel> {
  var _current = 0;

  @override
  Widget build(BuildContext context) {
    var transactions = widget.transactionsStore.openTransactions;
    var pagination = widget.transactionsStore.openTransactionsPagination;

    var children = <Widget>[
      CarouselSlider(
        enableInfiniteScroll: false,
        viewportFraction: 0.9,
        height: 150,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
        items: transactions
            .map(
              (item) => Builder(
                builder: (BuildContext context) {
                  if (!widget.transactionsStore.isLoadingOpenTransactions &&
                      _current == transactions.length - 5) {
                    if (pagination != null &&
                        pagination.page < pagination.totalPages) {
                      widget.transactionsStore
                          .getOpenTransactions(pagination.page + 1);
                    }
                  }

                  return TransactionCardWidget(
                    transaction: item,
                  );
                },
              ),
            )
            .toList(),
      ),
      _buildIndicators(pagination.totalItems),
    ];

    return Column(
      children: children,
    );
  }

  _buildIndicators(int totalItems) {
    final List<Widget> indicators = [];

    for (var index = 0; index < totalItems; index++) {
      indicators.add(
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(
            left: 3,
            right: 3,
            bottom: 15,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _current == index
                ? StyleColors.SUPPORT_NEUTRAL_10
                : StyleColors.SUPPORT_NEUTRAL_10.withOpacity(0.2),
          ),
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: indicators,
      ),
    );
  }
}
