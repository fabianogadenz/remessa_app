import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:easy_i18n/easy_i18n.dart';

class CurrencyHelper {
  static const String currencyFormat = ',###.00';

  static String format(String value, [String formatString = currencyFormat]) {
    final formatter = NumberFormat(
      formatString,
      GetIt.I<I18n>().locale.languageCode,
    );

    return formatter.format(double.parse(value));
  }

  static String withPrefix(String prefix, String value,
          [String formatString = currencyFormat]) =>
      '$prefix ${CurrencyHelper.format(value, formatString)}';

  static String withSuffix(String value, String suffix,
          [String formatString = currencyFormat]) =>
      '${CurrencyHelper.format(value, formatString)}$suffix';
}
