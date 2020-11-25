import 'package:remessa_app/models/cost_description_model.dart';
import 'package:remessa_app/models/actions/link_action_model.dart';

class Quote {
  String foreignCurrency;
  double foreignCurrencyAmount;
  String nationalCurrency;
  double nationalCurrencyTotalAmount;
  double nationalCurrencySubAmount;
  double exchangeRate;
  double vet;
  double spread;
  double originalSpread;
  double tradingQuotation;
  String voucherCode;
  String voucherDiscount;
  double totalTaxes;
  List<FeeTaxes> feeTaxes;
  double originalVet;
  CostDescription costDescription;

  Quote(
      {this.foreignCurrency,
      this.foreignCurrencyAmount,
      this.nationalCurrency,
      this.nationalCurrencyTotalAmount,
      this.nationalCurrencySubAmount,
      this.exchangeRate,
      this.vet,
      this.spread,
      this.originalSpread,
      this.tradingQuotation,
      this.voucherCode,
      this.voucherDiscount,
      this.totalTaxes,
      this.feeTaxes,
      this.originalVet,
      this.costDescription});

  Quote.fromJson(Map<String, dynamic> json) {
    foreignCurrency = json['foreignCurrency'];
    foreignCurrencyAmount = json['foreignCurrencyAmount'].toDouble();
    nationalCurrency = json['nationalCurrency'];
    nationalCurrencyTotalAmount =
        json['nationalCurrencyTotalAmount'].toDouble();
    nationalCurrencySubAmount = json['nationalCurrencySubAmount'].toDouble();
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
      feeTaxes = new List<FeeTaxes>();
      json['feeTaxes'].forEach((v) {
        feeTaxes.add(new FeeTaxes.fromJson(v));
      });
    }
    originalVet = json['originalVet'].toDouble();
    costDescription = json['costDescription'] != null
        ? new CostDescription.fromJson(json['costDescription'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['foreignCurrency'] = this.foreignCurrency;
    data['foreignCurrencyAmount'] = this.foreignCurrencyAmount;
    data['nationalCurrency'] = this.nationalCurrency;
    data['nationalCurrencyTotalAmount'] = this.nationalCurrencyTotalAmount;
    data['nationalCurrencySubAmount'] = this.nationalCurrencySubAmount;
    data['exchangeRate'] = this.exchangeRate;
    data['vet'] = this.vet;
    data['spread'] = this.spread;
    data['originalSpread'] = this.originalSpread;
    data['tradingQuotation'] = this.tradingQuotation;
    data['voucherCode'] = this.voucherCode;
    data['voucherDiscount'] = this.voucherDiscount;
    data['totalTaxes'] = this.totalTaxes;
    if (this.feeTaxes != null) {
      data['feeTaxes'] = this.feeTaxes.map((v) => v.toJson()).toList();
    }
    data['originalVet'] = this.originalVet;
    if (this.costDescription != null) {
      data['costDescription'] = this.costDescription.toJson();
    }
    return data;
  }
}

class FeeTaxes {
  String label;
  String description;
  double value;
  LinkActionModel action;

  FeeTaxes({this.label, this.description, this.value});

  FeeTaxes.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    value = json['value'].toDouble();
    action = json['action'] != null
        ? new LinkActionModel.fromJson(json['action'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['description'] = this.description;
    data['value'] = this.value;
    if (this.action != null) {
      data['action'] = this.action.toJson();
    }
    return data;
  }
}
