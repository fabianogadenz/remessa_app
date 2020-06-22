import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:screens/custom_overlay.dart';

class DetailRecurrenceButtonOverlayWidget implements CustomOverlay {
  @override
  Widget build(_, url, {screenWidget}) => Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 23, vertical: 23),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                StyleColors.SUPPORT_NEUTRAL_10.withOpacity(0),
                StyleColors.SUPPORT_NEUTRAL_10,
              ],
            ),
          ),
          child: GradientButtonWidget(
              height: 50,
              label: GetIt.I<I18n>().trans('send_again'),
              hasShadow: true,
              onPressed: () {
                TrackEvents.log(TrackEvents.TRANSACTION_REPEAT_CLICK);
                GetIt.I<NavigatorHelper>().pushNamed(
                  Router.WEBSITE_REDIRECT_ROUTE,
                  arguments: WebsiteRedirectScreenArgs(
                    url: url,
                  ),
                );
              }),
        ),
      );
}
