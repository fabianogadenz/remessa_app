import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/actions/link_action_model.dart';
import 'package:remessa_app/models/quote_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen_args.dart';

import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_column_section_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_row_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_spotlight_row_widget.dart';
import 'package:remessa_app/stores/quote_store.dart';
import 'package:remessa_app/stores/timer_animation_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';
import 'package:remessa_app/v2/core/widgets/timer_widget.dart';
import 'package:screens/screens.dart';

class TransactionCalculationScreen extends StatefulWidget {
  const TransactionCalculationScreen({
    Key key,
  }) : super(key: key);

  @override
  _TransactionCalculationScreenState createState() =>
      _TransactionCalculationScreenState();
}

class _TransactionCalculationScreenState
    extends State<TransactionCalculationScreen> with TickerProviderStateMixin {
  final timerAnimationStore = GetIt.I<TimerAnimationStore>();
  final i18n = GetIt.I<I18n>();
  QuoteStore quoteStore;
  Quote quote;
  String beneficiaryName;
  bool showTimer = false;
  ReactionDisposer _reactionDisposer;

  void _resyncTimer(TickerProvider ticker) {
    if (showTimer && timerAnimationStore?.controller != null)
      timerAnimationStore.controller.resync(ticker);
  }

  @override
  void didChangeDependencies() {
    final TransactionCalculationScreenArgs args =
        NavigatorHelper.getArgs(context);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      quoteStore = args.quoteStore;
      showTimer = args.showTimer;
      beneficiaryName = args.beneficiaryName;
      _resyncTimer(this);

      _reactionDisposer = autorun((_) {
        if (quoteStore?.quote != null) {
          setState(() {
            quote = quoteStore.quote;
          });
        }
      });
    });

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _resyncTimer(timerAnimationStore.ticker);
    _reactionDisposer();
    super.dispose();
  }

  _onTapInfo(BuildContext context, String title, String description,
      [LinkActionModel linkActionModel]) {
    TrackEvents.log(
      TrackEvents.TRANSACTION_CALCULATION_INFO_CLICK,
      {'label': title},
    );

    ModalHelper.showInfoBottomSheet(
      context,
      title,
      description,
      null,
      linkActionModel?.toAction() ?? null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      statusBarBrightness: Brightness.light,
      appBarWidget: AccentAppBarWidget(
        title: i18n.trans('transaction_calculation_screen', ['title']),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: quote != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TransactionCalculationSpotlightRowWidget(
                    isPrimary: true,
                    spotlightIcon: RemessaIcons.user_fill,
                    label: i18n.populate(
                        i18n.trans('transaction_calculation_screen',
                            ['foreign_total_amount']),
                        {
                          'beneficiaryName': beneficiaryName?.split(' ')[0],
                        }),
                    value: CurrencyHelper.withPrefix(
                      quote.foreignCurrency,
                      quote.foreignCurrencyAmount.toString(),
                    ),
                  ),
                  TransactionCalculationColumnSectionWidget(
                    spotlightRow: TransactionCalculationSpotlightRowWidget(
                      spotlightIcon: RemessaIcons.close,
                      label: i18n.trans(
                          'transaction_calculation_screen', ['exchange_rate']),
                      value: CurrencyHelper.withPrefix(
                        quote.nationalCurrency,
                        quote.exchangeRate.toString(),
                        CurrencyHelper.currencyFormat + '00',
                      ),
                    ),
                    items: <TransactionCalculationRowWidget>[
                      TransactionCalculationRowWidget(
                        label: i18n.trans('transaction_calculation_screen',
                            ['spread', 'title']),
                        spotlightList: quote?.costDescription?.details,
                        spotlightWidgetList: quote?.voucherCode != null
                            ? [
                                SpotlightItemWidget(
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Cupom ',
                                      children: [
                                        TextSpan(
                                          text: quote.voucherCode,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: quote?.voucherDiscount != null
                                              ? ' (${quote?.voucherDiscount})'
                                              : '',
                                        ),
                                      ],
                                      style: TextStyle(
                                        color: StyleColors.SUPPORT_SUCCESS_50,
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                            : null,
                        value: CurrencyHelper.withSuffix(
                          quote.spread.toString(),
                          '%',
                        ),
                        oldValue: quote.spread != quote.originalSpread
                            ? CurrencyHelper.withSuffix(
                                quote.originalSpread.toString(),
                                '%',
                              )
                            : null,
                        onTapInfo: () => _onTapInfo(
                          context,
                          i18n.trans('transaction_calculation_screen',
                              ['spread', 'title']),
                          i18n.trans('transaction_calculation_screen',
                              ['spread', 'description']),
                        ),
                      ),
                      TransactionCalculationRowWidget(
                        label: i18n.trans('transaction_calculation_screen',
                            ['trading_quotation', 'title']),
                        labelSuffix: showTimer
                            ? Container(
                                width: 25,
                                height: 25,
                                child: TimerWidget(),
                              )
                            : Container(),
                        value: CurrencyHelper.withPrefix(
                          quote.nationalCurrency,
                          quote.tradingQuotation.toString(),
                          CurrencyHelper.currencyFormat + '00',
                        ),
                        onTapInfo: () => _onTapInfo(
                          context,
                          i18n.trans('transaction_calculation_screen',
                              ['trading_quotation', 'title']),
                          i18n.trans('transaction_calculation_screen',
                              ['trading_quotation', 'description']),
                        ),
                      ),
                    ],
                  ),
                  TransactionCalculationColumnSectionWidget(
                    spotlightRow: TransactionCalculationSpotlightRowWidget(
                      spotlightIcon: RemessaIcons.add,
                      label: i18n.trans(
                          'transaction_calculation_screen', ['total_fees']),
                      value: CurrencyHelper.withPrefix(
                        quote.nationalCurrency,
                        (quote.totalTaxes ??
                                (quote.nationalCurrencyTotalAmount -
                                    quote.nationalCurrencySubAmount))
                            .toString(),
                      ),
                    ),
                    items: (quote?.feeTaxes ?? [])
                        .map<TransactionCalculationRowWidget>(
                          (fee) => TransactionCalculationRowWidget(
                            label: fee.label,
                            value: CurrencyHelper.withPrefix(
                              quote.nationalCurrency,
                              fee.value.toString(),
                            ),
                            onTapInfo: () => _onTapInfo(
                              context,
                              fee.label,
                              fee.description,
                              fee.action,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  TransactionCalculationColumnSectionWidget(
                    items: [
                      TransactionCalculationRowWidget(
                        label: i18n.trans(
                            'transaction_details_screen', ['vet', 'title']),
                        isSpotlight: true,
                        value: CurrencyHelper.withPrefix(
                          quote.nationalCurrency,
                          quote.vet.toString(),
                          CurrencyHelper.currencyFormat + '00',
                        ),
                        onTapInfo: () => _onTapInfo(
                          context,
                          i18n.trans(
                              'transaction_details_screen', ['vet', 'title']),
                          i18n.trans('transaction_details_screen',
                              ['vet', 'description']),
                        ),
                      ),
                    ],
                  ),
                  TransactionCalculationColumnSectionWidget(
                    spotlightRow: TransactionCalculationSpotlightRowWidget(
                      isPrimary: true,
                      spotlightIcon: RemessaIcons.equal,
                      label: i18n.trans(
                          'transaction_calculation_screen', ['total_amount']),
                      value: CurrencyHelper.withPrefix(
                        quote.nationalCurrency,
                        quote.nationalCurrencyTotalAmount.toString(),
                      ),
                    ),
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
