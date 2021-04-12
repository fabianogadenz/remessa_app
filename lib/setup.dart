import 'dart:io';

import 'package:amplitude_flutter/amplitude.dart';
import 'package:dio/dio.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/snowplow_helper.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/screens/home/home_screen_store.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/config_service.dart';
import 'package:remessa_app/services/services.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/stores/info_store.dart';
import 'package:remessa_app/stores/timer_animation_store.dart';
import 'package:remessa_app/v2/core/widgets/error_dialog/error_dialog_widget.dart';
import 'package:screens/screens.dart';
import 'package:zendesk/zendesk.dart';

class SetUp {
  final Constants constants;
  final ConfigModel configs;

  SetUp(this.configs) : constants = Constants.get(configs.environment) {
    GetIt.I.registerSingleton<Constants>(constants);
  }

  static Future<ConfigService> registerConfig() async {
    final configService = ConfigService();
    await configService.init();

    GetIt.I.registerLazySingleton<ConfigService>(
      () => configService,
    );

    return configService;
  }

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

    OneSignal.shared.setNotificationOpenedHandler((openedResult) {
      TrackingEvents.log(TrackingEvents.PUSH_NOTIFICATION_OPENED);

      final additionalData =
          openedResult?.notification?.payload?.additionalData;

      if (additionalData != null) {
        if (additionalData['transactionId'] != null)
          GetIt.I<AppStore>().setTransactionId(additionalData['transactionId']);
      }
    });
  }

  _initializeUxCam() {
    if (!configs.isUxCamEnabled) return;

    FlutterUxcam.optIntoSchematicRecordings();
    FlutterUxcam.startWithKey(constants.uxcam['key']);
  }

  _initializeHive() async {
    await Hive.initFlutter();
  }

  _registerAmplitude() {
    GetIt.I.registerLazySingleton<Amplitude>(
      () => Amplitude.getInstance()..init(constants.amplitude['apiKey']),
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
      appName: constants.zendesk['appName'],
      department: constants.zendesk['department'],
    );

    GetIt.I.registerLazySingleton<Zendesk>(
      () => zendesk,
    );
  }

  _registerServices() async {
    await Services.register(constants);
  }

  _registerStores() {
    GetIt.I.registerLazySingleton<AppStore>(
      () => AppStore(configs),
    );

    GetIt.I.registerLazySingleton<AuthStore>(
      () => AuthStore(),
    );

    GetIt.I.registerLazySingleton<InfoStore>(
      () => InfoStore(),
    );

    GetIt.I.registerLazySingleton<HomeScreenStore>(
      () => HomeScreenStore(),
    );

    GetIt.I.registerLazySingleton<TimerAnimationStore>(
      () => TimerAnimationStore(),
    );
  }

  _registerDio() {
    Dio dio = Dio(); // with default Options

    // Set default configs
    dio.options.baseUrl = constants.api['url'];
    dio.options.connectTimeout = configs.timeout;
    dio.options.receiveTimeout = configs.timeout;

    GetIt.I.registerLazySingleton<Dio>(
      () => dio,
    );
  }

  _registerHelpers() {
    GetIt.I.registerLazySingleton<NavigatorHelper>(
      () => NavigatorHelper(),
    );

    GetIt.I.registerLazySingleton<SnowplowHelper>(
      () => SnowplowHelper(verbose: configs.environment != Environment.PROD),
    );
  }

  _registerScreens() {
    GetIt.I.registerLazySingleton<Screens>(
      () => Screens(
        fixedOverlayWidgets: [
          configs.isEnvironmentFlagEnabled &&
                  configs.environment != Environment.PROD
              ? Container(
                  alignment: Alignment.topRight,
                  child: Banner(
                    message: configs.environment.toString().split('.').last,
                    location: BannerLocation.topEnd,
                  ),
                )
              : Container(),
        ],
        errorOverlay: ErrorOverlay(),
      ),
    );
  }

  _registerDioInterceptors() {
    GetIt.I<Dio>().interceptors.add(
          InterceptorsWrapper(
            onRequest: (requestOptions) => GetIt.I<AuthStore>().isLoggedIn
                ? requestOptions.headers.addAll(
                    {
                      'Authorization': 'Bearer ${GetIt.I<AuthService>().token}',
                      'x-app-version':
                          GetIt.I<ConfigService>()?.packageInfo?.version,
                    },
                  )
                : null,
            onError: (DioError dioError) {
              if (configs.environment != Environment.PROD) print(dioError);
              return ErrorHelper.dioErrorInterceptor(dioError);
            },
            onResponse: (configs.environment != Environment.PROD)
                ? (response) => print(response)
                : null,
          ),
        );
  }

  init() async {
    if (configs.environment == Environment.TEST) {
      _registerScreens();

      return;
    }

    if ([Environment.PROD, Environment.RELEASE].contains(configs.environment)) {
      // Pass all uncaught errors from the framework to Crashlytics.
      FlutterError.onError = Crashlytics.instance.recordFlutterError;
    }

    await _initializeHive();

    await _registerZendesk();

    // GetIt registers
    _registerAmplitude();

    _registerDio();

    _registerHelpers();

    await _registerServices();

    _registerStores();

    await _registerOneSignal();

    _registerScreens();

    _registerDioInterceptors();

    _initializeUxCam();
  }
}
