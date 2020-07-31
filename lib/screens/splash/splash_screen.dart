import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/services/config_service.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/screens.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _appStore = GetIt.I<AppStore>();
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

    TrackEvents.log(TrackEvents.SPLASH_VIEW);

    super.initState();
  }

  @override
  dispose() {
    reactionDisposer();
    super.dispose();
  }

  checkAppVersionAndLogin(_) =>
      WidgetsBinding.instance.addPostFrameCallback((_) async {
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
          await Future.delayed(Duration(milliseconds: 300));
          navigator.pushReplacementNamed(Router.CHECK_LOGIN_ROUTE);
        }
      });

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isStatic: true,
      child: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 200,
                child: Image.asset(
                  'images/full_icon.png',
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(30),
              child: Text(
                'v${GetIt.I<ConfigService>().packageInfo.version}',
                style: TextStyle(
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
