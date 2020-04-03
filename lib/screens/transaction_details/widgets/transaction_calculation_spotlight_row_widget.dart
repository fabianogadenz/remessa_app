import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCalculationSpotlightRowWidget extends StatelessWidget {
  const TransactionCalculationSpotlightRowWidget({
    Key key,
    this.isPrimary = false,
    this.spotlightIcon,
    @required this.label,
    @required this.value,
  })  : assert(label != null),
        assert(value != null),
        super(key: key);

  final bool isPrimary;
  final Icon spotlightIcon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textColor = isPrimary
        ? StyleColors.BRAND_SECONDARY_80
        : StyleColors.BRAND_SECONDARY_50;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: isPrimary
                    ? StyleColors.BRAND_PRIMARY_40
                    : StyleColors.SUPPORT_NEUTRAL_30,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: spotlightIcon,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
