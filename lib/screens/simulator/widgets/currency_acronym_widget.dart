import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/skeleton_line_widget.dart';

class CurrencyAcronymWidget extends StatelessWidget {
  const CurrencyAcronymWidget({
    Key key,
    @required this.currencyAcronym,
    this.isChangeable = false,
    this.isLoading = false,
  }) : super(key: key);

  final String currencyAcronym;
  final bool isChangeable;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SkeletonLineWidget(
            color: StyleColors.BRAND_SECONDARY_10,
            width: 40,
            height: 11,
          )
        : Row(
            children: <Widget>[
              currencyAcronym != null && currencyAcronym.isNotEmpty
                  ? Text(
                      currencyAcronym,
                      style: TextStyle(
                        color: StyleColors.BRAND_PRIMARY_80,
                        fontSize: 24,
                      ),
                    )
                  : Container(),
              isChangeable
                  ? Row(
                      children: <Widget>[
                        SizedBox(
                          width: 6,
                        ),
                        Icon(
                          RemessaIcons.arrow_down,
                          color: Colors.blue,
                          size: 6,
                        ),
                      ],
                    )
                  : Container(),
            ],
          );
  }
}
