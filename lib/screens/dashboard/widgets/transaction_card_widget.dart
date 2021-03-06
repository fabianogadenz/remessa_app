import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/transaction_status_widget.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionCardWidget({
    Key key,
    @required this.transaction,
  })  : assert(transaction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = GetIt.I<NavigatorHelper>();

    return GestureDetector(
      onTap: () {
        TrackingEvents.log(
          TrackingEvents.DASHBOARD_OPEN_TRANSACTION_CARD_CLICK,
          {
            'operation_id': transaction.id,
            'operation_status_group': transaction.statusId,
            'operation_status_name': transaction.statusName,
          },
        );

        navigator.pushNamed(
          AppRouter.TRANSACTION_DETAILS_ROUTE,
          arguments: TransactionDetailsScreenArgs(
            transactionId: transaction.id,
          ),
        );
      },
      child: body(),
    );
  }

  Widget body() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 15, left: 12, bottom: 6),
            child: ListTile(
              title: Text(
                transaction.counterpartName,
                style: TextStyle(
                  color: StyleColors.BRAND_PRIMARY_80,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                CurrencyHelper.withPrefix(
                  transaction.foreignCurrency,
                  transaction.foreignCurrencyAmount.toString(),
                ),
                style: TextStyle(
                  color: StyleColors.BRAND_PRIMARY_80,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Container(
            child: Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: StyleColors.SUPPORT_NEUTRAL_20,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TransactionStatusWidget(
                      status: transaction.status,
                      statusName: transaction.statusName,
                    ),
                    Text(
                      'ID ${transaction.id}',
                      style: TextStyle(
                        fontSize: 11,
                        color: StyleColors.SUPPORT_NEUTRAL_50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
