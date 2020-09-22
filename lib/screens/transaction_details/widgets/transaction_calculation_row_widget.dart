import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCalculationRowWidget extends StatelessWidget {
  const TransactionCalculationRowWidget({
    Key key,
    @required this.label,
    this.labelSpotlight,
    @required this.value,
    this.spotlightList = const [],
    this.spotlightWidgetList = const [],
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
  final List<String> spotlightList;
  final List<SpotlightItemWidget> spotlightWidgetList;
  final Function onTapInfo;
  final bool isSpotlight;
  final Widget labelSuffix;

  bool get _hasSpotlightList =>
      (spotlightList != null && spotlightList.length != 0 ||
          spotlightWidgetList != null && spotlightWidgetList.length > 0);

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

    final rowAlignment = _hasSpotlightList
        ? CrossAxisAlignment.start
        : CrossAxisAlignment.center;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapInfo,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: rowAlignment,
          children: <Widget>[
            Row(
              crossAxisAlignment: rowAlignment,
              children: <Widget>[
                Icon(
                  Icons.info,
                  color: StyleColors.BRAND_PRIMARY_40,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: _hasSpotlightList
                          ? const EdgeInsets.only(top: 2)
                          : null,
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
                    ...(spotlightList ?? []).map(_handleSpotlightItem).toList(),
                    ...(spotlightWidgetList ?? []),
                  ],
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

  Widget _handleSpotlightItem(listItem) => SpotlightItemWidget(
        child: Text(
          listItem,
          style: TextStyle(
            color: StyleColors.SUPPORT_SUCCESS_50,
          ),
        ),
      );
}

class SpotlightItemWidget extends StatelessWidget {
  const SpotlightItemWidget({
    Key key,
    @required this.child,
  })  : assert(child != null),
        super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            vertical: 7,
            horizontal: 5,
          ),
          child: Icon(
            RemessaIcons.dotline,
            color: StyleColors.BRAND_SECONDARY_50,
            size: 12,
          ),
        ),
        child,
      ],
    );
  }
}
