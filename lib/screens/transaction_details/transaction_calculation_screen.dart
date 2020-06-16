import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/math_helper.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';

import 'package:remessa_app/screens/transaction_details/widgets/subtitle_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_column_section_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_row_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_spotlight_row_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/screens.dart';

class TransactionCalculationScreen extends StatelessWidget {
  const TransactionCalculationScreen({
    Key key,
    @required this.transactionDetails,
  })  : assert(transactionDetails != null),
        super(key: key);

  final TransactionDetailsResponseModel transactionDetails;

  _onTapInfo(BuildContext context, String title, String description) {
    TrackEvents.log(
      TrackEvents.TRANSACTION_CALCULATION_INFO_CLICK,
      {'label': title},
    );

    ModalHelper.showInfoBottomSheet(
      context,
      title,
      description,
    );
  }

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    final totalFees = (transactionDetails.quote.nationalCurrencyTotalAmount -
        transactionDetails.quote.nationalCurrencySubAmount);

    return GetIt.I<Screens>().widget(
      isAccent: true,
      showAppBar: true,
      statusBarBrightness: Brightness.light,
      appBarText: i18n.trans('transaction_calculation_screen', ['title']),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SubtitleWidget(
              i18n.trans('transaction_calculation_screen', ['subtitle']),
            ),
            SizedBox(
              height: 37,
            ),
            TransactionCalculationSpotlightRowWidget(
              isPrimary: true,
              spotlightIcon: Icon(
                RemessaIcons.send,
                color: StyleColors.SUPPORT_NEUTRAL_10,
                size: 10,
              ),
              label: i18n.trans(
                  'transaction_calculation_screen', ['foreignTotalAmount']),
              value: CurrencyHelper.withPrefix(
                transactionDetails.quote.foreignCurrency,
                transactionDetails.quote.foreignCurrencyAmount.toString(),
              ),
            ),
            TransactionCalculationColumnSectionWidget(
              spotlightRow: TransactionCalculationSpotlightRowWidget(
                spotlightIcon: Icon(
                  RemessaIcons.close,
                  color: StyleColors.BRAND_SECONDARY_50,
                  size: 10,
                ),
                label: i18n
                    .trans('transaction_calculation_screen', ['exchangeRate']),
                value: CurrencyHelper.withPrefix(
                  transactionDetails.quote.nationalCurrency,
                  transactionDetails.quote.exchangeRate.toString(),
                  CurrencyHelper.currencyFormat + '00',
                ),
              ),
              items: <TransactionCalculationRowWidget>[
                TransactionCalculationRowWidget(
                  label: i18n.trans(
                      'transaction_calculation_screen', ['spread', 'title']),
                  labelSpotlight: transactionDetails.quote.voucherCode != null
                      ? 'Cupom ${transactionDetails.quote.voucherCode}'
                      : null,
                  value: CurrencyHelper.withSuffix(
                    transactionDetails.quote.spread.toString(),
                    '%',
                  ),
                  oldValue: transactionDetails.quote.spreadDiscount != null
                      ? CurrencyHelper.withSuffix(
                          MathHelper.totalValueFromPercentageDiscount(
                            transactionDetails.quote.spread,
                            transactionDetails.quote.spreadDiscount,
                          ).toString(),
                          '%',
                        )
                      : null,
                  onTapInfo: () => _onTapInfo(
                    context,
                    i18n.trans(
                        'transaction_calculation_screen', ['spread', 'title']),
                    i18n.trans('transaction_calculation_screen',
                        ['spread', 'description']),
                  ),
                ),
                TransactionCalculationRowWidget(
                  label: i18n.trans('transaction_calculation_screen',
                      ['tradingQuotation', 'title']),
                  value: CurrencyHelper.withPrefix(
                    transactionDetails.quote.nationalCurrency,
                    transactionDetails.quote.tradingQuotation.toString(),
                    CurrencyHelper.currencyFormat + '00',
                  ),
                  onTapInfo: () => _onTapInfo(
                    context,
                    i18n.trans('transaction_calculation_screen',
                        ['tradingQuotation', 'title']),
                    i18n.trans('transaction_calculation_screen',
                        ['tradingQuotation', 'description']),
                  ),
                ),
              ],
            ),
            TransactionCalculationColumnSectionWidget(
              spotlightRow: TransactionCalculationSpotlightRowWidget(
                spotlightIcon: Icon(
                  RemessaIcons.add,
                  color: StyleColors.BRAND_SECONDARY_50,
                  size: 10,
                ),
                label:
                    i18n.trans('transaction_calculation_screen', ['totalFees']),
                value: CurrencyHelper.withPrefix(
                  transactionDetails.quote.nationalCurrency,
                  totalFees.toString(),
                ),
              ),
              items: transactionDetails.quote.feesTaxes
                  .map(
                    (fee) => TransactionCalculationRowWidget(
                      label: fee.label,
                      value: CurrencyHelper.withPrefix(
                        transactionDetails.quote.nationalCurrency,
                        fee.value.toString(),
                      ),
                      onTapInfo: () => _onTapInfo(
                        context,
                        fee.label,
                        fee.description,
                      ),
                    ),
                  )
                  .toList(),
            ),
            TransactionCalculationColumnSectionWidget(
              items: [
                TransactionCalculationRowWidget(
                  label: i18n
                      .trans('transaction_details_screen', ['vet', 'title']),
                  value: CurrencyHelper.withPrefix(
                    transactionDetails.quote.nationalCurrency,
                    transactionDetails.quote.vet.toString(),
                    CurrencyHelper.currencyFormat + '00',
                  ),
                  onTapInfo: () => _onTapInfo(
                    context,
                    i18n.trans('transaction_details_screen', ['vet', 'title']),
                    i18n.trans(
                        'transaction_details_screen', ['vet', 'description']),
                  ),
                ),
              ],
            ),
            TransactionCalculationColumnSectionWidget(
              spotlightRow: TransactionCalculationSpotlightRowWidget(
                isPrimary: true,
                spotlightIcon: Icon(
                  RemessaIcons.equal,
                  color: StyleColors.SUPPORT_NEUTRAL_10,
                  size: 10,
                ),
                label: i18n
                    .trans('transaction_calculation_screen', ['totalAmount']),
                value: CurrencyHelper.withPrefix(
                  transactionDetails.quote.nationalCurrency,
                  transactionDetails.quote.nationalCurrencyTotalAmount
                      .toString(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
