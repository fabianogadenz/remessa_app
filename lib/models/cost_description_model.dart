import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';

class CostDescription {
  List<CostDescriptionHome> home;
  List<String> details;

  CostDescription({this.home, this.details});

  CostDescription.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = new List<CostDescriptionHome>();
      json['home'].forEach((v) {
        home.add(new CostDescriptionHome.fromJson(v));
      });
    }
    if (json['details'] != null) details = json['details'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home.map((v) => v.toJson()).toList();
    }
    data['details'] = this.details;
    return data;
  }
}

const COST_ICONS = {
  'mgm': RemessaIcons.medal,
};

class CostDescriptionHome {
  String type;
  String label;
  String description;
  IconData icon;

  CostDescriptionHome({this.type, this.label, this.description});

  CostDescriptionHome.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    description = json['description'];
    icon = COST_ICONS[type] ?? RemessaIcons.percent;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['description'] = this.description;
    return data;
  }
}
