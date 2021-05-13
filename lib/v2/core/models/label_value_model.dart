import 'package:flutter/foundation.dart';

class LabelValueModel {
  final String label;
  final String value;
  final bool hasDivider;
  final bool isCopiable;
  final bool isSpotlight;

  LabelValueModel({
    @required this.label,
    @required this.value,
    this.hasDivider = true,
    this.isCopiable = false,
    this.isSpotlight = false,
  });
}
