import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/quote.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/status.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/beneficiary_model.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/quote_model.dart';

class TransactionModel extends TransactionEntity {
  int id;
  String createdAt;
  String updatedAt;
  String flow;
  String transactionName;
  String purpose;
  int analysisLevel;
  QuoteEntity quote;
  BeneficiaryEntity beneficiary;
  String arrivalEstimate;
  String paymentDeadline;
  StatusEntity status;

  TransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    flow = json['flow'];
    transactionName = json['transactionName'];
    purpose = json['purpose'];
    analysisLevel = json['analysisLevel'];
    quote = json['quote'] != null ? QuoteModel.fromJson(json['quote']) : null;
    beneficiary = json['counterpart'] != null
        ? BeneficiaryModel.fromJson(json['counterpart'])
        : null;
    arrivalEstimate = json['arrivalEstimate'];
    paymentDeadline = json['paymentDeadline'];
    status = StatusEntity(
      id: json['statusId'],
      name: json['statusName'],
    );
  }
}
