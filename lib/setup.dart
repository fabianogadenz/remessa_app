import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remessa_app/app/bloc/app_bloc.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/enviroment_model.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/helpers/helpers.dart';
import 'package:remessa_app/widgets/tab_controller/bloc/bloc.dart';

import 'services/services.dart';

class SetUp {
  final Constants constants;

  SetUp(Environment env) : constants = Constants.get(env);

  _initializeHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  _registerAmplitude() {
    GetIt.I.registerLazySingleton<AmplitudeFlutter>(
      () => AmplitudeFlutter(
        constants.amplitude['apiKey'],
      ),
    );
  }

  _registerOneSignal() async {
    await OneSignal.shared.init(
      constants.onesignal['appId'],
      iOSSettings: {
        OSiOSSettings.autoPrompt: false,
        OSiOSSettings.inAppLaunchUrl: true
      },
    );

    await OneSignal.shared
        .setInFocusDisplayType(OSNotificationDisplayType.notification);
  }

  _registerServices() async {
    await Services.register();
  }

  _registerBlocs() {
    GetIt.I.registerLazySingleton<AppBloc>(
      () => AppBloc(),
    );

    GetIt.I.registerLazySingleton<TabControllerBloc>(
      () => TabControllerBloc(),
    );
  }

  _registerDio() {
    Dio dio = Dio(); // with default Options

    // Set default configs
    dio.options.baseUrl = constants.api['url'];
    dio.options.connectTimeout = constants.api['timeout'];
    dio.options.receiveTimeout = constants.api['timeout'];

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioError dioError) =>
            ErrorHelper.dioErrorInterceptor(dioError),
      ),
    );

    GetIt.I.registerLazySingleton<Dio>(
      () => dio,
    );
  }

  static registerI18n(BuildContext context) {
    GetIt.I.registerLazySingleton<I18n>(
      () => Localizations.of<I18n>(context, I18n),
    );
  }

  init() async {
    await _initializeHive();

    await _registerOneSignal();

    // GetIt registers
    _registerAmplitude();

    _registerDio();

    await _registerServices();

    _registerBlocs();
  }
}
