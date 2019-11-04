import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:intercom_flutter/intercom_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/enviroment_model.dart';

import 'services/services.dart';

class SetUp {
  final Constants constants;

  SetUp(Environment env) : constants = Constants.get(env);

  _initializeHive() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

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

  _registerServices() async {
    await Services.register();
  }

  init() async {
    await _initializeIntercom();

    await _initializeHive();

    // GetIt registers
    _registerAmplitude();

    await _registerServices();
  }
}
