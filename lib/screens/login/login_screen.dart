import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/initial_stepper/initial_stepper_screen.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/screens/login/login_screen_store.dart';
import 'package:remessa_app/services/system_service.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/login_form_widget.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: close_sinks
  final _loginScreenStore = LoginScreenStore();

  final i18n = GetIt.I<I18n>();

  final navigator = GetIt.I<NavigatorHelper>();

  final amplitude = GetIt.I<AmplitudeFlutter>();

  final showStepper = GetIt.I<SystemService>().showStepper;

  final useTermsUrl = 'https://www.remessaonline.com.br/termos-de-uso';

  final privacyPolicyUrl =
      'https://www.remessaonline.com.br/politica-de-privacidade';

  @override
  void initState() {
    TrackEvents.log(TrackEvents.LOGIN_VIEW);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => ScreenWidget(
          isAccent: true,
          showAppBar: true,
          isStatic: true,
          appBarWidget: AppBar(
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
                          TrackEvents.log(
                              TrackEvents.LOGIN_BACK_TO_STEPPER_CLICK);

                          navigator.pushReplacement(
                            InitialStepperScreen(),
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
                cpf: _loginScreenStore.cpf,
              ),
              _buildPrivacyTermsBanner(context),
            ],
          ),
        )
          ..errorStreamController.add(_loginScreenStore.errorMessage)
          ..loaderStreamController.add(_loginScreenStore.isLoading),
      );

  Container _buildPrivacyTermsBanner(BuildContext context) {
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
              .trans('login_screen', ['privacyBanner', 'intro']),
          children: [
            TextSpan(
              text: I18n.of(context)
                  .trans('login_screen', ['privacyBanner', 'privacyPolicy']),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  TrackEvents.log(TrackEvents.LOGIN_PRIVACY_POLICY_CLICK);
                  launch(privacyPolicyUrl);
                },
            ),
            TextSpan(
              text: I18n.of(context)
                  .trans('login_screen', ['privacyBanner', 'and']),
            ),
            TextSpan(
              text: I18n.of(context)
                  .trans('login_screen', ['privacyBanner', 'useTerms']),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  TrackEvents.log(TrackEvents.LOGIN_USE_TERMS_CLICK);
                  launch(useTermsUrl);
                },
            ),
          ],
        ),
      ),
    );
  }
}
