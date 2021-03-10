import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class PaymentRulesToggleHeaderWidget extends StatelessWidget {
  final String text;
  final IconData iconData;

  const PaymentRulesToggleHeaderWidget({
    Key key,
    @required this.text,
    @required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            color: StyleColors.BRAND_PRIMARY_20,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 3,
            right: 6,
          ),
          child: Icon(
            iconData,
            size: 5.8,
            color: StyleColors.BRAND_PRIMARY_20,
          ),
        ),
      ],
    );
  }
}
