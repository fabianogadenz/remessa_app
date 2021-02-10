import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/parsers/action_parser.dart';
import 'package:remessa_app/screens/info_stepper/info_stepper_screen.dart';

class InfoStepperModel implements ViewGenerator {
  List<InfoStepper> steppers;
  bool showAppBar = false;

  InfoStepperModel({this.showAppBar, this.steppers});

  InfoStepperModel.fromJson(Map<String, dynamic> json) {
    showAppBar = json['showAppBar'] ?? false;
    if (json['steppers'] != null) {
      steppers = List<InfoStepper>();
      json['steppers'].forEach((v) {
        steppers.add(InfoStepper.fromJson(v));
      });
    }
  }

  generate() => InfoStepperScreen(
        model: this,
      );
}

class InfoStepper {
  InfoStepperHeader header;
  String title;
  String content;
  String imageURL;
  ac.Action action;
  ac.Action linkAction;

  InfoStepper({
    this.header,
    this.title,
    this.content,
    this.imageURL,
    this.action,
    this.linkAction,
  });

  InfoStepper.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null
        ? new InfoStepperHeader.fromJson(json['header'])
        : null;
    title = json['title'];
    content = json['content'];
    imageURL = json['imageURL'];
    action =
        json['action'] != null ? ActionParser.fromJson(json['action']) : null;
    linkAction = json['linkAction'] != null
        ? ActionParser.fromJson(json['linkAction'])
        : null;
  }
}

class InfoStepperHeader {
  String title;
  InfoStepperHeaderLink link;

  InfoStepperHeader({this.title, this.link});

  InfoStepperHeader.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'] != null
        ? new InfoStepperHeaderLink.fromJson(json['link'])
        : null;
  }
}

class InfoStepperHeaderLink {
  String prefix;
  ac.Action linkAction;

  InfoStepperHeaderLink({this.prefix, this.linkAction});

  InfoStepperHeaderLink.fromJson(Map<String, dynamic> json) {
    prefix = json['prefix'];
    linkAction = json['linkAction'] != null
        ? ActionParser.fromJson(json['linkAction'])
        : null;
  }
}
