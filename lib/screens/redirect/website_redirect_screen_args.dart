import 'package:flutter/foundation.dart';

class WebsiteRedirectScreenArgs {
  final String url;
  final String title;
  final String description;

  const WebsiteRedirectScreenArgs({
    @required this.url,
    this.title,
    this.description,
  }) : assert(url != null);
}
