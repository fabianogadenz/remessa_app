import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/constants/image_contants.dart';

class TransactionNameWidget extends StatelessWidget {
  const TransactionNameWidget({
    Key key,
    @required this.transactionName,
  })  : assert(transactionName != null),
        super(key: key);

  final String transactionName;

  @override
  Widget build(BuildContext context) {
    final transactionNameTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: StyleColors.SUPPORT_NEUTRAL_10,
    );

    return Container(
      decoration: BoxDecoration(
        color: StyleColors.BRAND_PRIMARY_50,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 6,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            child: Image.asset(ImageConstants.SEND_REMITTANCE),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              StringHelper.handleLimiterWithEllipsisFromTextWidthAndStyle(
                transactionName,
                250,
                transactionNameTextStyle,
              ),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              style: transactionNameTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
