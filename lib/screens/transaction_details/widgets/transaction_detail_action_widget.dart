import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionDetailActionWidget extends StatelessWidget {
  const TransactionDetailActionWidget(
    this.label, {
    Key key,
    this.onPressed,
  })  : assert(label != null),
        super(key: key);

  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StyleColors.SUPPORT_NEUTRAL_30,
          ),
        ),
      ),
      padding: EdgeInsets.only(left: 24, right: 18),
      child: FlatButton(
        padding: EdgeInsets.only(left: 0),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: StyleColors.BRAND_PRIMARY_40,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: StyleColors.BRAND_SECONDARY_40,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
