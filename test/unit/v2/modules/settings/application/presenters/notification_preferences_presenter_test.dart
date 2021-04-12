import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/errors/error_message.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/settings/application/presenters/notification_preferences_presenter.dart';
import 'package:remessa_app/v2/modules/settings/application/viewmodels/notification_preferences_viewmodel.dart';

import '../../../../../../mocks/modules/settings/domain/usecases/usecases_mock.dart';

main() {
  group('NotificationPreferencesPresenter', () {
    CommandUseCase<bool, Future<void>> enablePushNotification;
    NotificationPreferencesPresenter notificationPreferencesPresenter;

    setUp(() {
      enablePushNotification = EnablePushNotificationMock();
      notificationPreferencesPresenter = NotificationPreferencesPresenter(
        enablePushNotification,
      );
    });

    group('enablePushNotification', () {
      test('if update succeeds, errorMessage should be empty', () async {
        final notificationPreferences = NotificationPreferencesViewModel(
          enablePushNotification: faker.randomGenerator.boolean(),
        );

        when(enablePushNotification.call(any)).thenAnswer(
          (_) async {},
        );

        await notificationPreferencesPresenter
            .updateNoficiationPreferences(notificationPreferences);

        expect(notificationPreferencesPresenter.errorMessage, null);
      });

      test('if update throws, errorMessage should have the expected string',
          () async {
        final notificationPreferences = NotificationPreferencesViewModel(
          enablePushNotification: faker.randomGenerator.boolean(),
        );

        final errorStr = faker.randomGenerator.string(10);

        when(enablePushNotification.call(any))
            .thenThrow(ErrorMessage(errorStr));

        await notificationPreferencesPresenter
            .updateNoficiationPreferences(notificationPreferences);

        expect(notificationPreferencesPresenter.errorMessage, errorStr);
      });
    });
  });
}
