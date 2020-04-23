import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/initial_stepper/initial_screen.dart';
import 'package:remessa_app/screens/splash/splash_screen.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/theme.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_widget.dart';

class App extends StatelessWidget {
  final reactionDesposer = reaction(
    (_) => GetIt.I<AuthStore>().isLoggedIn,
    (bool isLoggedIn) => GetIt.I<NavigatorHelper>().pushReplacement(
      isLoggedIn ? TabControllerWidget() : InitialScreen(),
    ),
  );

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
      navigatorKey: GetIt.I<NavigatorHelper>().navigatorKey,
      home: SplashScreen(),
    );
  }
}
