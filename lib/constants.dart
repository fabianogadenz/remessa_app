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

final Map<Environment, Constants> constantsMap = {
  Environment.DEV: Constants(
    intercom: intercom,
    amplitude: dev_amplitude,
  ),
  Environment.PROD: Constants(
    intercom: intercom,
    amplitude: prod_amplitude,
  ),
};

class Constants {
  final Map<String, String> intercom;
  final Map<String, String> amplitude;

  Constants({
    @required this.intercom,
    @required this.amplitude,
  })  : assert(intercom != null),
        assert(amplitude != null);

  static Constants get(Environment env) => constantsMap[env];
}
