import 'package:flutter/foundation.dart';

class Action {
  final String name;
  Function action;

  Action({
    @required this.name,
    Function actionFunction,
    Function prevAction,
  }) {
    action = () {
      if (prevAction != null) {
        prevAction();
      }

      actionFunction();
    };
  }
}
