import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:zendesk/zendesk.dart';

final _homeScreenStore = GetIt.I<HomeScreenStore>();
final zendesk = GetIt.I<Zendesk>();
final i18n = GetIt.I<I18n>();

class ChatHelper {
  static openChat() async {
    try {
      final customer = GetIt.I<AuthService>().customer;

      await zendesk.setVisitorInfo(
        email: customer.email,
        name: customer.name,
        phoneNumber: '${customer.countryCode}${customer.mobilePhone}',
        note: 'ID: ${customer.id}\nCPF: ${customer.cpfCnpj}',
      );
      await zendesk.startChat();

      return;
    } catch (_) {
      _homeScreenStore.setErrorMessage(i18n.trans('error', ['chat']));
      return;
    }
  }
}
