import 'package:flutter/foundation.dart';
import 'package:remessa_app/models/utm_model.dart';

class WebsiteRedirectScreenArgs {
  final String url;
  final String title;
  final String description;
  final Note note;
  final UTM utm;

  const WebsiteRedirectScreenArgs({
    @required this.url,
    this.title,
    this.description,
    this.note,
    this.utm = const UTM(),
  }) : assert(url != null);
}

class Note {
  final String title;
  final String description;

  const Note({
    this.title,
    this.description,
  })  : assert(title != null),
        assert(description != null);
}
