import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

class SetUp {
  static initializeIntercom() async {
    await Intercom.initialize(
      'nucbuzqn',
      iosApiKey: 'ios_sdk-a404f625a23cc834f9d2ee079c7b5b2dbdec533e',
      androidApiKey: 'android_sdk-1781b33f946be31caf417d150915e354756a9b8b',
    );
  }

  static initializeGetIt(String apiKey) {
    GetIt.I.registerLazySingleton<AmplitudeFlutter>(
        () => AmplitudeFlutter(apiKey));
  }

  static init() async {
    await SetUp.initializeIntercom();

    SetUp.initializeGetIt('8ee300f20af2c9fb588264714ad2a84d');
  }
}
