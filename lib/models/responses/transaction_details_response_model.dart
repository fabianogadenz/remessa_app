import 'package:remessa_app/helpers/transaction_status.dart';

class TransactionDetailsResponseModel {
  int id;
  String createdAt;
  String updatedAt;
  String flow;
  String transactionName;
  String purpose;
  String arrivalEstimate;
  String ffc;
  String paymentDeadline;
  int statusId;
  String statusName;
  TransactionStatus status;
  Quote quote;
  Counterpart counterpart;
  PaymentAccountInfo paymentAccountInfo;

  TransactionDetailsResponseModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.flow,
    this.statusId,
    this.statusName,
    this.transactionName,
    this.purpose,
    this.quote,
    this.counterpart,
    this.paymentAccountInfo,
  });

  TransactionDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    flow = json['flow'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    transactionName = json['transactionName'];
    purpose = json['purpose'];
    arrivalEstimate = json['arrivalEstimate'];
    ffc = json['ffc'];
    paymentDeadline = json['paymentDeadline'];

    status = TransactionStatusHelper.parse(statusId);
    quote = json['quote'] != null ? new Quote.fromJson(json['quote']) : null;
    counterpart = json['counterpart'] != null
        ? new Counterpart.fromJson(json['counterpart'])
        : null;
    paymentAccountInfo = json['paymentAccountInfo'] != null
        ? new PaymentAccountInfo.fromJson(json['paymentAccountInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['flow'] = this.flow;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['transactionName'] = this.transactionName;
    data['purpose'] = this.purpose;
    data['arrivalEstimate'] = this.arrivalEstimate;
    data['ffc'] = this.ffc;
    data['paymentDeadline'] = this.paymentDeadline;
    if (this.quote != null) {
      data['quote'] = this.quote.toJson();
    }
    if (this.counterpart != null) {
      data['counterpart'] = this.counterpart.toJson();
    }
    if (this.paymentAccountInfo != null) {
      data['paymentAccountInfo'] = this.paymentAccountInfo.toJson();
    }
    return data;
  }
}

class Quote {
  String foreignCurrency;
  double foreignCurrencyAmount;
  String nationalCurrency;
  double nationalCurrencyTotalAmount;
  double nationalCurrencySubAmount;
  double exchangeRate;
  double vet;
  double spread;
  double tradingQuotation;
  String voucherCode;
  double spreadDiscount;
  List<FeesTaxes> feesTaxes;

  Quote({
    this.foreignCurrency,
    this.foreignCurrencyAmount,
    this.nationalCurrency,
    this.nationalCurrencyTotalAmount,
    this.nationalCurrencySubAmount,
    this.exchangeRate,
    this.vet,
    this.spread,
    this.tradingQuotation,
    this.feesTaxes,
    this.voucherCode,
    this.spreadDiscount,
  });

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
    tradingQuotation = json['tradingQuotation'].toDouble();
    voucherCode = json['voucherCode'];
    if (json['spreadDiscount'] != null) {
      spreadDiscount = json['spreadDiscount'].toDouble();
    }
    if (json['feesTaxes'] != null) {
      feesTaxes = new List<FeesTaxes>();
      json['feesTaxes'].forEach((v) {
        feesTaxes.add(new FeesTaxes.fromJson(v));
      });
    }
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
    data['tradingQuotation'] = this.tradingQuotation;
    data['voucherCode'] = this.voucherCode;
    data['spreadDiscount'] = this.spreadDiscount;
    if (this.feesTaxes != null) {
      data['feesTaxes'] = this.feesTaxes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesTaxes {
  String label;
  String description;
  double value;

  FeesTaxes({
    this.label,
    this.description,
    this.value,
  });

  FeesTaxes.fromJson(Map<String, dynamic> json) {
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

class Counterpart {
  String name;
  String country;
  String bankName;
  List<AccountInfo> accountInfo;
  List<IntermediaryBankInfo> intermediaryBankInfo;

  Counterpart(
      {this.name,
      this.country,
      this.bankName,
      this.accountInfo,
      this.intermediaryBankInfo});

  Counterpart.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    bankName = json['bankName'];
    if (json['accountInfo'] != null) {
      accountInfo = new List<AccountInfo>();
      json['accountInfo'].forEach((v) {
        accountInfo.add(new AccountInfo.fromJson(v));
      });
    }
    if (json['intermediaryBankInfo'] != null) {
      intermediaryBankInfo = new List<IntermediaryBankInfo>();
      json['intermediaryBankInfo'].forEach((v) {
        intermediaryBankInfo.add(new IntermediaryBankInfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['bankName'] = this.bankName;
    if (this.accountInfo != null) {
      data['accountInfo'] = this.accountInfo.map((v) => v.toJson()).toList();
    }
    if (this.intermediaryBankInfo != null) {
      data['intermediaryBankInfo'] =
          this.intermediaryBankInfo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccountInfo {
  String label;
  String description;
  String value;

  AccountInfo({this.label, this.description, this.value});

  AccountInfo.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['description'] = this.description;
    data['value'] = this.value;
    return data;
  }
}

class IntermediaryBankInfo {
  String description;
  bool required;
  String mask;
  String label;
  String type;
  String id;
  String value;
  bool isIntermedianBank;

  IntermediaryBankInfo(
      {this.description,
      this.required,
      this.mask,
      this.label,
      this.type,
      this.id,
      this.value,
      this.isIntermedianBank});

  IntermediaryBankInfo.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    required = json['required'];
    mask = json['mask'];
    label = json['label'];
    type = json['type'];
    id = json['id'];
    value = json['value'];
    isIntermedianBank = json['isIntermedianBank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['required'] = this.required;
    data['mask'] = this.mask;
    data['label'] = this.label;
    data['type'] = this.type;
    data['id'] = this.id;
    data['value'] = this.value;
    data['isIntermedianBank'] = this.isIntermedianBank;
    return data;
  }
}

class PaymentAccountInfo {
  String accountHolderName;
  String accountHolderDocumentNumber;
  String bankName;
  String bankCode;
  String branchCode;
  String accountNumber;

  PaymentAccountInfo(
      {this.accountHolderName,
      this.accountHolderDocumentNumber,
      this.bankName,
      this.bankCode,
      this.branchCode,
      this.accountNumber});

  PaymentAccountInfo.fromJson(Map<String, dynamic> json) {
    accountHolderName = json['accountHolderName'];
    accountHolderDocumentNumber = json['accountHolderDocumentNumber'];
    bankName = json['bankName'];
    bankCode = json['bankCode'];
    branchCode = json['branchCode'];
    accountNumber = json['accountNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accountHolderName'] = this.accountHolderName;
    data['accountHolderDocumentNumber'] = this.accountHolderDocumentNumber;
    data['bankName'] = this.bankName;
    data['bankCode'] = this.bankCode;
    data['branchCode'] = this.branchCode;
    data['accountNumber'] = this.accountNumber;
    return data;
  }
}
