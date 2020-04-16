import 'package:intl/intl.dart';

class DateHelper {
  static final brFormat = DateFormat('dd/MM/yy');
  static final brFormatLong = DateFormat('dd/MM/yyyy');
  static final brFormatShort = DateFormat('dd/MM');

  static stringToDate(String dateStr) => DateTime.parse(dateStr);

  static formatToBR(DateTime date) => brFormat.format(date);

  static formatToBRLong(DateTime date) => brFormatLong.format(date);

  static formatToBRShort(DateTime date) => brFormatShort.format(date);
}
