import 'package:remessa_app/models/currency_model.dart';

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
  int id;
  String beneficiaryName;
  String abbreviatedName;
  int idOperationType;
  Currency currency;
  Country country;
  String bankName;
  String statusName;
  String redirectUrl;
  Info info;
  bool isDisabled;
  List<MissingFields> missingFields;
  List<MissingFields> addressMissingFields;

  bool get hasMissingFields =>
      missingFields != null && missingFields.length > 0;

  bool get hasAddressMissingFields =>
      addressMissingFields != null && addressMissingFields.length > 0;

  Beneficiary({
    this.id,
    this.beneficiaryName,
    this.abbreviatedName,
    this.idOperationType,
    this.currency,
    this.country,
    this.bankName,
    this.statusName,
    this.redirectUrl,
    this.info,
    this.isDisabled,
    this.missingFields,
    this.addressMissingFields,
  });

  Beneficiary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    beneficiaryName = json['beneficiaryName'];
    abbreviatedName = json['abbreviatedName'];
    idOperationType = json['idOperationType'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    country =
        json['country'] != null ? new Country.fromJson(json['country']) : null;
    bankName = json['bankName'];
    statusName = json['statusName'];
    redirectUrl = json['redirectUrl'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    isDisabled = json['isDisabled'];
    if (json['missingFields'] != null) {
      missingFields = new List<MissingFields>();
      json['missingFields'].forEach((v) {
        missingFields.add(new MissingFields.fromJson(v));
      });
    }
    if (json['addressMissingFields'] != null) {
      addressMissingFields = new List<MissingFields>();
      json['addressMissingFields'].forEach((v) {
        addressMissingFields.add(new MissingFields.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['beneficiaryName'] = this.beneficiaryName;
    data['abbreviatedName'] = this.abbreviatedName;
    data['idOperationType'] = this.idOperationType;
    if (this.currency != null) {
      data['currency'] = this.currency.toJson();
    }
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
    if (this.missingFields != null) {
      data['missingFields'] =
          this.missingFields.map((v) => v.toJson()).toList();
    }
    if (this.addressMissingFields != null) {
      data['addressMissingFields'] =
          this.addressMissingFields.map((v) => v.toJson()).toList();
    }
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

class MissingFields {
  String name;
  String label;
  String mask;
  int maxLength;
  bool isRequired;
  String category;
  String type;
  String customerType;
  String id;

  MissingFields({
    this.name,
    this.label,
    this.mask,
    this.maxLength,
    this.isRequired,
    this.category,
    this.type,
    this.customerType,
    this.id,
  });

  MissingFields.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    label = json['label'];
    mask = json['mask'];
    maxLength = json['maxLength'];
    isRequired = json['required'];
    category = json['category'];
    type = json['type'];
    customerType = json['customerType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['label'] = this.label;
    data['mask'] = this.mask;
    data['maxLength'] = this.maxLength;
    data['required'] = this.isRequired;
    data['category'] = this.category;
    data['type'] = this.type;
    data['customerType'] = this.customerType;
    data['id'] = this.id;
    return data;
  }
}
