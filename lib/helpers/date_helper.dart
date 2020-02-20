import 'package:intl/intl.dart';

class DateHelper {
  static final brFormat = DateFormat('dd/MM/yy');

  static stringToDate(String dateStr) => DateTime.parse(dateStr);

  static formatToBR(DateTime date) => brFormat.format(date);
}
