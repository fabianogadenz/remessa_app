import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/helpers/snowplow_helper.dart';
import 'package:remessa_app/services/auth_service.dart';

import '../../test.dart';

void main() async {
  await Test.init();

  group('SnowplowHelper', () {
    group('track', () {
      test(
        'should set userId',
        () async {
          final snowplow = SnowplowHelper();
          final userId = 123456;

          when(GetIt.I<MockDio>().fetch(any, any, any)).thenAnswer((i) async {
            expect(i.positionalArguments[0].data['userId'], userId);
            return Future.value(ResponseBody.fromString('', 200));
          });

          snowplow.setUserId(userId);

          final response =
              await snowplow.track(category: '', action: '', label: '');

          expect(response.statusCode, 200);
        },
      );

      test(
        'should set default userId',
        () async {
          final snowplow = SnowplowHelper();
          final customer = await GetIt.I<AuthService>().customer;

          when(GetIt.I<MockDio>().fetch(any, any, any)).thenAnswer((i) async {
            expect(
              i.positionalArguments[0].data['userId'],
              customer?.id,
            );
            return Future.value(ResponseBody.fromString('', 200));
          });

          final response =
              await snowplow.track(category: '', action: '', label: '');

          expect(response.statusCode, 200);
        },
      );

      test(
        'should set params',
        () async {
          final snowplow = SnowplowHelper();
          final category = 'category';
          final action = 'action';
          final label = 'label';

          when(GetIt.I<MockDio>().fetch(any, any, any)).thenAnswer((i) async {
            expect(i.positionalArguments[0].data['category'], category);
            expect(i.positionalArguments[0].data['action'], action);
            expect(i.positionalArguments[0].data['label'], label);

            return Future.value(ResponseBody.fromString('', 200));
          });

          final response = await snowplow.track(
              category: category, action: action, label: label);

          expect(response.statusCode, 200);
        },
      );

      test(
        'should not throw error if missing params',
        () async {
          final snowplow = SnowplowHelper();

          when(GetIt.I<MockDio>().fetch(any, any, any)).thenAnswer((i) async {
            return Future.value(ResponseBody.fromString('', 200));
          });

          // ignore: missing_required_param
          final response = await snowplow.track();

          expect(response.statusCode, 200);
        },
      );

      test(
        'should throw error if missing params (verbose mode)',
        () async {
          final snowplow = SnowplowHelper(verbose: true);

          when(GetIt.I<MockDio>().fetch(any, any, any)).thenAnswer((i) async {
            return Future.value(ResponseBody.fromString('', 200));
          });

          // ignore: missing_required_param
          expect(snowplow.track(), throwsAssertionError);
        },
      );
    });
  });
}
