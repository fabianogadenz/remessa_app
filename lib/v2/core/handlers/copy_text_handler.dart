import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/style/colors.dart';

class CopyTextHandler {
  static exec(BuildContext context, String label, String value) {
    final i18n = GetIt.I<I18n>();

    Clipboard.setData(
      ClipboardData(text: value),
    );

    final snackBar = SnackBar(
      content: Text(
        i18n.populate(
          i18n.trans('copied'),
          {'label': label},
        ),
      ),
      action: SnackBarAction(
        textColor: StyleColors.BRAND_PRIMARY_30,
        label: i18n.trans('ok').toUpperCase(),
        onPressed: () {},
      ),
    );

    Scaffold.of(context).showSnackBar(snackBar);
  }
}
