import 'package:flutter_test/flutter_test.dart';
import 'package:remessa_app/helpers/currency_helper.dart';

void main() {
  test('Should parse money formatted string to double', () {
    final parsedValue = CurrencyHelper.toDouble('10.000,00');

    expect(
      parsedValue,
      10000.00,
    );
  });

  test('Should empty string to 0', () {
    final parsedValue = CurrencyHelper.toDouble('');

    expect(
      parsedValue,
      0,
    );
  });
}
