import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:remessa_app/helpers/i18n.dart';

final currency = NumberFormat(
  ',###.00',
  GetIt.I<I18n>().locale.languageCode,
);

class CurrencyHelper {
  static format(String value) => currency.format(double.parse(value));
}
