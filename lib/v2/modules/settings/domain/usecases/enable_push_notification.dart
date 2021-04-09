import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';

class EnablePushNotification implements CommandUseCase<bool, Future<void>> {
  final NotificationPreferencesRepository _notificationPreferencesRepository;
  final Customer Function() _getCustomer;
  final void Function(Customer) _updateCustomer;

  EnablePushNotification(
    this._notificationPreferencesRepository,
    this._getCustomer,
    this._updateCustomer,
  );

  @override
  Future<void> call(bool enabled) async {
    await _notificationPreferencesRepository.enablePush(enabled);

    final customer = _getCustomer();

    customer.pushNotificationsEnabled = enabled;

    _updateCustomer(customer);
  }
}
