import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class FavoredDataScreen extends StatelessWidget {
  final TransactionDetailsResponseModel transactionDetails;

  const FavoredDataScreen({Key key, @required this.transactionDetails})
      : assert(transactionDetails != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    return ScreenWidget(
      isAccent: true,
      showAppBar: true,
      appBarText: i18n.trans('favored_data'),
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
