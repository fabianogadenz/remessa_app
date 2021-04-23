import 'package:remessa_app/models/track_event_model.dart';
import 'package:remessa_app/v2/core/actions/content_action.dart';
import 'package:remessa_app/v2/core/parsers/action_parser.dart';

class ContentActionModel {
  String label;
  Object content;
  String url;
  bool isReplacement;
  TrackEvent trackEvent;
  String action;

  ContentActionModel({
    this.label,
    this.content,
    this.isReplacement,
    this.trackEvent,
    this.action,
  });

  ContentActionModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    content = json['content'];
    url = json['url'];
    isReplacement = json['isReplacement'];
    action = json['action'];

    if (json['trackEvent'] != null) {
      trackEvent = TrackEvent.fromJson(json['trackEvent']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['content'] = this.content;
    data['url'] = this.url;
    data['isReplacement'] = this.isReplacement;
    data['trackEvent'] = this.trackEvent;
    data['action'] = this.action;
    return data;
  }

  ContentAction toAction() => ContentAction(
        name: this.label,
        content: this.content,
        url: this.url,
        isReplacement: isReplacement,
        prevAction: ActionParser.eventAndActionFunction(trackEvent, action),
      );
}
