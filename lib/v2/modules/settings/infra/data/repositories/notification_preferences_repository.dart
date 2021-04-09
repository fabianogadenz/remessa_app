import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';

class NotificationPreferencesRepositoryImpl
    implements NotificationPreferencesRepository {
  final HttpAdapter httpAdapter;

  NotificationPreferencesRepositoryImpl(this.httpAdapter);

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
