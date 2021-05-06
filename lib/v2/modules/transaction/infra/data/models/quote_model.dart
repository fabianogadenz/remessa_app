import 'package:remessa_app/v2/modules/transaction/domain/entities/cost_description.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/fee_tax.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/quote.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/cost_description_model.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/fee_tax_model.dart';

class QuoteModel extends QuoteEntity {
  String foreignCurrency;
  double foreignCurrencyAmount;
  String nationalCurrency;
  double nationalCurrencyTotalAmount;
  double nationalCurrencySubAmount;
  String foreignCurrencyFlagURL;
  String nationalCurrencyFlagURL;
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

  QuoteModel.fromJson(Map<String, dynamic> json) {
    foreignCurrency = json['foreignCurrency'];
    foreignCurrencyAmount = json['foreignCurrencyAmount'].toDouble();
    nationalCurrency = json['nationalCurrency'];
    nationalCurrencyTotalAmount =
        json['nationalCurrencyTotalAmount'].toDouble();
    nationalCurrencySubAmount = json['nationalCurrencySubAmount'].toDouble();
    foreignCurrencyFlagURL = json['foreignCurrencyFlagURL'];
    nationalCurrencyFlagURL = json['nationalCurrencyFlagURL'];
    exchangeRate = json['exchangeRate'].toDouble();
    vet = json['vet'].toDouble();
    spread = json['spread'].toDouble();
    originalSpread = json['originalSpread'].toDouble();
    tradingQuotation = json['tradingQuotation'].toDouble();
    voucherCode = json['voucherCode'];
    voucherDiscount = json['voucherDiscount'];
    totalTaxes =
        json['totalTaxes'] != null ? json['totalTaxes'].toDouble() : null;
    if (json['feeTaxes'] != null) {
      feeTaxes = List<FeeTaxModel>();
      json['feeTaxes'].forEach((v) {
        feeTaxes.add(FeeTaxModel.fromJson(v));
      });
    }
    originalVet = json['originalVet'].toDouble();
    costDescription = json['costDescription'] != null
        ? CostDescriptionModel.fromJson(json['costDescription'])
        : null;
  }
}
