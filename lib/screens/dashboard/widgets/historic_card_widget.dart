import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen.dart';
import 'package:remessa_app/style/colors.dart';

class HistoricCardWidget extends StatelessWidget {
  const HistoricCardWidget({
    Key key,
    @required this.transaction,
  }) : super(key: key);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final paidDate = DateHelper.stringToDate(transaction.paidAt);
    final i18n = GetIt.I<I18n>();

    return GestureDetector(
      onTap: () {
        NavigatorHelper.push(
          context,
          TransactionDetailsScreen(
            transactionId: transaction.id,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: StyleColors.BRAND_PRIMARY_50,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  transaction.counterpartName,
                  style: TextStyle(
                    fontSize: 12,
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                  ),
                ),
                Text(
                  CurrencyHelper.withPrefix(
                    transaction.foreignCurrency,
                    transaction.foreignCurrencyAmount.toString(),
                  ),
                  style: TextStyle(
                    fontSize: 12,
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  '${i18n.trans('transaction', [
                    'paid_at'
                  ])} ${DateHelper.formatToBR(paidDate)}',
                  style: TextStyle(
                    fontSize: 11,
                    color: StyleColors.BRAND_PRIMARY_20,
                  ),
                ),
                Text(
                  CurrencyHelper.withPrefix(
                    transaction.nationalCurrency,
                    transaction.nationalCurrencyTotalAmount,
                  ),
                  style: TextStyle(
                    fontSize: 11,
                    color: StyleColors.BRAND_PRIMARY_20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
