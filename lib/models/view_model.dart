import 'package:flutter/material.dart';
import 'package:remessa_app/models/view_generators/info_model.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';

abstract class ViewGenerator {
  Widget generate();
}

abstract class View<T> {
  final T model = null;
}

class ViewModel {
  static ViewGenerator fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final params = json['params'];

    switch (name) {
      case 'InfoStepperScreen':
        return InfoStepperModel.fromJson(params);
      case 'InfoScreen':
        return InfoModel.fromJson(params);
      default:
        // TODO: Implement default ViewGenerator
        return InfoStepperModel.fromJson(params);
    }
  }
}
