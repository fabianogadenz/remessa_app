import 'package:flutter/foundation.dart';
import 'package:remessa_app/helpers/enviroment_model.dart';

const Map<String, String> onesignal = {
  'appId': 'b2f1b437-2038-499a-8cd6-b22afe57daa9',
};

const Map<String, String> dev_amplitude = {
  'apiKey': '6f3d62af350377ea30276dce3fd9bae2',
};
const Map<String, String> prod_amplitude = {
  'apiKey': 'ee6caed71b8515f3aabc21b4d3582a19',
};

const Map<String, dynamic> dev_api = {
  'url': 'https://dev-app.beetech.global/v1/app',
  'timeout': 5000, // 5s
};
const Map<String, dynamic> release_api = {
  'url': 'https://release-app.beetech.global/v1/app',
  'timeout': 5000, // 5s
};
const Map<String, dynamic> prod_api = {
  'url': 'https://app.beetech.global/v1/app',
  'timeout': 5000, // 5s
};

final Map<Environment, Constants> constantsMap = {
  Environment.DEV: Constants(
    onesignal: onesignal,
    amplitude: dev_amplitude,
    api: dev_api,
  ),
  Environment.RELEASE: Constants(
    onesignal: onesignal,
    amplitude: dev_amplitude,
    api: release_api,
  ),
  Environment.PROD: Constants(
    onesignal: onesignal,
    amplitude: prod_amplitude,
    api: prod_api,
  ),
};

class Constants {
  final Map<String, String> onesignal;
  final Map<String, String> amplitude;
  final Map<String, dynamic> api;

  Constants({
    @required this.onesignal,
    @required this.amplitude,
    @required this.api,
  })  : assert(onesignal != null),
        assert(amplitude != null),
        assert(api != null);

  static Constants get(Environment env) => constantsMap[env];
}
