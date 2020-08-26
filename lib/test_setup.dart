import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/services/auth_service.dart';

class MockDio extends Mock implements HttpClientAdapter {}

class MockAuthService implements AuthService {
  @override
  get customer => Customer(id: 54321);

  @override
  bool get isLoggedIn => throw UnimplementedError();

  @override
  login(String cpf, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  void saveUser(String token, Customer customer) {}

  @override
  String get token => throw UnimplementedError();

  @override
  removeUserIdentity() {
    throw UnimplementedError();
  }

  @override
  setUserIdentity(Customer customer) {
    throw UnimplementedError();
  }

  @override
  Future<void> setUxCamUserIdentity(Customer customer) {
    throw UnimplementedError();
  }
}

class TestSetUp {
  static init() async {
    final i18n = I18n(Locale('pt'));

    final sentencesMock = {
      'error': {
        'network_connection': 'Erro de conexão',
      },
    };

    await i18n.load(sentencesMock);

    final mDio = MockDio();

    GetIt.I.registerLazySingleton<I18n>(
      () => i18n,
    );

    GetIt.I.registerLazySingleton<AuthService>(
      () => MockAuthService(),
    );

    GetIt.I.registerLazySingleton<MockDio>(
      () => mDio,
    );

    GetIt.I.registerLazySingleton<Dio>(
      () => Dio()..httpClientAdapter = mDio,
    );
  }
}
