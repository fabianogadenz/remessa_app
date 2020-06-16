import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_name_widget.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionDetailsHeaderWidget extends StatelessWidget {
  const TransactionDetailsHeaderWidget({
    Key key,
    @required this.transactionDetails,
  })  : assert(transactionDetails != null),
        super(key: key);

  final TransactionDetailsResponseModel transactionDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          TransactionNameWidget(
            transactionName: transactionDetails.transactionName,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            CurrencyHelper.withPrefix(
              transactionDetails.quote.foreignCurrency,
              transactionDetails.quote.foreignCurrencyAmount.toString(),
            ),
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w300,
              color: StyleColors.SUPPORT_NEUTRAL_10,
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            CurrencyHelper.withPrefix(
              transactionDetails.quote.nationalCurrency,
              transactionDetails.quote.nationalCurrencyTotalAmount.toString(),
            ),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: StyleColors.SUPPORT_NEUTRAL_10,
            ),
          ),
        ],
      ),
    );
  }
}
