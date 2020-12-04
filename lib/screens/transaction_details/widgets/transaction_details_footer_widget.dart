import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_link_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_title_widget.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionDetailsFooterWidget extends StatelessWidget {
  const TransactionDetailsFooterWidget(
      {Key key, @required this.onTap, this.showExtraBottomMargin = false})
      : assert(onTap != null),
        super(key: key);

  final Function onTap;
  final bool showExtraBottomMargin;

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: StyleColors.SUPPORT_NEUTRAL_20,
        child: Container(
          decoration: BoxDecoration(
            color: StyleColors.SUPPORT_NEUTRAL_10,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: showExtraBottomMargin ? 100 : 26,
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
                  DetailSectionLinkWidget(
                    i18n.trans('transaction_details_screen', ['talk_with_us']),
                    action: onTap,
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
