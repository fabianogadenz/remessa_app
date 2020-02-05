import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:remessa_app/helpers/helpers.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/transaction_status.dart';
import 'package:remessa_app/models/responses/transaction_response_model.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCardWidget extends StatelessWidget {
  final Transaction transaction;

  const TransactionCardWidget({
    Key key,
    @required this.transaction,
  })  : assert(transaction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final currency = NumberFormat(
      ',###.00',
      GetIt.I<I18n>().locale.languageCode,
    );
    final amount =
        currency.format(double.parse(transaction.foreignCurrencyAmount));

    final statusColor = TransactionStatus.getColor(transaction.statusId);

    return GestureDetector(
      onTap: () => GetIt.I<AmplitudeFlutter>()
          .logEvent(name: TrackEvents.TRANSACTION_CARD_CLICK, properties: {
        'operation_id': transaction.id,
        'operation_status': transaction.statusName,
      }),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 20),
                  child: Text(
                    transaction.counterpartName,
                    style: TextStyle(
                      color: StyleColors.BRAND_PRIMARY_80,
                      fontWeight: FontWeight.w300,
                      fontSize: 20,
                    ),
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
            ButtonTheme.bar(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: StyleColors.SUPPORT_NEUTRAL_20,
                    ),
                  ),
                ),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceBetween,
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
          ],
        ),
      ),
    );
  }
}
