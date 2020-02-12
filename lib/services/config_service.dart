import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/models/config_model.dart';

class ConfigService {
  RemoteConfig remoteConfig;
  PackageInfo packageInfo;

  Future<RemoteConfig> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    remoteConfig = await RemoteConfig.instance;

    try {
      await remoteConfig.fetch(expiration: const Duration(hours: 5));
      await remoteConfig.activateFetched();
    } catch (e) {
      final defaults = ConfigModel(
        environment: Environment.PROD,
      ).toJson();

      await remoteConfig.setDefaults(defaults);
    }

    return remoteConfig;
  }

  ConfigModel getConfigs() {
    try {
      return ConfigModel.create(remoteConfig, packageInfo);
    } catch (_) {
      return ConfigModel(
        environment: Environment.PROD,
        isUpToDate: true,
        isChatEnabled: true,
      );
    }
  }
}
