class BeneficiaryResponseModel {
  List<Beneficiary> beneficiaries;
  String defaultUrl;

  BeneficiaryResponseModel({this.beneficiaries, this.defaultUrl});

  BeneficiaryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['beneficiaries'] != null) {
      beneficiaries = new List<Beneficiary>();
      json['beneficiaries'].forEach((v) {
        beneficiaries.add(new Beneficiary.fromJson(v));
      });
    }
    defaultUrl = json['defaultUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.beneficiaries != null) {
      data['beneficiaries'] =
          this.beneficiaries.map((v) => v.toJson()).toList();
    }
    data['defaultUrl'] = this.defaultUrl;
    return data;
  }
}

class Beneficiary {
  String beneficiaryName;
  String abbreviatedName;
  String currency;
  Country country;
  String bankName;
  String statusName;
  String redirectUrl;
  Info info;
  bool isDisabled;

  Beneficiary(
      {this.beneficiaryName,
      this.abbreviatedName,
      this.currency,
      this.country,
      this.bankName,
      this.statusName,
      this.redirectUrl,
      this.info,
      this.isDisabled});

  Beneficiary.fromJson(Map<String, dynamic> json) {
    beneficiaryName = json['beneficiaryName'];
    abbreviatedName = json['abbreviatedName'];
    currency = json['currency'] ?? '';
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    bankName = json['bankName'];
    statusName = json['statusName'];
    redirectUrl = json['redirectUrl'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    isDisabled = json['isDisabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['beneficiaryName'] = this.beneficiaryName;
    data['abbreviatedName'] = this.abbreviatedName;
    data['currency'] = this.currency;
    if (this.country != null) {
      data['country'] = this.country.toJson();
    }
    data['bankName'] = this.bankName;
    data['statusName'] = this.statusName;
    data['redirectUrl'] = this.redirectUrl;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    data['isDisabled'] = this.isDisabled;
    return data;
  }
}

class Country {
  String flagUrl;

  Country({this.flagUrl});

  Country.fromJson(Map<String, dynamic> json) {
    flagUrl = json['flagUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flagUrl'] = this.flagUrl;
    return data;
  }
}

class Info {
  String title;
  String description;

  Info({this.title, this.description});

  Info.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}
