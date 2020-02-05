import 'package:remessa_app/models/pagination_model.dart';

class TransactionResponseModel {
  PaginationModel pagination;
  List<Transaction> items;

  TransactionResponseModel({this.pagination, this.items});

  TransactionResponseModel.fromJson(Map<String, dynamic> json) {
    pagination = PaginationModel.fromJson(json);
    if (json['items'] != null) {
      items = new List<Transaction>();
      json['items'].forEach((v) {
        items.add(new Transaction.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = pagination.size;
    data['page'] = pagination.page;
    data['totalItems'] = pagination.totalItems;
    data['totalPages'] = pagination.totalPages;
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transaction {
  int id;
  String createdAt;
  String updatedAt;
  String foreignCurrency;
  String foreignCurrencyAmount;
  String nationalCurrency;
  String nationalCurrencyTotalAmount;
  String flow;
  int statusId;
  String statusName;
  String counterpartName;
  String transactionName;

  Transaction(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.foreignCurrency,
      this.foreignCurrencyAmount,
      this.nationalCurrency,
      this.nationalCurrencyTotalAmount,
      this.flow,
      this.statusId,
      this.statusName,
      this.counterpartName,
      this.transactionName});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    foreignCurrency = json['foreignCurrency'];
    foreignCurrencyAmount = json['foreignCurrencyAmount'];
    nationalCurrency = json['nationalCurrency'];
    nationalCurrencyTotalAmount = json['nationalCurrencyTotalAmount'];
    flow = json['flow'];
    statusId = json['statusId'];
    statusName = json['statusName'];
    counterpartName = json['counterpartName'];
    transactionName = json['transactionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['foreignCurrency'] = this.foreignCurrency;
    data['foreignCurrencyAmount'] = this.foreignCurrencyAmount;
    data['nationalCurrency'] = this.nationalCurrency;
    data['nationalCurrencyTotalAmount'] = this.nationalCurrencyTotalAmount;
    data['flow'] = this.flow;
    data['statusId'] = this.statusId;
    data['statusName'] = this.statusName;
    data['counterpartName'] = this.counterpartName;
    data['transactionName'] = this.transactionName;
    return data;
  }
}
