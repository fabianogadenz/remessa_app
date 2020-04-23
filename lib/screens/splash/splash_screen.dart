import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/initial_stepper/initial_screen.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_widget.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _appStore = GetIt.I<AppStore>();
  final _authStore = GetIt.I<AuthStore>();
  final navigator = GetIt.I<NavigatorHelper>();
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    try {
      GetIt.I<I18n>();
    } catch (_) {
      SetUp.registerI18n(context);

      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }

    reactionDisposer = autorun(checkAppVersionAndLogin);

    super.initState();
  }

  @override
  dispose() {
    reactionDisposer();
    super.dispose();
  }

  checkAppVersionAndLogin(_) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final i18n = GetIt.I<I18n>();

        if (!(_appStore?.configs?.isUpToDate ?? true)) {
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(
                i18n.trans('error', ['app_version', 'title']),
                style: TextStyle(
                  color: StyleColors.BRAND_PRIMARY_40,
                ),
              ),
              content: Text(
                i18n.trans('error', ['app_version', 'content']),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    i18n.trans('error', ['app_version', 'button']),
                  ),
                  onPressed: () => exit(0),
                ),
              ],
            ),
          );
        } else {
          navigator.pushReplacement(
            _authStore.isLoggedIn ? TabControllerWidget() : InitialScreen(),
          );
        }
      });

  @override
  Widget build(BuildContext context) => ScreenWidget(
        child: Container(),
      );
}
