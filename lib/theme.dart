import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: StyleColors.BRAND_PRIMARY_40,
        accentColor: StyleColors.SUPPORT_NEUTRAL_10,
        scaffoldBackgroundColor: StyleColors.BRAND_PRIMARY_60,
        canvasColor: StyleColors.SUPPORT_NEUTRAL_60,
        brightness: Brightness.light,
        textTheme: TextTheme(
          headline6: TextStyle(
            fontSize: 30,
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w300,
          ),
          subtitle2: TextStyle(
            fontSize: 28,
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w300,
          ),
          headline5: TextStyle(
            fontSize: 18,
            color: StyleColors.SUPPORT_NEUTRAL_10,
          ),
          bodyText1: TextStyle(
            color: StyleColors.BRAND_PRIMARY_80,
            fontSize: 20,
          ),
          button: TextStyle(
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        iconTheme: IconThemeData(
          color: StyleColors.SUPPORT_NEUTRAL_10,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: StyleColors.BRAND_PRIMARY_40,
          textTheme: ButtonTextTheme.accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: StyleColors.SUPPORT_NEUTRAL_10,
          iconTheme: IconThemeData(
            color: StyleColors.BRAND_PRIMARY_40,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: StyleColors.BRAND_PRIMARY_80,
            ),
          ),
          elevation: 0.5,
        ),
        cardTheme: CardTheme(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
