import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

class TestSetUp {
  static init() async {
    final i18n = I18n(Locale('pt'));

    final sentencesMock = {
      'error': {
        'network_connection': 'Erro de conexão',
      },
    };

    await i18n.load(sentencesMock);

    GetIt.I.registerLazySingleton<I18n>(
      () => i18n,
    );

    GetIt.I.registerLazySingleton<Dio>(
      () => Dio(),
    );
  }
}
