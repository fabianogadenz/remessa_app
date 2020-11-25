import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/widgets/app_bar_widget.dart';
import 'package:screens/screens.dart';

class BeneficiaryDataScreen extends StatelessWidget {
  const BeneficiaryDataScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();
    final transactionDetails =
        NavigatorHelper.getArgs(context).transactionDetails;

    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      statusBarBrightness: Brightness.light,
      appBarWidget: AppBarWidget(
        text: i18n.trans('beneficiary_data'),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DetailItemWidget(
              valueSpotlight: true,
              label: i18n.trans('account_owner'),
              value: transactionDetails.counterpart.name,
            ),
            DetailItemWidget(
              valueSpotlight: true,
              label: i18n.trans('bank'),
              value: transactionDetails.counterpart.bankName,
            ),
            ...transactionDetails.counterpart.accountInfo
                .map<Widget>(
                  (accountInfo) => DetailItemWidget(
                    valueSpotlight: true,
                    label: accountInfo.label,
                    value: accountInfo.value,
                  ),
                )
                .toList(),
            ...transactionDetails.counterpart.intermediaryBankInfo
                .map(
                  (bankInfo) => DetailItemWidget(
                    valueSpotlight: true,
                    label: bankInfo.label,
                    value: bankInfo.value,
                  ),
                )
                .toList(),
            transactionDetails.ffc != null
                ? DetailItemWidget(
                    valueSpotlight: true,
                    label: i18n.trans('ffc'),
                    value: transactionDetails.ffc,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
