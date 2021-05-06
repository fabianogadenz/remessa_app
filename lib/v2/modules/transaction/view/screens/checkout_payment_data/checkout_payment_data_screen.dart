import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/constants/image_contants.dart';
import 'package:remessa_app/v2/core/handlers/show_modal_handler.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/core/widgets/warning_modal/warning_modal_widget.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/confirmated_transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_account_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/copiable_data_section/copiable_data_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules_toggle/payment_rules_toggle_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutPaymentDataScreen extends StatefulWidget {
  final ConfirmatedTransactionViewModel confirmatedTransaction;

  const CheckoutPaymentDataScreen({
    Key key,
    @required this.confirmatedTransaction,
  })  : assert(confirmatedTransaction != null),
        super(key: key);

  @override
  _CheckoutPaymentDataScreenState createState() =>
      _CheckoutPaymentDataScreenState();
}

class _CheckoutPaymentDataScreenState extends State<CheckoutPaymentDataScreen> {
  final I18n i18n = GetIt.I<I18n>();

  ConfirmatedTransactionViewModel get _confirmatedTransaction =>
      widget.confirmatedTransaction;

  PaymentAccountInfoViewModel get _paymentAccountInfo =>
      _confirmatedTransaction.paymentAccountInfo;

  ShowModalHandler show;

  final paymentDeadlineHour = GetIt.I<AppStore>().configs.paymentDeadlineHour;
  String paymentDeadLineDate;

  @override
  initState() {
    paymentDeadLineDate = DateHelper.formatToBRShort(
      DateHelper.stringToDate(
        _confirmatedTransaction.transaction.paymentDeadline,
      ),
    );

    show = ShowModalHandler(
      modalWidget: WarningModalWidget(
        title:
            i18n.trans('checkout', ['payment_data_screen', 'modal', 'title']),
        content: i18n.populate(
          i18n.trans('checkout', ['payment_data_screen', 'modal', 'content']),
          {
            'paymentDeadlineHour': paymentDeadlineHour,
            'paymentDeadLineDate': paymentDeadLineDate,
          },
        ),
        imagePath: ImageConstants.PHONE_WARNING,
        primaryAction: ac.Action(
          name: i18n
              .trans('checkout', ['payment_data_screen', 'modal', 'action']),
          prevAction: () => TrackingEvents.log(
              TrackingEvents.CHECKOUT_OK_GO_TO_REMITTANCES_CLICK),
          actionFunction: () =>
              GetIt.I<NavigatorHelper>().pushNamedAndRemoveUntil(
            AppRouter.DASHBOARD_ROUTE,
          ),
        ),
        hasCloseButton: true,
      ),
      isDismissible: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(
        title: i18n.trans('checkout', ['payment_data_screen', 'title']),
        steps: 3,
        currentStep: 2,
        canGoBack: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24) +
                  const EdgeInsets.only(bottom: 24, top: 32),
              child: Column(
                children: [
                  Text(
                    i18n.trans(
                        'checkout', ['payment_data_screen', 'ted_message']),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                    ),
                  ),
                  SizedBox(height: 32),
                  PaymentRulesToggleWidget(
                    paymentRules: [
                      PaymentRulesViewModel(
                        icon: RemessaIcons.deadline,
                        value: i18n.populate(
                          i18n.trans(
                              'checkout', ['payment_rules', 'rules', '1']),
                          {
                            'paymentDeadlineHour':
                                GetIt.I<AppStore>().configs.paymentDeadlineHour,
                            'paymentDeadLineDate': DateHelper.formatToBRShort(
                              DateHelper.stringToDate(
                                _confirmatedTransaction
                                    .transaction.paymentDeadline,
                              ),
                            ),
                          },
                        ),
                        hasDivider: true,
                      ),
                      PaymentRulesViewModel(
                        icon: RemessaIcons.owner,
                        value: i18n.populate(
                          i18n.trans(
                              'checkout', ['payment_rules', 'rules', '2']),
                          {
                            'trackEvent':
                                TrackingEvents.CHECKOUT_PROVE_ACCOUNT_CLICK,
                          },
                        ),
                        hasDivider: true,
                      ),
                      PaymentRulesViewModel(
                        icon: RemessaIcons.attention_oval_outline,
                        value: i18n
                            .trans('checkout', ['payment_rules', 'rules', '3']),
                        hasDivider: false,
                        isWarning: true,
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  CopyableDataSectionWidget(
                    title: 'Dados bancários para enviar a TED',
                    data: [
                      LabelValueModel(
                        label: i18n.trans('value'),
                        value: CurrencyHelper.withPrefix(
                          'R\$',
                          _confirmatedTransaction
                              .transaction.quote.nationalCurrencyTotalAmount
                              .toString(),
                        ),
                        isCopiable: true,
                        isSpotlight: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans('bank'),
                        value:
                            '${_paymentAccountInfo.bankName} (${_paymentAccountInfo.bankCode})',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans('agency'),
                        value: _paymentAccountInfo.branchCode,
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans('checking_account'),
                        value: _paymentAccountInfo.accountNumber,
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans('beneficiary'),
                        value: _paymentAccountInfo.accountHolderName,
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans('cnpj'),
                        value: _paymentAccountInfo.accountHolderDocumentNumber,
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: i18n.trans(
                            'transaction_details_screen', ['account_type']),
                        value: i18n.trans('checking_account'),
                      ),
                      LabelValueModel(
                        label: i18n.trans(
                            'transaction_details_screen', ['ted_reason']),
                        value: i18n.trans('transaction_details_screen',
                            ['checking_account_credit']),
                        hasDivider: false,
                      ),
                    ],
                    action: ac.Action(
                      name: i18n
                          .trans('checkout', ['payment_data_screen', 'action']),
                      actionFunction: () {
                        TrackingEvents.log(
                            TrackingEvents.CHECKOUT_ALREADY_PAID_CLICK);

                        GetIt.I<NavigatorHelper>().pushNamed(
                          AppRouter.CHECKOUT_SUCCESS,
                        );
                      },
                    ),
                    secondaryAction: ac.Action(
                      name: i18n.trans('checkout',
                          ['payment_data_screen', 'secondaryAction']),
                      prevAction: () => TrackingEvents.log(
                          TrackingEvents.CHECKOUT_WILL_PAY_LATER_CLICK),
                      actionFunction: () => show(context),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
