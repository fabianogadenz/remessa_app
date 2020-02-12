import 'package:flutter/foundation.dart';
import 'package:remessa_app/helpers/environment_model.dart';

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
};
const Map<String, dynamic> release_api = {
  'url': 'https://release-app.beetech.global/v1/app',
};
const Map<String, dynamic> prod_api = {
  'url': 'https://app.beetech.global/v1/app',
};

const Map<String, String> zendesk = {
  'accountKey': '47q7iV5YLFz3pQ0WIjoy2p5S71UzBaaA',
  'department': '1818188829',
  'appName': 'Remessa Online (APP)',
};

final Map<Environment, Constants> constantsMap = {
  Environment.DEV: Constants(
    onesignal: onesignal,
    amplitude: dev_amplitude,
    api: dev_api,
    zendesk: zendesk,
  ),
  Environment.RELEASE: Constants(
    onesignal: onesignal,
    amplitude: dev_amplitude,
    api: release_api,
    zendesk: zendesk,
  ),
  Environment.PROD: Constants(
    onesignal: onesignal,
    amplitude: prod_amplitude,
    api: prod_api,
    zendesk: zendesk,
  ),
};

class Constants {
  final Map<String, String> onesignal;
  final Map<String, String> amplitude;
  final Map<String, dynamic> api;
  final Map<String, String> zendesk;

  Constants({
    @required this.onesignal,
    @required this.amplitude,
    @required this.zendesk,
    @required this.api,
  })  : assert(onesignal != null),
        assert(amplitude != null),
        assert(zendesk != null),
        assert(api != null);

  static Constants get(Environment env) => constantsMap[env];
}
