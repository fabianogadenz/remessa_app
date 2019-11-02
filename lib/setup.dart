import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/utils/enviroment_model.dart';

class SetUp {
  final Constants constants;

  SetUp(Environment env) : constants = Constants.get(env);

  _initializeIntercom() async {
    await Intercom.initialize(
      constants.intercom['appId'],
      iosApiKey: constants.intercom['iosApiKey'],
      androidApiKey: constants.intercom['androidApiKey'],
    );
  }

  _registerAmplitude() {
    GetIt.I.registerLazySingleton<AmplitudeFlutter>(
      () => AmplitudeFlutter(
        constants.amplitude['apiKey'],
      ),
    );
  }

  init() async {
    await _initializeIntercom();

    _registerAmplitude();
  }
}
