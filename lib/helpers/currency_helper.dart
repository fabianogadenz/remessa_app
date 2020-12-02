import 'package:easy_mask/easy_mask.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:easy_i18n/easy_i18n.dart';

class CurrencyHelper {
  static const String currencyFormat = ',##0.00';

  static TextInputMask mask = TextInputMask(
    mask: '9+.999.999,99',
    placeholder: '0',
    maxPlaceHolders: 3,
    reverse: true,
    maxLength: 14,
  );

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

  static double toDouble(String formatted) => formatted.isNotEmpty
      ? double.parse(formatted.replaceAll('.', '').replaceAll(',', '.'))
      : 0;
}
