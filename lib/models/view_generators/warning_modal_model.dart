import 'package:flutter/foundation.dart';
import 'package:remessa_app/models/track_event_model.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/v2/core/parsers/action_parser.dart';
import 'package:remessa_app/v2/core/widgets/warning_modal/warning_modal_widget.dart';

class WarningModalModel implements ViewGenerator {
  String title;
  String content;
  String imageURL;
  bool hasCloseButton;
  ac.Action primaryAction;
  ac.Action secondaryAction;
  TrackEvent trackEvent;

  WarningModalModel({
    @required this.title,
    @required this.content,
    @required this.imageURL,
    this.hasCloseButton,
    this.primaryAction,
    this.secondaryAction,
  }) : assert(title != null && content != null && imageURL != null);

  WarningModalModel.fromJson(Map<String, dynamic> json, [this.trackEvent]) {
    title = json['title'];
    content = json['content'];
    imageURL = json['imageURL'];
    hasCloseButton = json['hasCloseButton'] ?? true;
    primaryAction =
        json['action'] != null ? ActionParser.fromJson(json['action']) : null;
    secondaryAction =
        json['action'] != null ? ActionParser.fromJson(json['action']) : null;
  }

  generate() => WarningModalWidget(
        title: this.title,
        content: this.content,
        imageURL: this.imageURL,
        hasCloseButton: this.hasCloseButton,
        primaryAction: this.primaryAction,
        secondaryAction: this.secondaryAction,
      );
}
