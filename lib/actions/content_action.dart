import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:remessa_app/actions/action.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/services/view_generator_service.dart';

class ContentAction extends Action {
  final String name;
  final Object content;
  final String url;
  final bool isReplacement;
  Function action;

  ContentAction({
    @required this.name,
    this.content,
    this.url,
    this.isReplacement = false,
    Function prevAction,
  })  : assert(content != null || url != null),
        super(
          name: name,
          actionFunction: () async {
            Function navigatorFunction = GetIt.I<NavigatorHelper>().pushNamed;

            if (isReplacement ?? false) {
              navigatorFunction =
                  GetIt.I<NavigatorHelper>().pushReplacementNamed;
            }

            ViewGenerator arguments;

            if (url != null) {
              arguments = await ViewGeneratorService.getViewGenerator(url);
            } else {
              arguments = ViewModel.fromJson(content);
            }

            return navigatorFunction(
              AppRouter.GENERATED_VIEW_ROUTE,
              arguments: arguments,
            );
          },
          prevAction: prevAction,
        );
}
