import 'package:remessa_app/helpers/environment_model.dart';

class RemoteConfigResponseModel {
  bool isUpToDate = true;
  Environment environment;
  bool isChatEnabled = true;

  RemoteConfigResponseModel({
    this.isUpToDate,
    this.environment,
    this.isChatEnabled,
  });

  RemoteConfigResponseModel.fromJson(Map<String, dynamic> json) {
    isUpToDate = json['isUpToDate'];
    environment = EnvironmentModel.stringToEnv(json['environment']);
    isChatEnabled = json['isChatEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUpToDate'] = this.isUpToDate;
    data['environment'] = EnvironmentModel.envToString(this.environment);
    data['isChatEnabled'] = this.isChatEnabled;
    return data;
  }
}
