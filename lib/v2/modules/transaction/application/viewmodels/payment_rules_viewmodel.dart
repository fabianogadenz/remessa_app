import 'package:flutter/material.dart';

class PaymentRulesViewModel {
  final IconData icon;
  final bool hasDivider;
  final bool isWarning;

  String value;

  PaymentRulesViewModel({
    @required this.icon,
    @required value,
    this.hasDivider = true,
    this.isWarning = false,
  }) {
    this.value = '<div>$value</div>';
  }
}
