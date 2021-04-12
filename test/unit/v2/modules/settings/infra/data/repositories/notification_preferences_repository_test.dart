import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/modules/settings/domain/repositories/notification_preferences_repository.dart';
import 'package:remessa_app/v2/modules/settings/infra/data/repositories/notification_preferences_repository.dart';

import '../../../../../../../mocks/core/adapters/http_adapter_mock.dart';

main() {
  group('NotificationPreferencesRepository', () {
    NotificationPreferencesRepository repository;
    HttpAdapter httpAdapter;

    setUp(() {
      httpAdapter = HttpAdapterMock();
      repository = NotificationPreferencesRepositoryImpl(httpAdapter);
    });

    group('enablePush', () {
      test(
          'Should not throw errror, and call the correctly path, if run correctly setting enable as false',
          () {
        when(
          httpAdapter.post('/customer/enable-push-notifications'),
        ).thenAnswer((_) async {});

        expect(
          repository.enablePush(false),
          completion(isNull),
        );
      });

      test(
          'Should not throw errror, and call the correctly path, if run correctly setting enable as true',
          () {
        when(
          httpAdapter.post('/customer/disable-push-notifications'),
        ).thenAnswer((_) async {});

        expect(
          repository.enablePush(true),
          completion(isNull),
        );
      });
    });
  });
}
