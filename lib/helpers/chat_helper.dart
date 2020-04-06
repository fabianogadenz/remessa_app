import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/tab_controller_bloc.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/tab_controller_event.dart';
import 'package:zendesk/zendesk.dart';

class ChatHelper {
  final _tabControllerBloc = GetIt.I<TabControllerBloc>();
  final zendesk = GetIt.I<Zendesk>();
  final i18n = GetIt.I<I18n>();

  openChat() async {
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
      _tabControllerBloc.add(
        ErrorTabEvent(errorMessage: i18n.trans('error', ['chat'])),
      );

      return;
    }
  }
}
