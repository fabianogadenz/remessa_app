import 'package:flutter/foundation.dart';

import 'package:remessa_app/actions/action.dart';
import 'package:remessa_app/router.dart';

class LinkAction extends Action {
  final String name;
  final String url;
  Function action;

  LinkAction({
    @required this.name,
    @required this.url,
    Function prevAction,
  }) : super(
          name: name,
          actionFunction: () => AppRouter.websiteRedirect(url),
          prevAction: prevAction,
        );
}
