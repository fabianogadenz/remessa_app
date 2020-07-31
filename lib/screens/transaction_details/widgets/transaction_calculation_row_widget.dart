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
    this.isSpotlight = false,
    this.labelSuffix,
  })  : assert(label != null),
        assert(value != null),
        super(key: key);

  final String label;
  final String labelSpotlight;
  final String value;
  final String oldValue;
  final Function onTapInfo;
  final bool isSpotlight;
  final Widget labelSuffix;

  @override
  Widget build(BuildContext context) {
    final _values = <Widget>[];
    final textStyle = TextStyle(
      fontSize: 14,
      fontWeight: isSpotlight ? FontWeight.w600 : FontWeight.normal,
      color: StyleColors.BRAND_SECONDARY_50,
    );

    if (oldValue != null) {
      _values.addAll(
        [
          Text(
            oldValue,
            style: TextStyle(
              color: StyleColors.BRAND_SECONDARY_30,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            value,
            style: TextStyle(
              color: StyleColors.SUPPORT_SUCCESS_50,
            ),
          ),
        ],
      );
    } else {
      _values.add(
        Text(
          value,
          style: textStyle,
        ),
      );
    }

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
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
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Container(
                  child: RichText(
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
                                  160,
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
                ),
                SizedBox(
                  width: labelSuffix != null ? 4 : 0,
                ),
                labelSuffix ?? Container(),
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
