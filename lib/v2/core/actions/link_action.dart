import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/router.dart';

class LinkAction extends ac.Action {
  final String name;
  final String url;
  Function(BuildContext context) action;

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
