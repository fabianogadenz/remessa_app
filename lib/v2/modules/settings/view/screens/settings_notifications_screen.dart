import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';

class SettingsNotificationsScreen extends StatelessWidget {
  const SettingsNotificationsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccentAppBarWidget(
        title: i18n.trans('notifications'),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    color: StyleColors.SUPPORT_NEUTRAL_30,
                  ),
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      i18n.trans('allow_notifications'),
                      style: TextStyle(
                        color: StyleColors.BRAND_SECONDARY_50,
                        fontSize: 14,
                      ),
                    ),
                    Container(
                      height: 20,
                      child: Switch(
                        value: true,
                        onChanged: (value) {},
                        activeTrackColor: StyleColors.BRAND_PRIMARY_40,
                        activeColor: StyleColors.BRAND_PRIMARY_60,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
