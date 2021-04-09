import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter_dio.dart';
import 'package:remessa_app/v2/core/errors/error_message.dart';

class DioMock extends Mock implements Dio {}

main() {
  group('HttpAdapterDio', () {
    HttpAdapter adapter;
    Dio _dio;

    setUp(() {
      _dio = DioMock();
      adapter = HttpAdapterDio(_dio);
    });

    group('get', () {
      test('Should call params correctly', () async {
        final params = {'teste': 1};

        when(_dio.get(any, queryParameters: params))
            .thenAnswer((realInvocation) async => Response());

        expect(
          adapter.get('/', params: params),
          completion(isNull),
        );
      });

      test(
          'Should throw an ErrorMessage when handle a DioError with a single error',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.get(any)).thenThrow(
          DioError(error: errorStr),
        );

        expect(adapter.get('/'), throwsA(predicate((e) => e is ErrorMessage)));
      });

      test(
          'Should throw an ErrorModel when handle a DioError with strutured response',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.get(any)).thenThrow(
          DioError(
            response: Response(
              data: [
                {
                  'message': errorStr,
                }
              ],
            ),
          ),
        );

        expect(
          adapter.get('/'),
          throwsA(
            predicate(
              (e) => e is ErrorModel && e.mainError.message == errorStr,
            ),
          ),
        );
      });

      test('Should throws when Dio throws unknow error', () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.get(any)).thenThrow(errorStr);

        expect(adapter.get('/'), throwsA(anything));
      });

      test('Should return expected value of type <T>', () async {
        final str = faker.randomGenerator.string(10);

        when(_dio.get<String>(any)).thenAnswer(
          (_) async => Response(data: str),
        );

        expect(adapter.get<String>('/'), completion(str));
      });

      test('Should throw if return value is not <T>', () async {
        when(_dio.get(any)).thenAnswer(
          (_) async => Response(data: null),
        );

        expect(adapter.get<String>('/'),
            throwsA(predicate((e) => e is TypeError)));
      });
    });

    group('post', () {
      test('Should call data correctly', () async {
        final data = {'teste': 1};

        when(_dio.post(any, data: data))
            .thenAnswer((realInvocation) async => Response());

        expect(
          adapter.post('/', data: data),
          completion(isNull),
        );
      });

      test(
          'Should throw an ErrorMessage when handle a DioError with a single error',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.post(any)).thenThrow(
          DioError(error: errorStr),
        );

        expect(adapter.post('/'), throwsA(predicate((e) => e is ErrorMessage)));
      });

      test(
          'Should throw an ErrorModel when handle a DioError with strutured response',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.post(any)).thenThrow(
          DioError(
            response: Response(
              data: [
                {
                  'message': errorStr,
                }
              ],
            ),
          ),
        );

        expect(
          adapter.post('/'),
          throwsA(
            predicate(
              (e) => e is ErrorModel && e.mainError.message == errorStr,
            ),
          ),
        );
      });

      test('Should throws when Dio throws unknow error', () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.post(any)).thenThrow(errorStr);

        expect(adapter.post('/'), throwsA(anything));
      });

      test('Should return expected value of type <T>', () async {
        final str = faker.randomGenerator.string(10);

        when(_dio.post<String>(any)).thenAnswer(
          (_) async => Response(data: str),
        );

        expect(adapter.post<String>('/'), completion(str));
      });

      test('Should throw if return value is not <T>', () async {
        when(_dio.post(any)).thenAnswer(
          (_) async => Response(data: null),
        );

        expect(adapter.post<String>('/'),
            throwsA(predicate((e) => e is TypeError)));
      });
    });

    group('put', () {
      test('Should call data correctly', () async {
        final data = {'teste': 1};

        when(_dio.put(any, data: data))
            .thenAnswer((realInvocation) async => Response());

        expect(
          adapter.put('/', data: data),
          completion(isNull),
        );
      });

      test(
          'Should throw an ErrorMessage when handle a DioError with a single error',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.put(any)).thenThrow(
          DioError(error: errorStr),
        );

        expect(adapter.put('/'), throwsA(predicate((e) => e is ErrorMessage)));
      });

      test(
          'Should throw an ErrorModel when handle a DioError with strutured response',
          () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.put(any)).thenThrow(
          DioError(
            response: Response(
              data: [
                {
                  'message': errorStr,
                }
              ],
            ),
          ),
        );

        expect(
          adapter.put('/'),
          throwsA(
            predicate(
              (e) => e is ErrorModel && e.mainError.message == errorStr,
            ),
          ),
        );
      });

      test('Should throws when Dio throws unknow error', () async {
        final errorStr = faker.randomGenerator.string(10);

        when(_dio.put(any)).thenThrow(errorStr);

        expect(adapter.put('/'), throwsA(anything));
      });

      test('Should return expected value of type <T>', () async {
        final str = faker.randomGenerator.string(10);

        when(_dio.post<String>(any)).thenAnswer(
          (_) async => Response(data: str),
        );

        expect(adapter.post<String>('/'), completion(str));
      });

      test('Should throw if return value is not <T>', () async {
        when(_dio.put(any)).thenAnswer(
          (_) async => Response(data: null),
        );

        expect(adapter.put<String>('/'),
            throwsA(predicate((e) => e is TypeError)));
      });
    });
  });
}
