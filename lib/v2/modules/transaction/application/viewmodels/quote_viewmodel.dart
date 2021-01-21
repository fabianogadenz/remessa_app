import 'package:remessa_app/v2/modules/transaction/application/viewmodels/cost_description_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/quote.dart';

import 'fee_tax_viewmodel.dart';

class QuoteViewModel {
  final String foreignCurrency;
  final double foreignCurrencyAmount;
  final String nationalCurrency;
  final double nationalCurrencyTotalAmount;
  final double nationalCurrencySubAmount;
  final double exchangeRate;
  final double vet;
  final double originalVet;
  final double totalTaxes;
  final List<FeeTaxViewModel> feeTaxes;
  final double spread;
  final double originalSpread;
  final double tradingQuotation;
  final String voucherCode;
  final String voucherDiscount;
  final String spreadDiscount;
  final CostDescriptionViewModel costDescription;

  QuoteViewModel({
    this.foreignCurrency,
    this.foreignCurrencyAmount,
    this.nationalCurrency,
    this.nationalCurrencyTotalAmount,
    this.nationalCurrencySubAmount,
    this.exchangeRate,
    this.vet,
    this.originalVet,
    this.totalTaxes,
    this.feeTaxes,
    this.spread,
    this.originalSpread,
    this.tradingQuotation,
    this.voucherCode,
    this.voucherDiscount,
    this.spreadDiscount,
    this.costDescription,
  });

  factory QuoteViewModel.fromEntity(QuoteEntity quoteEntity) => QuoteViewModel(
        foreignCurrency: quoteEntity.foreignCurrency,
        foreignCurrencyAmount: quoteEntity.foreignCurrencyAmount,
        nationalCurrency: quoteEntity.nationalCurrency,
        nationalCurrencyTotalAmount: quoteEntity.nationalCurrencyTotalAmount,
        nationalCurrencySubAmount: quoteEntity.nationalCurrencySubAmount,
        exchangeRate: quoteEntity.exchangeRate,
        vet: quoteEntity.vet,
        originalVet: quoteEntity.originalVet,
        totalTaxes: quoteEntity.totalTaxes,
        feeTaxes: quoteEntity.feeTaxes
                ?.map(
                  (e) => FeeTaxViewModel(
                    label: e.label,
                    value: e.value,
                    description: e.description,
                  ),
                )
                ?.toList() ??
            [],
        spread: quoteEntity.spread,
        originalSpread: quoteEntity.originalSpread,
        tradingQuotation: quoteEntity.tradingQuotation,
        voucherCode: quoteEntity.voucherCode,
        voucherDiscount: quoteEntity.voucherDiscount,
        spreadDiscount: quoteEntity.spreadDiscount,
        costDescription: (quoteEntity.costDescription != null)
            ? CostDescriptionViewModel.fromEntity(quoteEntity.costDescription)
            : null,
      );
}
