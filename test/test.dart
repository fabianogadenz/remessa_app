import 'package:amplitude_flutter/amplitude.dart';
import 'package:dio/dio.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:screens/screen_widget.dart';

class MockAmplitude extends Mock implements Amplitude {}

class MockDio extends Mock implements HttpClientAdapter {}

class MockAuthService extends Mock implements AuthService {}

class MockAppStore extends Mock implements AppStore {}

class MockSimulatorStore extends Mock implements SimulatorStore {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class Test {
  static final mockObserver = MockNavigatorObserver();

  static Future<void> init() async {
    final remoteConfigs = ConfigModel(environment: Environment.TEST);

    await SetUp(remoteConfigs).init();

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

    GetIt.I.registerLazySingleton<Amplitude>(
      () => MockAmplitude(),
    );

    GetIt.I.registerLazySingleton<AuthService>(
      () {
        final mockAuthService = MockAuthService();

        when(mockAuthService.customer).thenAnswer(
          (_) async => Customer(id: 123456),
        );

        return mockAuthService;
      },
    );

    GetIt.I.registerLazySingleton<MockDio>(
      () => mDio,
    );

    GetIt.I.registerLazySingleton<Dio>(
      () => Dio()..httpClientAdapter = mDio,
    );

    GetIt.I.registerLazySingleton<NavigatorHelper>(
      () => NavigatorHelper(),
    );

    GetIt.I.registerLazySingleton<AppStore>(
      () => MockAppStore(),
    );
  }

  static widget(WidgetTester tester, Widget widget) async {
    final navigator = GetIt.I<NavigatorHelper>();
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenWidget(
          child: widget,
        ),
        navigatorKey: navigator.navigatorKey,
        navigatorObservers: [navigator.routeObserver, mockObserver],
      ),
    );
  }
}
