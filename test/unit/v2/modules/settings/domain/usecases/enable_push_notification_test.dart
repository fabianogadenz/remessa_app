import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';
import 'package:remessa_app/v2/modules/settings/domain/usecases/enable_push_notification.dart';

import '../../../../../../mocks/modules/transaction/infra/data/repositories/repositories_mock.dart';

main() {
  group('EnablePushNotification', () {
    CommandUseCase<bool, Future<void>> usecase;
    NotificationPreferencesRepository repository;

    Customer customer = Customer();

    Customer _getCustomerMock() => customer;

    void _updateCustomer(Customer _customer) {
      customer = _customer;
    }

    setUp(() {
      repository = NotificationPreferencesRepositoryMock();
      usecase = EnablePushNotification(
        repository,
        _getCustomerMock,
        _updateCustomer,
      );
    });

    test('Should return without throw', () async {
      final enabled = faker.randomGenerator.boolean();

      when(repository.enablePush(any)).thenAnswer(
        (_) async {},
      );

      expect(usecase(enabled), completion(isNull));
    });

    test('Should set pushNotificationsEnabled as expected', () async {
      final enabled = faker.randomGenerator.boolean();

      when(repository.enablePush(any)).thenAnswer(
        (_) async {},
      );

      await usecase(enabled);

      expect(customer.pushNotificationsEnabled, enabled);
    });
  });
}
