import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/style/colors.dart';

class CopyTextHandler {
  final i18n = GetIt.I<I18n>();

  call(BuildContext context, String label, String value) {
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
