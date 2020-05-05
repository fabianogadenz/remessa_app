import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCalculationRowWidget extends StatelessWidget {
  const TransactionCalculationRowWidget({
    Key key,
    @required this.label,
    this.labelSpotlight,
    @required this.value,
    this.oldValue,
    this.onTapInfo,
  })  : assert(label != null),
        assert(value != null),
        super(key: key);

  final String label;
  final String labelSpotlight;
  final String value;
  final String oldValue;
  final Function onTapInfo;

  @override
  Widget build(BuildContext context) {
    final _values = <Widget>[];

    if (oldValue != null) {
      _values.addAll([
        Text(
          oldValue,
          style: TextStyle(
            fontSize: 12,
            color: StyleColors.BRAND_SECONDARY_30,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        SizedBox(
          width: 3,
        ),
        Container(
          padding: EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 6,
          ),
          decoration: BoxDecoration(
            color: StyleColors.BRAND_PRIMARY_40,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: StyleColors.SUPPORT_NEUTRAL_10,
            ),
          ),
        ),
      ]);
    } else {
      _values.add(
        Text(
          value,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: StyleColors.BRAND_SECONDARY_50,
          ),
        ),
      );
    }

    final textStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: StyleColors.BRAND_SECONDARY_50,
    );

    return GestureDetector(
      onTap: onTapInfo,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.info,
                  color: StyleColors.BRAND_PRIMARY_40,
                  size: 17,
                ),
                SizedBox(
                  width: 6,
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: '$label ',
                    children: [
                      TextSpan(
                        text: labelSpotlight != null
                            ? StringHelper
                                .handleLimiterWithEllipsisFromTextWidthAndStyle(
                                labelSpotlight,
                                205,
                                textStyle,
                              )
                            : null,
                        style: TextStyle(
                          color: StyleColors.BRAND_PRIMARY_40,
                        ),
                      ),
                    ],
                    style: textStyle,
                  ),
                ),
              ],
            ),
            Row(
              children: _values,
            )
          ],
        ),
      ),
    );
  }
}
