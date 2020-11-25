import 'package:flutter/foundation.dart';
import 'package:remessa_app/actions/action.dart' as ac;
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/parsers/action_parser.dart';
import 'package:remessa_app/screens/info/info_screen.dart';

class InfoModel implements ViewGenerator {
  String title;
  String content;
  String imageURL;
  ac.Action action;

  InfoModel({
    @required this.title,
    @required this.content,
    @required this.imageURL,
    @required this.action,
  }) : assert(title != null &&
            content != null &&
            imageURL != null &&
            action != null);

  InfoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    imageURL = json['imageURL'];
    action =
        json['action'] != null ? ActionParser.fromJson(json['action']) : null;
  }

  generate() => InfoScreen(
        model: this,
      );
}
