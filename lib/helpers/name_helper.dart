class NameHelper {
  static String abbreviation(String name) {
    if (name == null || name == '') return '';

    final splitedName = name.split(' ');
    final firstLetter = splitedName != null ? splitedName[0][0] : '';

    if (splitedName.length > 1) {
      return '$firstLetter${splitedName[splitedName.length - 1][0]}';
    }

    return firstLetter;
  }
}
