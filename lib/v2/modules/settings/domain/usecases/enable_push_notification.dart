import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';

class EnablePushNotification implements CommandUseCase<bool, Future<void>> {
  final NoticationPreferencesRepository _notificationPreferencesRepository;
  final AuthService _authService;

  EnablePushNotification(
    this._notificationPreferencesRepository,
    this._authService,
  );

  @override
  Future<void> call(bool enabled) async {
    await _notificationPreferencesRepository.enablePush(enabled);

    final customer = _authService.customer;

    customer.pushNotificationsEnabled = enabled;

    _authService.updateCustomer(customer);
  }
}
