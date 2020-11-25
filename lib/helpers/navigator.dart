import 'package:flutter/material.dart';

class NavigatorHelper {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  void subscribeRoute(RouteAware routeAware, BuildContext context) {
    try {
      routeObserver.subscribe(routeAware, ModalRoute.of(context));
    } catch (e) {
      // Throw error when navigate to no ModalRoute
    }
  }

  void unsubscribeRoute(RouteAware routeAware) {
    routeObserver.unsubscribe(routeAware);
  }

  dynamic pop() => navigatorKey.currentState.pop();

  Future<dynamic> push(Widget screen) => navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  Future<dynamic> pushNamed(String routeName, {Object arguments}) =>
      navigatorKey.currentState.pushNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic> pushReplacement(Widget screen) =>
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(
          builder: (context) => screen,
        ),
      );

  Future<dynamic> pushReplacementNamed(String routeName, {Object arguments}) =>
      navigatorKey.currentState.pushReplacementNamed(
        routeName,
        arguments: arguments,
      );

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
          {bool Function(Route<dynamic>) predicate, Object arguments}) =>
      navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName,
        predicate ?? (_) => false,
        arguments: arguments,
      );

  static bool isCurrent(BuildContext context) =>
      ModalRoute.of(context).isCurrent;

  static T getArgs<T>(BuildContext context) =>
      ModalRoute.of(context).settings.arguments;
}
