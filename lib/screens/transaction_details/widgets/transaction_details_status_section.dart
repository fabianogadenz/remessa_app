import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:remessa_app/helpers/transaction_status.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_store.dart';
import 'package:remessa_app/screens/transaction_details/widgets/receipt_download_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/transaction_status_widget.dart';

class TransactionDetailStatusSectionWidget extends StatelessWidget {
  final TransactionDetailsScreenStore transactionDetailsScreenStore;
  final TransactionDetailsResponseModel transactionDetails;
  final bool showReceiptDownload;
  final _appStore = GetIt.I<AppStore>();
  final i18n = GetIt.I<I18n>();

  TransactionDetailStatusSectionWidget({
    Key key,
    @required this.transactionDetails,
    this.transactionDetailsScreenStore,
    this.showReceiptDownload = false,
  })  : assert(transactionDetails != null),
        super(key: key);

  String _getStatusMessage() {
    switch (transactionDetails.status) {
      case TransactionStatus.WAITING_PAYMENT:
        return i18n.populate(
          i18n.trans('status', ['waiting_payment', 'description']),
          {
            'paymentDeadlineHour': _appStore.configs.paymentDeadlineHour,
            'paymentDeadline': DateHelper.formatToBRShort(
              DateHelper.stringToDate(transactionDetails.paymentDeadline),
            ),
          },
        );
      case TransactionStatus.PAYMENT_IDENTIFIED:
        return i18n.trans('status', ['payment_indetified', 'description']);
      case TransactionStatus.CONFIRMED:
        return i18n.trans('status', ['confirmed', 'description']);
      case TransactionStatus.PENDENCY:
        return i18n.trans('status', ['pendency', 'description']);
      case TransactionStatus.WAITING_SIGNATURE:
        return i18n.trans('status', ['waiting_signature', 'description']);
      case TransactionStatus.FINISHED:
        return i18n.trans('status', ['finished', 'description']);
      case TransactionStatus.CANCELED:
        return i18n.trans('status', ['canceled', 'description']);
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusMessage = _getStatusMessage();

    return Container(
      width: double.infinity,
      decoration: showReceiptDownload
          ? null
          : BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: StyleColors.SUPPORT_NEUTRAL_30,
                ),
              ),
            ),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TransactionStatusWidget(
            status: transactionDetails.status,
            statusName: transactionDetails.statusName,
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            statusMessage,
            style: TextStyle(
              color: StyleColors.BRAND_SECONDARY_50,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          showReceiptDownload
              ? ReceiptDownloadWidget(
                  transactionId: transactionDetails.id,
                  label: transactionDetails.counterpart.name,
                  transactionDetailsScreenStore: transactionDetailsScreenStore,
                )
              : Container(),
        ],
      ),
    );
  }
}
