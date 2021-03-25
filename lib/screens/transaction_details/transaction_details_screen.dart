import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/helpers/transaction_status.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/transaction_details/beneficiary_data_screen_args.dart';
import 'package:remessa_app/screens/transaction_details/how_to_pay_screen_args.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen_args.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_args.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen_store.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_item_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_recurrence_button_overlay_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_link_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/details_section_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_detail_action_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_footer_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_header_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_details_status_section.dart';
import 'package:remessa_app/stores/quote_store.dart';
import 'package:remessa_app/stores/transaction_details_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screens.dart';

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({
    Key key,
  }) : super(key: key);

  @override
  _TransactionDetailsScreenState createState() =>
      _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen>
    with RouteAware {
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();
  final _transactionsStore = TransactionDetailsStore();
  final _transactionsDetailsScreenStore = TransactionDetailsScreenStore();
  final chatHelper = ChatHelper();

  TransactionDetailsScreenArgs args;
  bool showReceiptDownload;
  bool showFirstDivisor = false;

  TransactionDetailsResponseModel get transactionDetails =>
      _transactionsStore.transactionDetails;

  String get nationalCurrencyTotalAmount => CurrencyHelper.format(
        transactionDetails.quote.nationalCurrencyTotalAmount.toString(),
      );

  String get foreignCurrencyTotalAmount => CurrencyHelper.format(
        transactionDetails.quote.foreignCurrencyAmount.toString(),
      );

  String completeArrivalEstimateMessage;

  ReactionDisposer loadingDisposer, popDisposer;

  @override
  void initState() {
    loadingDisposer = when(
      (_) => _transactionsStore.transactionDetails != null,
      () => _transactionsDetailsScreenStore.setIsLoading(false),
    );

    popDisposer = when(
      (_) => _transactionsStore.hasError,
      () => navigator.pop(),
    );

    super.initState();
  }

  @override
  void didChangeDependencies() {
    args = NavigatorHelper.getArgs(context);

    _transactionsStore.getTransactionDetailsStore(args.transactionId);

    navigator.subscribeRoute(this, context);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    navigator.unsubscribeRoute(this);
    loadingDisposer();
    popDisposer();
    super.dispose();
  }

  @override
  void didPopNext() {
    FlutterUxcam.tagScreenName(UxCamHelper.OPERATION);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GetIt.I<Screens>().widget(
        overlayEvents: {
          'recurrence': DetailRecurrenceButtonOverlayWidget(
            beneficiaryId: transactionDetails?.counterpart?.historyId,
          ),
        },
        isStatic: true,
        showAppBar: true,
        safeAreaConfig: SafeAreaConfig(bottom: false),
        appBarWidget: AccentAppBarWidget(
          title: i18n.populate(
            i18n.trans('transaction_details_screen', ['title']),
            {
              'transactionId': args.transactionId.toString(),
            },
          ),
        ),
        child: Builder(
          builder: (_) {
            if (transactionDetails == null) return Container();

            switch (transactionDetails.status) {
              case TransactionStatus.FINISHED:
                showReceiptDownload = true;
                showFirstDivisor = true;
                break;
              case TransactionStatus.WAITING_SIGNATURE:
                showReceiptDownload = transactionDetails.analysisLevel == 2;
                break;
              default:
                showReceiptDownload = false;
            }

            completeArrivalEstimateMessage = i18n.populate(
              i18n.trans(
                  'transaction_details_screen', ['delivery_estimate', 'value']),
              {
                'arrivalEstimate': transactionDetails.arrivalEstimate,
              },
            );

            final sections = [];

            if (transactionDetails.status ==
                TransactionStatus.WAITING_PAYMENT) {
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
                buildScrollSafeArea(),
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
                          transactionDetailsScreenStore:
                              _transactionsDetailsScreenStore,
                          transactionDetails: transactionDetails,
                          showReceiptDownload: showReceiptDownload,
                        ),
                        _buildDetailAction(),
                        ...sections,
                        TransactionDetailsFooterWidget(
                          showExtraBottomMargin: transactionDetails?.status ==
                              TransactionStatus.FINISHED,
                          onTap: () => _openChatAndLogEvent(
                            eventName:
                                TrackingEvents.TRANSACTION_HELP_BANNER_CLICK,
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
      )
        ..loaderStreamController.add(_transactionsDetailsScreenStore.isLoading)
        ..errorStreamController
            .add(_transactionsDetailsScreenStore.errorMessage)
        ..eventsStreamController.add(
          transactionDetails?.status == TransactionStatus.FINISHED
              ? OverlayEvent(
                  'recurrence', transactionDetails?.counterpart?.redirectUrl)
              : null,
        ),
    );
  }

  Container buildScrollSafeArea() => Container(
        color: StyleColors.SUPPORT_NEUTRAL_20,
      );

  Widget _buildDetailAction() {
    switch (transactionDetails.status) {
      case TransactionStatus.WAITING_PAYMENT:
        return TransactionDetailActionWidget(
          i18n.trans('transaction_details_screen', ['how_to_pay']),
          onPressed: () {
            _log(TrackingEvents.TRANSACTION_HOW_TO_PAY_CLICK);

            navigator.pushNamed(
              AppRouter.TD_HOW_TO_PAY_ROUTE,
              arguments: HowToPayScreenArgs(
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
          showTopBorder: showReceiptDownload,
        );
      default:
        return Container();
    }
  }

  _log(String eventName) => TrackingEvents.log(
        eventName,
        {
          'operation_id': transactionDetails.id,
          'operation_status_group': transactionDetails.statusId,
          'operation_status_name': transactionDetails.statusName,
        },
      );

  _openChatAndLogEvent(
      {String eventName = TrackingEvents.TRANSACTION_HELP_CTA_CLICK}) {
    _log(eventName);

    chatHelper.openChat();
  }

  List _buildDefaultStatusContent() => [
        DetailSectionWidget(
          showDivisor: showFirstDivisor,
          title: i18n.trans('summary'),
          detailItems: [
            handleDeliveryEstimate(),
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
                label:
                    i18n.trans('transaction_details_screen', ['vet', 'title']),
                value: CurrencyHelper.withPrefix(
                  transactionDetails.quote.nationalCurrency,
                  transactionDetails.quote.vet.toString(),
                  CurrencyHelper.currencyFormat + '00',
                ),
                onTapInfo: () {
                  TrackingEvents.log(
                    TrackingEvents.TRANSACTION_TOOLTIP_CLICK,
                    {'origin': 'vet'},
                  );

                  ModalHelper.showInfoBottomSheet(
                    context,
                    i18n.trans('transaction_details_screen', ['vet', 'title']),
                    i18n.trans(
                        'transaction_details_screen', ['vet', 'description']),
                  );
                }),
          ],
          sectionLink: SectionLink(
            i18n.trans(
                'transaction_details_screen', ['transaction_calculation']),
            () {
              _log(TrackingEvents.TRANSACTION_CALCULATION_CLICK);

              final quoteStore = QuoteStore()
                ..setQuote(transactionDetails?.quote);

              navigator.pushNamed(
                AppRouter.TD_CALCULATION_ROUTE,
                arguments: TransactionCalculationScreenArgs(
                  quoteStore: quoteStore,
                  beneficiaryName: transactionDetails.counterpart.name,
                ),
              );
            },
          ),
        ),
        DetailSectionWidget(
          title: i18n.trans('beneficiary'),
          detailItems: [
            DetailItemWidget(
              label: i18n.trans('name'),
              value: transactionDetails.counterpart.name,
            ),
          ],
          sectionLink: SectionLink(
            i18n.trans('transaction_details_screen', ['beneficiary_data']),
            () {
              _log(TrackingEvents.TRANSACTION_BENEFICIARY_INFO_CLICK);

              navigator.pushNamed(
                AppRouter.TD_BENEFICIARY_ROUTE,
                arguments: BeneficiaryDataScreenArgs(
                  transactionDetails: transactionDetails,
                ),
              );
            },
          ),
        ),
      ];

  Widget handleDeliveryEstimate() {
    String deliveryEstimateValue;

    switch (transactionDetails.status) {
      case TransactionStatus.PAYMENT_IDENTIFIED:
        deliveryEstimateValue = transactionDetails.arrivalEstimate;
        break;
      case TransactionStatus.WAITING_SIGNATURE:
      case TransactionStatus.CONFIRMED:
      case TransactionStatus.FINISHED:
        deliveryEstimateValue =
            transactionDetails.paidAt != null && transactionDetails.paidAt != ''
                ? DateHelper.formatToBRLong(
                    DateHelper.stringToDate(transactionDetails.paidAt),
                  )
                : '';
        break;
      case TransactionStatus.CANCELED:
      case TransactionStatus.PENDENCY:
        deliveryEstimateValue = null;
        break;
      default:
        deliveryEstimateValue = completeArrivalEstimateMessage;
    }

    return deliveryEstimateValue != null
        ? DetailItemWidget(
            label: i18n.trans(
                'transaction_details_screen', ['delivery_estimate', 'title']),
            value: deliveryEstimateValue,
            onTapInfo: () {
              TrackingEvents.log(
                TrackingEvents.TRANSACTION_TOOLTIP_CLICK,
                {'origin': 'deadline'},
              );

              ModalHelper.showInfoBottomSheet(
                context,
                i18n.trans('transaction_details_screen',
                    ['delivery_estimate', 'title']),
                i18n.trans('transaction_details_screen',
                    ['delivery_estimate', 'description']),
                Icon(
                  Icons.info,
                  size: 20,
                ),
              );
            })
        : Container();
  }

  List _buildWaitingPaymentContent() {
    return [
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
            label: i18n.trans('beneficiary'),
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
            value: completeArrivalEstimateMessage,
          ),
        ],
      ),
    ];
  }
}
