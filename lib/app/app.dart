import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/screens/initial/initial_screen.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_widget.dart';

import 'bloc/bloc.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Remessa Online',
      localizationsDelegates: [
        const I18nDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
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
      home: BlocBuilder<AppBloc, AppState>(
        bloc: AppBloc(),
        builder: (BuildContext context, AppState state) =>
            state.isLoggedIn ? TabControllerWidget() : InitialScreen(),
      ),
    );
  }
}
