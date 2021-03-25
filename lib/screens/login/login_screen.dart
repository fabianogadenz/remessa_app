import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/helpers/url_helper.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/models/utm_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/screens/login/login_screen_store.dart';
import 'package:remessa_app/services/system_service.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/screens.dart';

import 'widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with RouteAware {
  final _loginScreenStore = LoginScreenStore();
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();
  final showStepper = GetIt.I<SystemService>().showStepper;

  @override
  void initState() {
    TrackingEvents.log(TrackingEvents.LOGIN_VIEW);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    navigator.subscribeRoute(this, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    navigator.unsubscribeRoute(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    FlutterUxcam.tagScreenName(UxCamHelper.LOGIN);
  }

  _websiteRedirect(String url, {String log, UTM utm}) {
    if (log != null) TrackingEvents.log(log);

    FocusScope.of(context).requestFocus(FocusNode());

    AppRouter.websiteRedirect(
      url,
      utm: utm,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GetIt.I<Screens>().widget(
        isAccent: true,
        showAppBar: true,
        isStatic: true,
        statusBarBrightness: Brightness.light,
        appBarWidget: AppBar(
          brightness: Brightness.light,
          elevation: 0,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: showStepper
                  ? IconButton(
                      icon: Icon(RemessaIcons.close),
                      color: StyleColors.BRAND_PRIMARY_40,
                      iconSize: 18,
                      onPressed: () {
                        TrackingEvents.log(
                            TrackingEvents.LOGIN_BACK_TO_STEPPER_CLICK);

                        FocusScope.of(context).requestFocus(FocusNode());

                        navigator.pushReplacementNamed(
                          AppRouter.STEPPER_ROUTE,
                        );
                      },
                    )
                  : null,
            ),
          ],
        ),
        padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              i18n.trans('login_screen', ['title']),
              key: Key(LoginScreenKeys.title),
              style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                  ),
              textAlign: TextAlign.start,
            ),
            LoginFormWidget(
              login: _loginScreenStore.login,
            ),
            _buildPrivacyTermsBanner(context),
          ],
        ),
      )
        ..errorStreamController.add(_loginScreenStore.errorMessage)
        ..loaderStreamController.add(_loginScreenStore.isLoading),
    );
  }

  Widget _buildPrivacyTermsBanner(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_20,
        borderRadius: BorderRadius.circular(5),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: StyleColors.BRAND_SECONDARY_50,
          ),
          text: I18n.of(context)
              .trans('login_screen', ['privacy_banner', 'intro']),
          children: [
            TextSpan(
              text: I18n.of(context)
                  .trans('login_screen', ['privacy_banner', 'privacy_policy']),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _websiteRedirect(
                      UrlHelper.PRIVACY_POLICY_URL,
                      utm: UTM(
                        campaign: UTM.PRIVACY_POLICY_TERMS_CAMPAIGN,
                      ),
                      log: TrackingEvents.LOGIN_PRIVACY_POLICY_CLICK,
                    ),
            ),
            TextSpan(
              text: I18n.of(context)
                  .trans('login_screen', ['privacy_banner', 'and']),
            ),
            TextSpan(
              text: I18n.of(context).trans(
                  'login_screen', ['privacy_banner', 'terms_of_service']),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => _websiteRedirect(
                      UrlHelper.TERMS_OF_SERVICE_URL,
                      utm: UTM(
                        campaign: UTM.TERMS_OF_SERVICE_CAMPAIGN,
                      ),
                      log: TrackingEvents.LOGIN_TERMS_OF_SERVICE_CLICK,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
