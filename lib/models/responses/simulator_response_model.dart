import 'package:remessa_app/models/currency_model.dart';
import 'package:remessa_app/models/quote_model.dart';

class SimulatorResponseModel {
  Currency currency;
  String quotationUrl;
  String redirectUrl;
  Quote quote;

  SimulatorResponseModel(
      {this.currency, this.quotationUrl, this.redirectUrl, this.quote});

  SimulatorResponseModel.fromJson(Map<String, dynamic> json) {
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    quotationUrl = json['quotationUrl'];
    redirectUrl = json['redirectUrl'];
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
    data['quotationUrl'] = this.quotationUrl;
    data['redirectUrl'] = this.redirectUrl;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    return data;
  }
}
