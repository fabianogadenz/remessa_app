import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/actions/link_action.dart';
import 'package:remessa_app/v2/core/constants/image_contants.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/core/widgets/promotional_card_widget.dart';
import 'package:remessa_app/v2/core/widgets/outline_button_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  final i18n = GetIt.I<I18n>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(
        title: i18n.trans('checkout', ['success_screen', 'title']),
        steps: 3,
        currentStep: 3,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                ImageConstants.CHECKOUT_SUCCESS_ILLUSTRATION,
                height: 240,
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24) +
                  const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  Text(
                    i18n.trans('checkout', ['success_screen', 'subtitle']),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    i18n.trans('checkout', ['success_screen', 'content']),
                    style: TextStyle(
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  PromotionalCardWidget(
                    title: i18n
                        .trans('checkout', ['success_screen', 'mgm', 'title']),
                    content: i18n.trans(
                        'checkout', ['success_screen', 'mgm', 'content']),
                    iconData: RemessaIcons.percent,
                    action: LinkAction(
                      name: i18n.trans(
                          'checkout', ['success_screen', 'mgm', 'action']),
                      prevAction: () {
                        TrackingEvents.log(
                            TrackingEvents.CHECKOUT_INVITE_FRIENDS_CLICK);
                      },
                      url:
                          'https://www.remessaonline.com.br/app/perfil/convide',
                    ),
                  ),
                  SizedBox(height: 32),
                  OutlineButtonWidget(
                    label: i18n.trans('checkout', ['success_screen', 'action']),
                    isAccent: true,
                    onPressed: () {
                      TrackingEvents.log(
                          TrackingEvents.CHECKOUT_GO_TO_REMITTANCES_CLICK);
                      GetIt.I<NavigatorHelper>().pushNamedAndRemoveUntil(
                        AppRouter.DASHBOARD_ROUTE,
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
