import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class I18n {
  I18n(this.locale);

  final Locale locale;

  static I18n of(BuildContext context) {
    return Localizations.of<I18n>(context, I18n);
  }

  Map<String, dynamic> _sentences;

  Future<bool> load() async {
    String data = await rootBundle
        .loadString('resources/lang/${this.locale.languageCode}.json');
    this._sentences = json.decode(data);

    return true;
  }

  String trans(String key, [List<String> subKeys]) {
    var item = this._sentences[key] ?? '';

    if (item is Map && (subKeys != null && subKeys.isNotEmpty)) {
      subKeys.forEach(
        (String subKey) => item = item[subKey] ?? '',
      );
    }

    return item.toString();
  }
}

class I18nDelegate extends LocalizationsDelegate<I18n> {
  List<String> locales = ['en', 'pt'];

  I18nDelegate({this.locales}) : assert(locales != null && locales.isNotEmpty);

  @override
  bool isSupported(Locale locale) => locales.contains(locale.languageCode);

  @override
  Future<I18n> load(Locale locale) async {
    I18n localizations = new I18n(locale);
    await localizations.load();

    return localizations;
  }

  @override
  bool shouldReload(I18nDelegate old) => false;
}
