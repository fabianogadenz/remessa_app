import 'package:dotted_line/dotted_line.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/quote_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/tax_details_column_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/tax_details_row_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/tax_details_spotlight_row_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/toggle_tax_button_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/transaction_value_by_currency_widget.dart';

class CheckoutTaxDetailsWidget extends StatefulWidget {
  final TransactionViewModel transaction;

  const CheckoutTaxDetailsWidget({Key key, @required this.transaction})
      : assert(transaction != null),
        super(key: key);

  @override
  _CheckoutTaxDetailsWidgetState createState() =>
      _CheckoutTaxDetailsWidgetState();
}

class _CheckoutTaxDetailsWidgetState extends State<CheckoutTaxDetailsWidget> {
  bool isExpanded = false;

  TransactionViewModel get _transaction => widget.transaction;
  QuoteViewModel get _quote => _transaction.quote;

  Duration get _duration =>
      isExpanded ? Duration(milliseconds: 500) : Duration(milliseconds: 300);

  _toggleDetails() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  String _valueWithBRLPrefix(double value,
          [String formatString = CurrencyHelper.currencyFormat]) =>
      CurrencyHelper.withPrefix(
        _quote.nationalCurrency,
        value.toString() ?? '0',
        formatString,
      );

  _onTapInfo(BuildContext context, String title, String description) {
    // TODO: Corrigir tracking
    // TrackingEvents.log(
    //   TrackingEvents.TRANSACTION_CALCULATION_INFO_CLICK,
    //   {'label': title},
    // );

    ModalHelper.showInfoBottomSheet(context, title, description, null);
  }

  final i18n = GetIt.I<I18n>();
  String vetStr;

  @override
  void initState() {
    vetStr = _valueWithBRLPrefix(
      _quote.vet,
      CurrencyHelper.currencyFormat + '00',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TransactionValueByCurrencyWidget(
          imageUrl:
              'https://dev-use1-bee-bff-mobile.s3.amazonaws.com/currency-flags/${_quote.foreignCurrency}.png', // TODO: Change image url when it come from backend
          label: i18n.populate(
            i18n.trans(
              'simulator_screen',
              ['foreign_currency_field', 'label'],
            ),
            {'beneficiaryFirstName': _transaction.beneficiary.name},
          ),
          value: CurrencyHelper.withPrefix(
            _quote.foreignCurrency,
            _quote.foreignCurrencyAmount.toString(),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 16),
            AnimatedContainer(
              duration: _duration,
              height: isExpanded ? 347 : 90,
              child: DottedLine(
                direction: Axis.vertical,
                dashColor: StyleColors.BRAND_PRIMARY_20,
                lineLength: double.infinity,
                dashRadius: 3,
                dashLength: 3,
                dashGapLength: 2,
                lineThickness: 2,
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(
                  left: 32,
                  top: 16,
                  bottom: 16,
                ),
                child: AnimatedCrossFade(
                  duration: _duration,
                  firstCurve: Curves.easeIn,
                  secondCurve: Curves.ease,
                  firstChild: isExpanded
                      ? Container()
                      : ToggleTaxButtonWidget(
                          label: i18n.trans('fees'),
                          icon: RemessaIcons.arrow_down,
                          content: i18n.populate(
                            i18n.trans('simulator_screen', ['exchange_rate']),
                            {'vet': vetStr},
                          ),
                          onPressed: () {
                            TrackingEvents.log(
                                TrackingEvents.CHECKOUT_EXPAND_TAXES_CLICK);
                            _toggleDetails();
                          },
                        ),
                  secondChild:
                      isExpanded ? buildTransactionDetails() : Container(),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
            ),
          ],
        ),
        TransactionValueByCurrencyWidget(
          label:
              i18n.trans('simulator_screen', ['local_currency_field', 'label']),
          value: _valueWithBRLPrefix(
            _quote.nationalCurrencyTotalAmount,
          ),
        ),
        isExpanded
            ? Container(
                margin: const EdgeInsets.only(
                  left: 48,
                  top: 16,
                  bottom: 16,
                ),
                child: ToggleTaxButtonWidget(
                  label: i18n.trans('hide_fees'),
                  icon: RemessaIcons.arrow_up,
                  onPressed: _toggleDetails,
                ),
              )
            : Container(),
      ],
    );
  }

  Container buildTransactionDetails() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StyleColors.BRAND_PRIMARY_50,
          ),
        ),
      ),
      child: Column(
        children: [
          TaxDetailsColumnSectionWidget(
            spotlightRow: TaxDetailsSpotlightRowWidget(
              spotlightIcon: RemessaIcons.close,
              label: i18n
                  .trans('transaction_calculation_screen', ['exchange_rate']),
              value: _valueWithBRLPrefix(
                _quote.exchangeRate,
                CurrencyHelper.currencyFormat + '00',
              ),
            ),
            items: [
              TaxDetailsRowWidget(
                label: i18n.trans('transaction_calculation_screen',
                    ['trading_quotation', 'title']),
                value: _valueWithBRLPrefix(
                  _quote.tradingQuotation,
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
              TaxDetailsRowWidget(
                label: i18n.trans(
                    'transaction_calculation_screen', ['spread', 'title']),
                value: CurrencyHelper.withSuffix(
                  _quote.spread.toString(),
                  '%',
                ),
                onTapInfo: () => _onTapInfo(
                  context,
                  i18n.trans(
                      'transaction_calculation_screen', ['spread', 'title']),
                  i18n.trans('transaction_calculation_screen',
                      ['spread', 'description']),
                ),
              ),
            ],
          ),
          TaxDetailsColumnSectionWidget(
            spotlightRow: TaxDetailsSpotlightRowWidget(
              spotlightIcon: RemessaIcons.close,
              label:
                  i18n.trans('transaction_calculation_screen', ['total_fees']),
              value: _valueWithBRLPrefix(_quote.totalTaxes ??
                  (_quote.nationalCurrencyTotalAmount -
                      _quote.nationalCurrencySubAmount)),
            ),
            items: (_quote.feeTaxes ?? [])
                .map<TaxDetailsRowWidget>(
                  (fee) => TaxDetailsRowWidget(
                    label: fee.label,
                    value: _valueWithBRLPrefix(fee.value),
                    onTapInfo: () => _onTapInfo(
                      context,
                      fee.label,
                      fee.description,
                    ),
                  ),
                )
                .toList(),
          ),
          TaxDetailsColumnSectionWidget(
            items: [
              TaxDetailsRowWidget(
                label:
                    i18n.trans('transaction_details_screen', ['vet', 'title']),
                value: vetStr,
                onTapInfo: () => _onTapInfo(
                  context,
                  i18n.trans(
                      'transaction_calculation_screen', ['spread', 'title']),
                  i18n.trans('transaction_calculation_screen',
                      ['spread', 'description']),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
