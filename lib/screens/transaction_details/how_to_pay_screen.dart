import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/transaction_details/how_to_pay_screen_args.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/v2/core/widgets/app_bar_widget.dart';
import 'package:screens/screens.dart';

class HowToPayScreen extends StatelessWidget {
  HowToPayScreen({Key key}) : super(key: key);

  final i18n = GetIt.I<I18n>();

  @override
  Widget build(BuildContext context) {
    final HowToPayScreenArgs args = NavigatorHelper.getArgs(context);

    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      statusBarBrightness: Brightness.light,
      appBarWidget: AppBarWidget(
        text: i18n.trans('how_to_pay'),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DetailItemWidget(
              titleSpotlight: true,
              label: i18n.trans('how_to_pay_screen', ['ted', 'title']),
              value: i18n.trans('how_to_pay_screen', ['ted', 'description']),
            ),
            DetailItemWidget(
              titleSpotlight: true,
              label: i18n.trans('how_to_pay_screen', ['deadline', 'title']),
              value: i18n.populate(
                i18n.trans('how_to_pay_screen', ['deadline', 'description']),
                {
                  'paymentDeadline': DateHelper.formatToBRShort(
                    DateHelper.stringToDate(args.paymentDeadline),
                  ),
                },
              ),
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
