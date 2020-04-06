import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/subtitle_widget.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class HowToPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    return ScreenWidget(
      isAccent: true,
      showAppBar: true,
      appBarText: i18n.trans('how_to_pay'),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubtitleWidget(i18n.trans('how_to_pay_screen', ['subtitle'])),
            DetailItemWidget(
              titleSpotlight: true,
              label: i18n.trans('how_to_pay_screen', ['ted', 'title']),
              value: i18n.trans('how_to_pay_screen', ['ted', 'description']),
            ),
            DetailItemWidget(
              titleSpotlight: true,
              label: i18n.trans('how_to_pay_screen', ['deadline', 'title']),
              value:
                  i18n.trans('how_to_pay_screen', ['deadline', 'description']),
            ),
            DetailItemWidget(
              titleSpotlight: true,
              label: i18n.trans('how_to_pay_screen', ['bank_account', 'title']),
              value: i18n
                  .trans('how_to_pay_screen', ['bank_account', 'description']),
            ),
          ],
        ),
      ),
    );
  }
}
