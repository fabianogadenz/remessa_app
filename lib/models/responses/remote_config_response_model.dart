import 'package:remessa_app/helpers/environment_model.dart';

class RemoteConfigResponseModel {
  bool isActive = true;
  Environment environment;
  bool isChatEnabled = true;

  RemoteConfigResponseModel({
    this.isActive,
    this.environment,
    this.isChatEnabled,
  });

  RemoteConfigResponseModel.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    environment = EnvironmentModel.stringToEnv(json['environment']);
    isChatEnabled = json['isChatEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['environment'] = EnvironmentModel.envToString(this.environment);
    data['isChatEnabled'] = this.isChatEnabled;
    return data;
  }
}
