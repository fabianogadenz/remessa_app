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

  FeeTaxes({this.label, this.description, this.value});

  FeeTaxes.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    value = json['value'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['description'] = this.description;
    data['value'] = this.value;
    return data;
  }
}

class CostDescription {
  List<CostDescriptionHome> home;
  List<String> details;

  CostDescription({this.home, this.details});

  CostDescription.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      home = new List<CostDescriptionHome>();
      json['home'].forEach((v) {
        home.add(new CostDescriptionHome.fromJson(v));
      });
    }
    details = details != null ? json['details'].cast<String>() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.home != null) {
      data['home'] = this.home.map((v) => v.toJson()).toList();
    }
    data['details'] = this.details;
    return data;
  }
}

class CostDescriptionHome {
  String type;
  String label;
  String description;

  CostDescriptionHome({this.type, this.label, this.description});

  CostDescriptionHome.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['label'] = this.label;
    data['description'] = this.description;
    return data;
  }
}
