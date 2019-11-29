import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/screens/login/bloc/bloc.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  // ignore: close_sinks
  final _loginScreenBloc = LoginScreenBloc();
  final i18n = GetIt.I<I18n>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginScreenBloc, LoginScreenState>(
        bloc: _loginScreenBloc,
        listener: (BuildContext context, LoginScreenState state) {
          if (state.success) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<LoginScreenBloc, LoginScreenState>(
          bloc: _loginScreenBloc,
          builder: (context, state) {
            return ScreenWidget(
              isAccent: true,
              showAppBar: true,
              isStatic: true,
              appBarText: i18n.trans('enter'),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    i18n.trans('login_screen', ['title']),
                    key: Key(LoginScreenKeys.title),
                    style: Theme.of(context).textTheme.body2,
                    textAlign: TextAlign.start,
                  ),
                  LoginFormWidget(
                    loginScreenBloc: _loginScreenBloc,
                    formState: state.formState,
                  ),
                  _buildPrivacyTermsBanner(context),
                ],
              ),
            )
              ..errorStreamController.add(state.errorMessage)
              ..loaderStreamController.add(state.isLoading);
          },
        ));
  }

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
                    launch(
                        'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
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
                    launch(
                        'https://docs.flutter.io/flutter/services/UrlLauncher-class.html');
                  },
              ),
            ]),
      ),
    );
  }
}
