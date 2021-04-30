import 'package:flutter/material.dart';
import 'package:remessa_app/models/track_event_model.dart';
import 'package:remessa_app/models/view_generators/info_model.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/models/view_generators/warning_modal_model.dart';

abstract class ViewGenerator {
  final TrackEvent trackEvent;

  ViewGenerator({this.trackEvent});

  Widget generate();
}

abstract class View<T> {
  final T model = null;
}

class ViewModel {
  static ViewGenerator fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final params = json['params'];
    final trackEvent = json['trackEvent'] != null
        ? TrackEvent.fromJson(json['trackEvent'])
        : null;

    switch (name) {
      case 'InfoStepperScreen':
        return InfoStepperModel.fromJson(params, trackEvent);
      case 'InfoScreen':
        return InfoModel.fromJson(params, trackEvent);
      case 'WarningModal':
        return WarningModalModel.fromJson(params, trackEvent);
      default:
        // TODO: Implement default ViewGenerator
        return InfoStepperModel.fromJson(params, trackEvent);
    }
  }
}
