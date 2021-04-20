import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/core/widgets/list_menu_widget.dart';
import 'package:remessa_app/v2/core/widgets/text_header_widget.dart';
import 'package:remessa_app/v2/modules/profile/view/widgets/profile_info_widget.dart';

class ProfileScreen extends StatelessWidget {
  final Customer customer;
  final I18n i18n;
  final bool isChatEnabled;
  final Function openChat;
  final Function logout;

  const ProfileScreen({
    Key key,
    @required this.i18n,
    @required this.customer,
    @required this.openChat,
    @required this.logout,
    this.isChatEnabled = true,
  })  : assert(i18n != null),
        assert(customer != null),
        assert(openChat != null),
        assert(logout != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextHeaderWidget(
              label: i18n.trans('profile'),
            ),
            ProfileInfoWidget(customer: customer),
            SizedBox(height: 48),
            ListMenuWidget(
              menuItems: [
                isChatEnabled
                    ? MenuItem(
                        icon: Icon(
                          RemessaIcons.chat,
                          size: 18,
                        ),
                        label: i18n.trans('chat'),
                        action: () {
                          TrackingEvents.log(
                              TrackingEvents.DASHBOARD_LOGOUT_CLICK);
                          openChat();
                        },
                      )
                    : null,
                MenuItem(
                  icon: Icon(
                    RemessaIcons.logout,
                    size: 14,
                  ),
                  label: i18n.trans('exit'),
                  hasSuffix: false,
                  action: () {
                    TrackingEvents.log(TrackingEvents.DASHBOARD_HELP_TAB_CLICK);
                    logout();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
