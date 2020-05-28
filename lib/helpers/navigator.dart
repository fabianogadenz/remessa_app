import 'package:flutter/material.dart';

class NavigatorHelper {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  dynamic pop() => navigatorKey.currentState.pop();

  Future<dynamic> push(Widget screen) => navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  Future<dynamic> pushReplacement(Widget screen) =>
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  static isCurrent(BuildContext context) => ModalRoute.of(context).isCurrent;
}
