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
  final IconData spotlightIcon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textColor = StyleColors.BRAND_SECONDARY_50;

    return Container(
      margin: isPrimary ? EdgeInsets.only(bottom: 12) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: StyleColors.BRAND_SECONDARY_40,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Icon(
                    spotlightIcon,
                    color: StyleColors.BRAND_SECONDARY_40,
                    size: 10,
                  ),
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
      ),
    );
  }
}
