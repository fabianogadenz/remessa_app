import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/tax_details_column_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/tax_details_row_widget.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/tax_details_spotlight_row_widget.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/toggle_tax_button_widget.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_tax_details/transaction_value_by_currency_widget.dart';

class CheckoutTaxDetailsWidget extends StatefulWidget {
  @override
  _CheckoutTaxDetailsWidgetState createState() =>
      _CheckoutTaxDetailsWidgetState();
}

class _CheckoutTaxDetailsWidgetState extends State<CheckoutTaxDetailsWidget> {
  bool isExpanded = false;

  Duration get _duration =>
      isExpanded ? Duration(milliseconds: 500) : Duration(milliseconds: 300);

  _toggleDetails() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TransactionValueByCurrencyWidget(
          imageUrl:
              'https://dev-use1-bee-bff-mobile.s3.amazonaws.com/currency-flags/USD.png',
          label: 'Reinaldo recebe',
          value: 'USD 1.000,00',
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
                          label: 'Taxas',
                          icon: RemessaIcons.arrow_down,
                          content: 'Seu câmbio: BRL 5,1454',
                          onPressed: _toggleDetails,
                        ),
                  secondChild: isExpanded
                      ? Container(
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
                                  label: 'Taxa de Câmbio',
                                  value: 'BRL 4,3408',
                                ),
                                items: [
                                  TaxDetailsRowWidget(
                                    label: 'Câmbio Comercial',
                                    value: 'BRL 4,1530',
                                    // onTapInfo: () => _onTapInfo(
                                    //   context,
                                    //   i18n.trans('transaction_calculation_screen',
                                    //       ['trading_quotation', 'title']),
                                    //   i18n.trans('transaction_calculation_screen',
                                    //       ['trading_quotation', 'description']),
                                    // ),
                                  ),
                                  TaxDetailsRowWidget(
                                    label: 'Nosso custo',
                                    value: '1,30%',
                                  ),
                                ],
                              ),
                              TaxDetailsColumnSectionWidget(
                                spotlightRow: TaxDetailsSpotlightRowWidget(
                                  spotlightIcon: RemessaIcons.close,
                                  label: 'Taxa de Câmbio',
                                  value: 'BRL 4,3408',
                                ),
                                items: [
                                  TaxDetailsRowWidget(
                                    label: 'Câmbio Comercial',
                                    value: 'BRL 4,1530',
                                  ),
                                  TaxDetailsRowWidget(
                                    label: 'Nosso custo',
                                    value: '1,30%',
                                  ),
                                ],
                              ),
                              TaxDetailsColumnSectionWidget(
                                items: [
                                  TaxDetailsRowWidget(
                                    label: 'Nosso custo',
                                    value: '1,30%',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  crossFadeState: isExpanded
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                ),
              ),
            ),
          ],
        ),
        TransactionValueByCurrencyWidget(
          imageUrl:
              'https://dev-use1-bee-bff-mobile.s3.amazonaws.com/currency-flags/USD.png',
          label: 'Reinaldo recebe',
          value: 'USD 1.000,00',
        ),
        isExpanded
            ? Container(
                margin: const EdgeInsets.only(
                  left: 48,
                  top: 16,
                  bottom: 16,
                ),
                child: ToggleTaxButtonWidget(
                  label: 'Esconder taxas',
                  icon: RemessaIcons.arrow_up,
                  onPressed: _toggleDetails,
                ),
              )
            : Container(),
      ],
    );
  }
}
