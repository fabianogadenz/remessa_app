import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class AppTheme {
  static ThemeData theme() => ThemeData.light().copyWith(
        primaryColor: StyleColors.BRAND_PRIMARY_40,
        accentColor: StyleColors.SUPPORT_NEUTRAL_10,
        scaffoldBackgroundColor: StyleColors.BRAND_PRIMARY_60,
        textTheme: TextTheme(
          title: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w300,
          ),
          headline: TextStyle(
            fontSize: 18,
          ),
          body2: TextStyle(
            color: StyleColors.BRAND_PRIMARY_80,
            fontSize: 20,
          ),
          button: TextStyle(
            color: StyleColors.SUPPORT_NEUTRAL_10,
            fontWeight: FontWeight.bold,
          ),
        ).apply(
          fontFamily: 'OpenSans',
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
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
          color: Colors.white,
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
      );
}
