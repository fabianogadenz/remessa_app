import 'cost_description.dart';
import 'fee_tax.dart';

class QuoteEntity {
  String foreignCurrency;
  double foreignCurrencyAmount;
  String nationalCurrency;
  double nationalCurrencyTotalAmount;
  double nationalCurrencySubAmount;
  double exchangeRate;
  double vet;
  double originalVet;
  double totalTaxes;
  List<FeeTaxEntity> feeTaxes;
  double spread;
  double originalSpread;
  double tradingQuotation;
  String voucherCode;
  String voucherDiscount;
  String spreadDiscount;
  CostDescriptionEntity costDescription;

  QuoteEntity({
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
}
