import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/transaction_status.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/screens/transaction_details/favored_data_screen.dart';
import 'package:remessa_app/screens/transaction_details/how_to_pay_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_link_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/details_section_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_detail_action_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_footer_widget.dart';

import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_header_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_status_section.dart';
import 'package:remessa_app/stores/transaction_details_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screens.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final int transactionId;

  const TransactionDetailsScreen({
    Key key,
    @required this.transactionId,
  })  : assert(transactionId != null),
        super(key: key);

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();
  final _transactionsStore = TransactionDetailsStore();
  final chatHelper = ChatHelper();

  TransactionDetailsResponseModel get transactionDetails =>
      _transactionsStore.transactionDetails;

  String get nationalCurrencyTotalAmount => CurrencyHelper.format(
        transactionDetails.quote.nationalCurrencyTotalAmount.toString(),
      );

  String get foreignCurrencyTotalAmount => CurrencyHelper.format(
        transactionDetails.quote.foreignCurrencyAmount.toString(),
      );

  @override
  void initState() {
    _transactionsStore.getTransactionDetailsStore(widget.transactionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screen = GetIt.I<Screens>().widget(
      isStatic: true,
      showAppBar: true,
      safeAreaConfig: SafeAreaConfig(bottom: false),
      appBarWidget: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        iconTheme: IconThemeData(
          color: StyleColors.SUPPORT_NEUTRAL_10,
        ),
        elevation: 0,
        title: Text(
          i18n.populate(
            i18n.trans('transaction_details_screen', ['title']),
            {
              'transactionId': widget.transactionId.toString(),
            },
          ),
          style: TextStyle(
            color: StyleColors.SUPPORT_NEUTRAL_10,
          ),
        ),
      ),
      child: Observer(
        builder: (_) {
          if (transactionDetails == null) return Container();

          final sections = [];

          if (transactionDetails.status == TransactionStatus.WAITING_PAYMENT) {
            sections.addAll(
              _buildWaitingPaymentContent(),
            );
          } else {
            sections.addAll(
              _buildDefaultStatusContent(),
            );
          }

          return Stack(
            children: <Widget>[
              TransactionDetailsHeaderWidget(
                transactionDetails: transactionDetails,
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.only(top: 210),
                  decoration: BoxDecoration(
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      TransactionDetailStatusSectionWidget(
                        transactionDetails: transactionDetails,
                      ),
                      _buildDetailAction(),
                      ...sections,
                      TransactionDetailsFooterWidget(
                        onTap: () => _openChatAndLogEvent(
                          eventName: TrackEvents.TRANSACTION_HELP_BANNER_CLICK,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    )..loaderStreamController.add(true);

    when(
      (_) => _transactionsStore.transactionDetails != null,
      () => screen.loaderStreamController.add(false),
    );

    return screen;
  }

  Widget _buildDetailAction() {
    switch (transactionDetails.status) {
      case TransactionStatus.WAITING_PAYMENT:
        return TransactionDetailActionWidget(
          i18n.trans('transaction_details_screen', ['how_to_pay']),
          onPressed: () {
            _log(TrackEvents.TRANSACTION_HOW_TO_PAY_CLICK);

            navigator.push(
              HowToPayScreen(
                paymentDeadline: transactionDetails.paymentDeadline,
              ),
            );
          },
        );
      case TransactionStatus.PENDENCY:
        return TransactionDetailActionWidget(
          i18n.trans('transaction_details_screen', ['action', 'pendency']),
          onPressed: _openChatAndLogEvent,
        );
      case TransactionStatus.CANCELED:
      case TransactionStatus.WAITING_SIGNATURE:
        return TransactionDetailActionWidget(
          i18n.trans('transaction_details_screen', ['action', 'canceled']),
          onPressed: _openChatAndLogEvent,
        );
      default:
        return Container();
    }
  }

  _log(String eventName) => TrackEvents.log(
        eventName,
        {
          'operation_id': transactionDetails.id,
          'operation_status_group': transactionDetails.statusId,
          'operation_status_name': transactionDetails.statusName,
        },
      );

  _openChatAndLogEvent(
      {String eventName = TrackEvents.TRANSACTION_HELP_CTA_CLICK}) {
    _log(eventName);

    chatHelper.openChat();
  }

  List _buildDefaultStatusContent() => [
        DetailSectionWidget(
          showDivisor: false,
          title: i18n.trans('summary'),
          detailItems: [
            DetailItemWidget(
              label: i18n.trans(
                  'transaction_details_screen', ['delivery_estimate', 'title']),
              value: i18n.populate(
                i18n.trans('transaction_details_screen',
                    ['delivery_estimate', 'value']),
                {
                  'arrivalEstimate': transactionDetails.arrivalEstimate,
                },
              ),
            ),
            DetailItemWidget(
              label: i18n.trans(
                  'transaction_details_screen', ['foreign_currency_amount']),
              value:
                  '${transactionDetails.quote.foreignCurrency} $foreignCurrencyTotalAmount',
            ),
            DetailItemWidget(
              label: i18n.trans(
                  'transaction_details_screen', ['national_currency_amount']),
              value:
                  '${transactionDetails.quote.nationalCurrency} $nationalCurrencyTotalAmount',
            ),
            DetailItemWidget(
              label: i18n.trans('transaction_details_screen', ['vet', 'title']),
              value: CurrencyHelper.withPrefix(
                transactionDetails.quote.nationalCurrency,
                transactionDetails.quote.vet.toString(),
                CurrencyHelper.currencyFormat + '00',
              ),
              onTapInfo: () => ModalHelper.showInfoBottomSheet(
                context,
                i18n.trans('transaction_details_screen', ['vet', 'title']),
                i18n.trans(
                    'transaction_details_screen', ['vet', 'description']),
              ),
            ),
          ],
          sectionLink: SectionLink(
            i18n.trans(
                'transaction_details_screen', ['transaction_calculation']),
            () {
              _log(TrackEvents.TRANSACTION_CALCULATION_CLICK);

              navigator.push(
                TransactionCalculationScreen(
                  transactionDetails: transactionDetails,
                ),
              );
            },
          ),
        ),
        DetailSectionWidget(
          title: i18n.trans('favored'),
          detailItems: [
            DetailItemWidget(
              label: i18n.trans('name'),
              value: transactionDetails.counterpart.name,
            ),
          ],
          sectionLink: SectionLink(
            i18n.trans('transaction_details_screen', ['favored_data']),
            () {
              _log(TrackEvents.TRANSACTION_FAVORED_INFO_CLICK);

              navigator.push(
                FavoredDataScreen(
                  transactionDetails: transactionDetails,
                ),
              );
            },
          ),
        ),
      ];

  List _buildWaitingPaymentContent() => [
        DetailSectionWidget(
          showDivisor: false,
          title: i18n.trans('transaction_details_screen', ['ted']),
          detailItems: [
            DetailItemWidget(
              isValueCopyable: true,
              label: i18n.trans('bank'),
              value:
                  '${transactionDetails.paymentAccountInfo.bankName} (${transactionDetails.paymentAccountInfo.bankCode})',
            ),
            DetailItemWidget(
              isValueCopyable: true,
              label: i18n.trans('agency'),
              value: transactionDetails.paymentAccountInfo.branchCode,
            ),
            DetailItemWidget(
              isValueCopyable: true,
              label: i18n.trans('checking_account'),
              value: transactionDetails.paymentAccountInfo.accountNumber,
            ),
            DetailItemWidget(
              isValueCopyable: true,
              label: i18n.trans('favored'),
              value: transactionDetails.paymentAccountInfo.accountHolderName,
            ),
            DetailItemWidget(
              isValueCopyable: true,
              label: i18n.trans('cnpj'),
              value: transactionDetails
                  .paymentAccountInfo.accountHolderDocumentNumber,
            ),
            DetailItemWidget(
              label: i18n.trans('transaction_details_screen', ['account_type']),
              value: i18n.trans('checking_account'),
            ),
            DetailItemWidget(
              label: i18n.trans('transaction_details_screen', ['ted_reason']),
              value: i18n.trans(
                  'transaction_details_screen', ['checking_account_credit']),
            ),
          ],
        ),
        DetailSectionWidget(
          title: i18n.trans('transaction_details_screen', ['ted_value']),
          detailItems: [
            DetailItemWidget(
              showLabel: false,
              isValueCopyable: true,
              copyableValue: nationalCurrencyTotalAmount,
              label: i18n.trans('value'),
              value:
                  '${transactionDetails.quote.nationalCurrency} $nationalCurrencyTotalAmount',
            ),
          ],
        ),
        DetailSectionWidget(
          title: i18n.trans('transaction_details_screen', ['arrival_estimate']),
          detailItems: [
            DetailItemWidget(
              value: transactionDetails.arrivalEstimate,
            ),
          ],
        ),
      ];
}
