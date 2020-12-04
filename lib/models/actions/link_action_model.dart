import 'package:remessa_app/actions/link_action.dart';
import 'package:remessa_app/parsers/action_parser.dart';

class LinkActionModel {
  String label;
  String url;
  String trackEvent;

  LinkActionModel({
    this.label,
    this.url,
    this.trackEvent,
  });

  LinkActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    url = json['url'];
    trackEvent = json['trackEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['url'] = this.url;
    data['trackEvent'] = this.trackEvent;
    return data;
  }

  LinkAction toAction() => LinkAction(
        name: this.label,
        url: this.url,
        prevAction: ActionParser.trackEventFunction(trackEvent),
      );
}