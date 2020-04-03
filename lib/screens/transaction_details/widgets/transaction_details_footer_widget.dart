import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_link_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_title_widget.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionDetailsFooterWidget extends StatelessWidget {
  const TransactionDetailsFooterWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    return GestureDetector(
      onTap: () => ChatHelper().openChat(),
      child: Container(
        color: StyleColors.SUPPORT_NEUTRAL_20,
        child: Container(
          color: StyleColors.SUPPORT_NEUTRAL_10,
          margin: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: 26,
          ),
          height: 130,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/transaction_details_doubts.png',
                height: 63,
                width: 54,
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DetailSectionTitleWidget(
                    i18n.trans('transaction_details_screen', ['doubts']),
                  ),
                  DetailSectionLink(
                    i18n.trans('transaction_details_screen', ['talk_with_us']),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
