import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/v2/core/actions/actions.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/models/actions/action_model.dart';
import 'package:remessa_app/models/actions/content_action_model.dart';
import 'package:remessa_app/models/actions/link_action_model.dart';

enum ActionType {
  ACTION,
  LINK,
  CONTENT,
}

class ActionParser {
  static final Map<String, ActionType> stringToEnvMap = {
    'action': ActionType.ACTION,
    'link': ActionType.LINK,
    'content': ActionType.CONTENT,
  };

  static ac.Action fromJson(Map<String, dynamic> json) {
    var action;

    switch (stringToEnvMap[json['type']]) {
      case ActionType.ACTION:
        action = ActionModel.fromJson(json);
        break;
      case ActionType.LINK:
        action = LinkActionModel.fromJson(json);
        break;
      case ActionType.CONTENT:
        action = ContentActionModel.fromJson(json);
        break;
      default:
        action = ActionModel.fromJson(json);
        break;
    }

    return action.toAction();
  }

  static Function trackEventFunction(String trackEvent) =>
      (trackEvent != null) ? () => TrackingEvents.logEvent(trackEvent) : null;

  static Function actionFunction(String action) {
    final emptyFunc = () {};
    return (action != null) ? actions[action] ?? emptyFunc : emptyFunc;
  }

  static Function eventAndActionFunction(String trackEvent, String action) =>
      () {
        ActionParser.trackEventFunction(trackEvent)();
        ActionParser.actionFunction(action)();
      };
}
