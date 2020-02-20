import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/transaction_status.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:tuple/tuple.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionCardWidget({
    Key key,
    @required this.transaction,
  })  : assert(transaction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final amount = CurrencyHelper.format(transaction.foreignCurrencyAmount);

    final statusColor = TransactionStatus.getColor(transaction.statusId);

    return GestureDetector(
      onTap: () => GetIt.I<AmplitudeFlutter>()
          .logEvent(name: TrackEvents.TRANSACTION_CARD_CLICK, properties: {
        'operation_id': transaction.id,
        'operation_status': transaction.statusName,
      }),
      child: body(amount, statusColor),
    );
  }

  Widget body(String amount, Tuple2<Color, Color> statusColor) {
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
                '${transaction.foreignCurrency} $amount',
                style: TextStyle(
                  color: StyleColors.BRAND_PRIMARY_80,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: statusColor.item1,
                      ),
                      child: Text(
                        transaction?.statusName?.toUpperCase(),
                        style: TextStyle(
                          color: statusColor.item2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'ID ${transaction.id}',
                      style: TextStyle(
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
