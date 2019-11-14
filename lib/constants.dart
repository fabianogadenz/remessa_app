import 'package:flutter/foundation.dart';
import 'package:remessa_app/helpers/enviroment_model.dart';

const Map<String, String> intercom = {
  'appId': 'nucbuzqn',
  'iosApiKey': 'ios_sdk-a404f625a23cc834f9d2ee079c7b5b2dbdec533e',
  'androidApiKey': 'android_sdk-1781b33f946be31caf417d150915e354756a9b8b',
};

const Map<String, String> dev_amplitude = {
  'apiKey': '6f3d62af350377ea30276dce3fd9bae2',
};
const Map<String, String> prod_amplitude = {
  'apiKey': '',
};

const Map<String, dynamic> api = {
  'url': 'https://dev-bff.beetech.global/v1/app',
  'timeout': 5000, // 5s
};

final Map<Environment, Constants> constantsMap = {
  Environment.DEV: Constants(
    intercom: intercom,
    amplitude: dev_amplitude,
    api: api,
  ),
  Environment.PROD: Constants(
    intercom: intercom,
    amplitude: prod_amplitude,
    api: api,
  ),
};

class Constants {
  final Map<String, String> intercom;
  final Map<String, String> amplitude;
  final Map<String, dynamic> api;

  Constants({
    @required this.intercom,
    @required this.amplitude,
    @required this.api,
  })  : assert(intercom != null),
        assert(amplitude != null),
        assert(api != null);

  static Constants get(Environment env) => constantsMap[env];
}
