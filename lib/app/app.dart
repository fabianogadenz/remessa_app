import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/screens/initial/initial_screen.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/theme.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_widget.dart';

class App extends StatelessWidget {
  final _appStore = GetIt.I<AppStore>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remessa Online',
      localizationsDelegates: [
        I18nDelegate(locales: ['pt']),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        // const Locale('en', ''),
        const Locale('pt', ''),
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) return supportedLocales.first;

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme(),
      home: Builder(builder: (BuildContext context) {
        try {
          GetIt.I<I18n>();
        } catch (_) {
          SetUp.registerI18n(context);

          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
          ]);
        }

        return Observer(builder: (_) {
          if (!(_appStore?.configs?.isUpToDate ?? true)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final i18n = GetIt.I<I18n>();

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
            });
          }

          return _appStore.isLoggedIn ? TabControllerWidget() : InitialScreen();
        });
      }),
    );
  }
}
