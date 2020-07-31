import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter extends TextInputFormatter {
  CurrencyFormatter({
    this.maxDigits,
    this.pattern = '#,##0.00',
    this.locale = 'pt_BR',
  });

  final int maxDigits;
  final String pattern;
  final String locale;
  double umaskValue;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits) {
      return oldValue;
    }
    double value = double.parse(newValue.text);
    final formatter = NumberFormat(pattern, locale);
    String newText = formatter.format(value / 100);

    umaskValue = value / 100;
    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  double getUnmaskedValue() {
    return umaskValue;
  }
}
