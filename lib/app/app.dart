import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/theme.dart';

class App extends StatelessWidget {
  final reactionDesposer = reaction(
    (_) => GetIt.I<AuthStore>().isLoggedIn,
    (bool isLoggedIn) => GetIt.I<NavigatorHelper>()
        .pushReplacementNamed(Router.CHECK_LOGIN_ROUTE),
  );
  final navigator = GetIt.I<NavigatorHelper>();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

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
      navigatorKey: navigator.navigatorKey,
      navigatorObservers: [navigator.routeObserver],
      initialRoute: Router.SPLASH_ROUTE,
      routes: Router.routes(),
      onGenerateRoute: Router.onGenerateRoute(),
    );
  }
}