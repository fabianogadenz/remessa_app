import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
        fontFamily: 'OpenSans',
        primaryColor: StyleColors.BRAND_PRIMARY_40,
        accentColor: StyleColors.SUPPORT_NEUTRAL_10,
        scaffoldBackgroundColor: StyleColors.BRAND_PRIMARY_60,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 30,
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w300,
          ),
          subtitle: TextStyle(
            fontSize: 28,
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.w300,
          ),
          headline: TextStyle(
            fontSize: 18,
            color: StyleColors.SUPPORT_NEUTRAL_10,
          ),
          body2: TextStyle(
            color: StyleColors.BRAND_PRIMARY_80,
            fontSize: 20,
          ),
          button: TextStyle(
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: StyleColors.SUPPORT_NEUTRAL_10,
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: StyleColors.BRAND_PRIMARY_60,
          textTheme: ButtonTextTheme.accent,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(100),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: StyleColors.SUPPORT_NEUTRAL_10,
          iconTheme: IconThemeData(
            color: StyleColors.BRAND_PRIMARY_40,
          ),
          textTheme: TextTheme(
            title: TextStyle(
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
            borderRadius: new BorderRadius.circular(10),
          ),
        ),
      );
}
