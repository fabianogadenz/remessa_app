import 'package:flutter/foundation.dart';

class WebsiteRedirectScreenArgs {
  final String url;
  final String title;
  final String description;
  final Note note;

  const WebsiteRedirectScreenArgs({
    @required this.url,
    this.title,
    this.description,
    this.note,
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
