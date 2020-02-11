import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/models/responses/remote_config_response_model.dart';
import 'package:version/version.dart';

class ConfigService {
  RemoteConfig remoteConfig;
  PackageInfo packageInfo;

  Future<RemoteConfig> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    remoteConfig = await RemoteConfig.instance;

    final defaults = RemoteConfigResponseModel(
      environment: Environment.PROD,
      isUpToDate: true,
      isChatEnabled: true,
    ).toJson();

    await remoteConfig.setDefaults(defaults);

    await remoteConfig.fetch(expiration: const Duration(hours: 5));
    await remoteConfig.activateFetched();

    return remoteConfig;
  }

  _isUpToDate() {
    final minVersion = Version.parse(remoteConfig.getString('minVersion'));
    final currentVersion = Version.parse(packageInfo.version);

    return currentVersion >= minVersion;
  }

  RemoteConfigResponseModel getConfigs() {
    try {
      final configs = {
        'environment': remoteConfig.getString('environment'),
        'isChatEnabled': remoteConfig.getBool('isChatEnabled'),
        'isUpToDate': _isUpToDate(),
      };

      return RemoteConfigResponseModel.fromJson(configs);
    } catch (_) {
      return RemoteConfigResponseModel(
        environment: Environment.PROD,
        isUpToDate: true,
        isChatEnabled: true,
      );
    }
  }
}
