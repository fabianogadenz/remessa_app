import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/stores/info_store.dart';

final Map<String, Function> actions = {
  'accept_new_terms': () => print('accept_new_terms'),
  'go_to_dashboard': () {
    GetIt.I<InfoStore>().setShown(true);
    GetIt.I<NavigatorHelper>()
        .pushNamedAndRemoveUntil(AppRouter.DASHBOARD_ROUTE);
  }
};
