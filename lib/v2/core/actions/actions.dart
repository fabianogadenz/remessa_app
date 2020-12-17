import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/stores/info_store.dart';

final Map<String, Function> actions = {
  'open_chat': () => ChatHelper.openChat(),
  'go_to_dashboard': () {
    GetIt.I<InfoStore>().setShown(true);
    GetIt.I<NavigatorHelper>()
        .pushNamedAndRemoveUntil(AppRouter.DASHBOARD_ROUTE);
  }
};
