import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_store.dart';
import 'package:remessa_app/screens/transaction_details/widgets/details_section_widget.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/style/colors.dart';

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
    transactionDetailsScreenStore.setErrorMessage(null);
    transactionDetailsScreenStore.setIsLoading(true);

    final url =
        'https://dev-app.pesoreal.xyz/v1/app/transaction/$transactionId/receipt';

    try {
      final fileInfo =
          await DefaultCacheManager().downloadFile(url, authHeaders: {
        'Authorization': 'Bearer ${GetIt.I<AuthService>().token}',
      });

      await FlutterShare.shareFile(
        title: 'Comprovante de pagamento',
        filePath: fileInfo.file.path,
      );
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
                      // Text(label),
                      Text(
                        StringHelper
                            .handleLimiterWithEllipsisFromTextWidthAndStyle(
                          label,
                          380,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  RemessaIcons.download,
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
