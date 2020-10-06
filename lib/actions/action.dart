import 'package:flutter/foundation.dart';
import 'package:remessa_app/router.dart';

class LinkAction {
  final String name;
  final String url;
  Function action;

  LinkAction({
    @required this.name,
    @required this.url,
    Function prevAction,
  }) {
    assert(name != null);
    assert(url != null);

    action = () {
      if (prevAction != null) {
        prevAction();
      }

      AppRouter.websiteRedirect(url);
    };
  }
}
