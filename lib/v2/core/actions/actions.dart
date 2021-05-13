import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/router.dart';

final Map<String, Function> actions = {
  'open_chat': () => ChatHelper.openChat(),
  'go_to_dashboard': () {
    GetIt.I<NavigatorHelper>()
        .pushNamedAndRemoveUntil(AppRouter.DASHBOARD_ROUTE);
  },
  'go_back': () {
    GetIt.I<NavigatorHelper>().pop();
    GetIt.I<NavigatorHelper>().pop();
  },
  'accept_terms': () async {
    await GetIt.I<Dio>().post('/financial-institution/customer/registration');
  },
};
