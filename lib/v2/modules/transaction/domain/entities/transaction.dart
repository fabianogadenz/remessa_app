import 'package:remessa_app/v2/modules/transaction/domain/entities/status.dart';

import 'beneficiary.dart';
import 'quote.dart';

class TransactionEntity {
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

  TransactionEntity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.flow,
    this.transactionName,
    this.purpose,
    this.analysisLevel,
    this.quote,
    this.beneficiary,
    this.arrivalEstimate,
    this.paymentDeadline,
    this.status,
  });
}
