import 'package:flutter/material.dart';

class NavigatorHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  dynamic pop() => navigatorKey.currentState.pop();

  Future<dynamic> push(Widget screen) => navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  Future<dynamic> pushNamed(String routeName, {Object arguments}) =>
      navigatorKey.currentState.pushNamed(routeName, arguments: arguments);

  Future<dynamic> pushReplacement(Widget screen) =>
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  Future<dynamic> pushReplacementNamed(String routeName) =>
      navigatorKey.currentState.pushReplacementNamed(routeName);

  static bool isCurrent(BuildContext context) =>
      ModalRoute.of(context).isCurrent;

  static T getArgs<T>(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;
}
