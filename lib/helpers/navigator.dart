import 'package:flutter/material.dart';

class NavigatorHelper {
  static push(BuildContext context, Widget screen) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  static isCurrent(BuildContext context) => ModalRoute.of(context).isCurrent;
}
