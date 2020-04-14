import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/style/colors.dart';

class ModalHelper {
  static void showInfoBottomSheet(
      BuildContext context, String title, String description,
      [Icon icon]) {
    TrackEvents.log(
      TrackEvents.TRANSACTION_CALCULATION_INFO_CLICK,
      {'label': title},
    );

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) => Container(
        color: StyleColors.BRAND_PRIMARY_60,
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    icon ??
                        Icon(
                          Icons.attach_money,
                          size: 20,
                        ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: StyleColors.SUPPORT_NEUTRAL_10,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: StyleColors.BRAND_PRIMARY_50,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Icon(
                        Icons.close,
                        color: StyleColors.SUPPORT_NEUTRAL_10,
                        size: 18,
                      ),
                    ),
                    onTap: () => Navigator.pop(context))
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
