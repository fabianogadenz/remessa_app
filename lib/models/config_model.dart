import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info/package_info.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:version/version.dart';

class ConfigModel {
  bool isUpToDate = true;
  Environment environment;
  bool isChatEnabled = true;
  int timeout = 20000;

  ConfigModel({
    this.isUpToDate,
    this.environment,
    this.isChatEnabled,
    this.timeout,
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

    final remoteTimeout = remoteConfig.getInt('timeout');

    timeout = (remoteTimeout > 0) ? remoteTimeout : timeout;
  }

  ConfigModel.fromJson(Map<String, dynamic> json) {
    isUpToDate = json['isUpToDate'];
    environment = EnvironmentModel.stringToEnv(json['environment']);
    isChatEnabled = json['isChatEnabled'];
    timeout = json['timeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUpToDate'] = this.isUpToDate;
    data['environment'] = EnvironmentModel.envToString(this.environment);
    data['isChatEnabled'] = this.isChatEnabled;
    data['timeout'] = this.timeout;
    return data;
  }
}
