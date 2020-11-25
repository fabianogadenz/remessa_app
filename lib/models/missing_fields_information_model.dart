import 'package:remessa_app/models/actions/link_action_model.dart';

class MissingFieldsInformationModel {
  MissingFieldsInformationStructureModel beneficiary;
  MissingFieldsInformationStructureModel simulator;
  bool isBlocked;

  MissingFieldsInformationModel(
      {this.beneficiary, this.simulator, this.isBlocked});

  MissingFieldsInformationModel.fromJson(Map<String, dynamic> json) {
    beneficiary = json['beneficiary'] != null
        ? new MissingFieldsInformationStructureModel.fromJson(
            json['beneficiary'])
        : null;
    simulator = json['simulator'] != null
        ? new MissingFieldsInformationStructureModel.fromJson(json['simulator'])
        : null;
    isBlocked = json['isBlocked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.beneficiary != null) {
      data['beneficiary'] = this.beneficiary.toJson();
    }
    if (this.simulator != null) {
      data['simulator'] = this.simulator.toJson();
    }
    data['isBlocked'] = this.isBlocked;
    return data;
  }
}

class MissingFieldsInformationStructureModel {
  String title;
  String description;
  LinkActionModel action;

  MissingFieldsInformationStructureModel(
      {this.title, this.description, this.action});

  MissingFieldsInformationStructureModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    action = json['action'] != null
        ? new LinkActionModel.fromJson(json['action'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.action != null) {
      data['action'] = this.action.toJson();
    }
    return data;
  }
}
