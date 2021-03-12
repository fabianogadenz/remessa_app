import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/cached_network_image_widget.dart';

class CurrencyItemWidget extends StatelessWidget {
  const CurrencyItemWidget({
    Key key,
    this.currencyImageUrl,
    this.currencyName,
    this.currencyAcronym,
    this.onTap,
  }) : super(key: key);

  final String currencyImageUrl;
  final String currencyName;
  final String currencyAcronym;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 32,
                        height: 32,
                        child: CachedNetworkImageWigdet(
                          imageURL: currencyImageUrl,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  currencyName,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StyleColors.BRAND_SECONDARY_50,
                  ),
                ),
              ],
            ),
            Text(
              currencyAcronym,
              style: TextStyle(
                color: StyleColors.BRAND_SECONDARY_50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
