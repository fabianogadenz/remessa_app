import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/models/responses/remote_config_response_model.dart';

class RemoteConfigService {
  static getConfigVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    return '${packageInfo.version.replaceAll('.', '')}${packageInfo.buildNumber}';
  }

  static Future<RemoteConfigResponseModel> getConfigs(
      String configVersion) async {
    try {
      final constants = Constants.get(Environment.PROD);

      Response response = await Dio().get(
        '${constants.api['url']}/remote-config/$configVersion',
      );

      return RemoteConfigResponseModel.fromJson(response.data);
    } catch (_) {
      return RemoteConfigResponseModel(
        environment: Environment.PROD,
        isActive: true,
      );
    }
  }
}
