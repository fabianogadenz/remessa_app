import 'dart:io';

import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:dio/dio.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/services/services.dart';
import 'package:remessa_app/test_setup.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';
import 'package:zendesk/zendesk.dart';

class SetUp {
  final Constants constants;
  final ConfigModel configs;

  SetUp(this.configs) : constants = Constants.get(configs.environment);

  static registerI18n(BuildContext context) {
    GetIt.I.registerLazySingleton<I18n>(
      () => Localizations.of<I18n>(context, I18n),
    );
  }

  static startOneSignal() async {
    final askPermission = await OneSignal.shared.requiresUserPrivacyConsent();

    if (askPermission) {
      bool allowed = true;

      if (Platform.isIOS) {
        allowed = await OneSignal.shared
            .promptUserForPushNotificationPermission(fallbackToSettings: true);
      }

      await OneSignal.shared.consentGranted(allowed);
    }
  }

  _initializeHive() async {
    await Hive.initFlutter();
  }

  _registerAmplitude() {
    GetIt.I.registerLazySingleton<AmplitudeFlutter>(
      () => AmplitudeFlutter(
        constants.amplitude['apiKey'],
      ),
    );
  }

  _registerOneSignal() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.init(
      constants.onesignal['appId'],
      iOSSettings: {
        OSiOSSettings.autoPrompt: true,
        OSiOSSettings.inAppLaunchUrl: true
      },
    );

    await OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);

    await startOneSignal();
  }

  _registerZendesk() async {
    final Zendesk zendesk = Zendesk();

    await zendesk.init(
      constants.zendesk['accountKey'],
      department: constants.zendesk['department'],
      appName: constants.zendesk['appNName'],
    );

    GetIt.I.registerLazySingleton<Zendesk>(
      () => zendesk,
    );
  }

  _registerServices() async {
    await Services.register();
  }

  _registerStores() {
    GetIt.I.registerLazySingleton<AppStore>(
      () => AppStore(configs),
    );

    GetIt.I.registerLazySingleton<TabControllerBloc>(
      () => TabControllerBloc(),
    );
  }

  _registerDio() {
    Dio dio = Dio(); // with default Options

    // Set default configs
    dio.options.baseUrl = constants.api['url'];
    dio.options.connectTimeout = configs.timeout;
    dio.options.receiveTimeout = configs.timeout;

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError dioError) =>
            ErrorHelper.dioErrorInterceptor(dioError),
        onResponse: (configs.environment != Environment.PROD)
            ? (response) => print(response)
            : null,
      ),
    );

    GetIt.I.registerLazySingleton<Dio>(
      () => dio,
    );
  }

  init() async {
    if (configs.environment == Environment.TEST) {
      await TestSetUp.init();
      return;
    }

    if ([Environment.PROD, Environment.RELEASE].contains(configs.environment)) {
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError = Crashlytics.instance.recordFlutterError;
    }

    await _initializeHive();

    await _registerOneSignal();

    await _registerZendesk();

    // GetIt registers
    _registerAmplitude();

    _registerDio();

    await _registerServices();

    _registerStores();
  }
}
