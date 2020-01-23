import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/models/responses/remote_config_response_model.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/test_setup.dart';
import 'package:test/test.dart';

void main() async {
  final remoteConfigs =
      RemoteConfigResponseModel(environment: Environment.TEST);

  await SetUp(remoteConfigs).init();

  group('ErrorHelper', () {
    group('parseErrorResponse', () {
      test(
        'should handle empty DioError',
        () => expect(ErrorHelper.parseErrorResponse(DioError()), []),
      );
      test(
        'should handle DioError with empty response',
        () => expect(
          ErrorHelper.parseErrorResponse(
            DioError(response: Response()),
          ),
          [],
        ),
      );
      test(
        'should handle DioError with response but empty data',
        () => expect(
          ErrorHelper.parseErrorResponse(
            DioError(response: Response(data: null)),
          ),
          [],
        ),
      );
      test(
        'should handle DioError with response but data as a empty object',
        () => expect(
          ErrorHelper.parseErrorResponse(
            DioError(response: Response(data: {})),
          ),
          [],
        ),
      );
      test(
        'should handle DioError with response but data as a empty array',
        () => expect(
          ErrorHelper.parseErrorResponse(
            DioError(response: Response(data: [])),
          ),
          [],
        ),
      );

      test('should handle DioError with valid error', () {
        final errorJson = ErrorResponseModel(
          code: '123',
          field: 'field_name',
          message: 'Error message!',
        ).toJson();

        expect(
          ErrorHelper.parseErrorResponse(
            DioError(
              response: Response(
                data: [errorJson],
              ),
            ),
          ),
          [ErrorResponseModel.fromJson(errorJson)],
        );
      });
    });

    group('formatError', () {
      final mainError = ErrorResponseModel(message: 'Error message!');
      final fieldError = ErrorResponseModel(
        message: 'Field error messageq!',
        field: 'field_name',
      );

      test(
        'should handle only a mainError',
        () => expect(
          ErrorHelper.formatError(
            [mainError],
          ),
          ErrorModel(mainError: mainError, fieldErrors: []),
        ),
      );

      test(
        'should handle mainError and fieldError',
        () => expect(
          ErrorHelper.formatError(
            [mainError, fieldError],
          ),
          ErrorModel(mainError: mainError, fieldErrors: [fieldError]),
        ),
      );

      test(
        'should handle mainError and multiple fieldError',
        () => expect(
          ErrorHelper.formatError(
            [mainError, fieldError, fieldError],
          ),
          ErrorModel(mainError: mainError, fieldErrors: [
            fieldError,
            fieldError,
          ]),
        ),
      );

      test('should handle multiple mainError (consider the last one)', () {
        final secondMainError =
            ErrorResponseModel(message: 'Second error message!');

        expect(
          ErrorHelper.formatError(
            [mainError, secondMainError],
          ),
          ErrorModel(mainError: secondMainError, fieldErrors: []),
        );
      });
    });

    group('dioErrorInterceptor', () {
      final i18n = GetIt.I<I18n>();

      test('should handle SocketException', () async {
        final dio = MockDio();

        when(dio.request('network_connection'))
            .thenAnswer((_) async => throw SocketException(''));

        final DioError error = await ErrorHelper.dioErrorInterceptor(
          DioError(
            request: RequestOptions(path: 'network_connection'),
            error: SocketException(''),
          ),
        );

        expect(
          error.error,
          DioError(
            error: i18n.trans('error', ['network_connection']),
          ).error,
        );
      });
    });
  });
}
