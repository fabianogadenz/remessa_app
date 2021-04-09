import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';

class NoticationPreferencesRepositoryImpl
    implements NoticationPreferencesRepository {
  final HttpAdapter httpAdapter;

  NoticationPreferencesRepositoryImpl(this.httpAdapter);

  _handleEnable() async {
    await httpAdapter.post('/customer/enable-push-notifications');
  }

  _handleDisable() async {
    await httpAdapter.post('/customer/disable-push-notifications');
  }

  @override
  Future<void> enablePush(bool enabled) async {
    if (enabled) {
      await _handleEnable();
    } else {
      await _handleDisable();
    }
  }
}
