import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_store.dart';
import 'package:remessa_app/screens/transaction_details/widgets/details_section_widget.dart';
import 'package:remessa_app/services/download_service.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:share_extend/share_extend.dart';

class ReceiptDownloadWidget extends StatelessWidget {
  ReceiptDownloadWidget({
    Key key,
    @required this.transactionId,
    @required this.label,
    @required this.transactionDetailsScreenStore,
  })  : assert(transactionId != null),
        assert(label != null),
        assert(transactionDetailsScreenStore != null),
        super(key: key);

  final i18n = GetIt.I<I18n>();
  final String label;
  final int transactionId;
  final TransactionDetailsScreenStore transactionDetailsScreenStore;

  Future<void> shareFile() async {
    TrackingEvents.log(TrackingEvents.TRANSACTION_RECEIPT_SHARE_CLICK);

    transactionDetailsScreenStore.setErrorMessage(null);
    transactionDetailsScreenStore.setIsLoading(true);

    try {
      final fileInfo = await GetIt.I<DownloadService>()
          .downloadFile('/transaction/$transactionId/receipt');

      await ShareExtend.share(fileInfo.file.path, 'file');
    } catch (e) {
      transactionDetailsScreenStore.setErrorMessage(e?.message);
    } finally {
      transactionDetailsScreenStore.setIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DetailSectionWidget(
      showDivisor: false,
      title: i18n.trans('transaction_details_screen', ['receipt']),
      detailItems: [
        GestureDetector(
          onTap: shareFile,
          child: Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: StyleColors.SUPPORT_NEUTRAL_40,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        RemessaIcons.document,
                        size: 18,
                        color: StyleColors.SUPPORT_NEUTRAL_40,
                      ),
                      SizedBox(width: 4),
                      Text(
                        StringHelper
                            .handleLimiterWithEllipsisFromTextWidthAndStyle(
                          label,
                          300,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  RemessaIcons.share,
                  size: 18,
                  color: StyleColors.BRAND_PRIMARY_40,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
