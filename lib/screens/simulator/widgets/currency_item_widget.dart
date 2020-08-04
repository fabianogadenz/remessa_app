import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

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
                        child: CachedNetworkImage(
                          imageUrl: currencyImageUrl,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Center(
                            child: Icon(
                              Icons.error,
                              size: 14,
                              color: StyleColors.SUPPORT_DANGER_40,
                            ),
                          ),
                          fit: BoxFit.fill,
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
