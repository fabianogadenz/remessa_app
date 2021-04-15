import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter_factory.dart';
import 'package:remessa_app/v2/core/factory/factory.dart';
import 'package:remessa_app/v2/modules/settings/application/presenters/notification_preferences_presenter.dart';
import 'package:remessa_app/v2/modules/settings/domain/usecases/enable_push_notification.dart';
import 'package:remessa_app/v2/modules/settings/infra/data/repositories/notification_preferences_repository.dart';

class NotificationPreferencesPresenterFactory
    implements Factory<NotificationPreferencesPresenter> {
  final _httpAdapterFactory = HttpAdapterFactory();

  @override
  NotificationPreferencesPresenter call() {
    final authService = GetIt.I<AuthService>();

    final _transactionRepository = NotificationPreferencesRepositoryImpl(
      _httpAdapterFactory(),
    );

    return NotificationPreferencesPresenter(
      EnablePushNotification(
        _transactionRepository,
        () async => authService.customer,
        authService.updateCustomer,
      ),
    );
  }
}
