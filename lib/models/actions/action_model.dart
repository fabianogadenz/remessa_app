import 'package:remessa_app/actions/action.dart' as ac;
import 'package:remessa_app/parsers/action_parser.dart';

class ActionModel {
  String type;
  String label;
  String action;
  String trackEvent;

  ActionModel({
    this.label,
    this.action,
    this.trackEvent,
  });

  ActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    action = json['action'];
    trackEvent = json['trackEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['action'] = this.action;
    data['trackEvent'] = this.trackEvent;
    return data;
  }

  ac.Action toAction() => ac.Action(
        name: this.label,
        actionFunction: ActionParser.actionFunction(action),
        prevAction: ActionParser.trackEventFunction(trackEvent),
      );
}
