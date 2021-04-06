import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/v2/core/actions/error_action.dart';

class Action {
  final String name;
  Function action;

  Action({
    @required this.name,
    Function actionFunction,
    Function prevAction,
  }) {
    action = (BuildContext context) async {
      try {
        if (prevAction != null) {
          await prevAction();
        }

        await actionFunction();
      } on ErrorModel catch (e) {
        ActionErrorNotification(e?.mainError?.message).dispatch(context);
      } catch (e) {
        ActionErrorNotification(e?.message).dispatch(context);
      }
    };
  }
}
