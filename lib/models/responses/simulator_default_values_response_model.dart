import 'package:remessa_app/models/responses/simulator_response_model.dart';

class SimulatorDefaultValuesResponseModel {
  Currencies currencies;
  SimulatorResponseModel precification;

  SimulatorDefaultValuesResponseModel({this.currencies, this.precification});

  SimulatorDefaultValuesResponseModel.fromJson(Map<String, dynamic> json) {
    currencies = json['currencies'] != null
        ? new Currencies.fromJson(json['currencies'])
        : null;
    precification = json['precification'] != null
        ? new SimulatorResponseModel.fromJson(json['precification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currencies != null) {
      data['currencies'] = this.currencies.toJson();
    }
    if (this.precification != null) {
      data['precification'] = this.precification.toJson();
    }
    return data;
  }
}

class Currencies {
  List<CurrencyData> mostUseds;
  List<CurrencyData> others;

  Currencies({
    this.mostUseds,
    this.others,
  });

  Currencies.fromJson(Map<String, dynamic> json) {
    if (json['mostUseds'] != null) {
      mostUseds = new List<CurrencyData>();
      json['mostUseds'].forEach((v) {
        mostUseds.add(new CurrencyData.fromJson(v));
      });
    }
    if (json['others'] != null) {
      others = new List<CurrencyData>();
      json['others'].forEach((v) {
        others.add(new CurrencyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.mostUseds != null) {
      data['mostUseds'] = this.mostUseds.map((v) => v.toJson()).toList();
    }
    if (this.others != null) {
      data['others'] = this.others.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrencyData {
  int id;
  String name;
  String abbreviation;
  String flagUrl;

  CurrencyData({
    this.id,
    this.name,
    this.flagUrl,
    this.abbreviation,
  });

  CurrencyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    abbreviation = json['abbreviation'];
    flagUrl = json['flagUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['abbreviation'] = this.abbreviation;
    data['flagUrl'] = this.flagUrl;
    return data;
  }
}
