import 'package:flutter/material.dart';

class AppTheme {
  final Color _primaryBlue = const Color(0xff2244ff);
  final Color _secundaryBlue = const Color(0xff0096ff);

  ThemeData get theme => ThemeData.light().copyWith(
        primaryColor: _primaryBlue,
        accentColor: Colors.white,
        scaffoldBackgroundColor: _primaryBlue,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
          button: TextStyle(
            color: _secundaryBlue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ).apply(
          fontFamily: 'OpenSans',
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.accent,
          padding: EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100),
          ),
        ),
      );
}
