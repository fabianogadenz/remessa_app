import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:version/version.dart';

class ConfigModel {
  bool isUpToDate = true;
  Environment environment;
  bool isChatEnabled = true;
  bool isEnvironmentFlagEnabled = true;
  bool isUxCamEnabled = false;
  int timeout = 20000;

  ConfigModel({
    this.isUpToDate = true,
    this.environment,
    this.isChatEnabled = true,
    this.isEnvironmentFlagEnabled = true,
    this.isUxCamEnabled = false,
    this.timeout = 20000,
  });

  _isUpToDate(String minVersionStr, String currentVersionStr) {
    final minVersion = Version.parse(minVersionStr);
    final currentVersion = Version.parse(currentVersionStr);

    return currentVersion >= minVersion;
  }

  ConfigModel.create(RemoteConfig remoteConfig, PackageInfo packageInfo) {
    isUpToDate =
        _isUpToDate(remoteConfig.getString('minVersion'), packageInfo.version);
    environment =
        EnvironmentModel.stringToEnv(remoteConfig.getString('environment'));
    isChatEnabled = remoteConfig.getBool('isChatEnabled');
    isEnvironmentFlagEnabled = remoteConfig.getBool('isEnvironmentFlagEnabled');
    isUxCamEnabled = remoteConfig.getBool('isUxCamEnabled');

    final remoteTimeout = remoteConfig.getInt('timeout');

    timeout = (remoteTimeout > 0) ? remoteTimeout : timeout;
  }

  ConfigModel.fromJson(Map<String, dynamic> json) {
    isUpToDate = json['isUpToDate'];
    environment = EnvironmentModel.stringToEnv(json['environment']);
    isChatEnabled = json['isChatEnabled'];
    isEnvironmentFlagEnabled = json['isEnvironmentFlagEnabled'];
    timeout = json['timeout'];
    isUxCamEnabled = json['isUxCamEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUpToDate'] = this.isUpToDate;
    data['environment'] = EnvironmentModel.envToString(this.environment);
    data['isChatEnabled'] = this.isChatEnabled;
    data['isEnvironmentFlagEnabled'] = this.isEnvironmentFlagEnabled;
    data['timeout'] = this.timeout;
    data['isUxCamEnabled'] = this.isUxCamEnabled;
    return data;
  }
}
