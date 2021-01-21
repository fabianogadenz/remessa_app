import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';

import 'beneficiary_viewmodel.dart';
import 'quote_viewmodel.dart';
import 'status_viewmodel.dart';

class TransactionViewModel {
  final int id;
  final String createdAt;
  final String updatedAt;
  final String flow;
  final String transactionName;
  final String purpose;
  final int analysisLevel;
  final QuoteViewModel quote;
  final BeneficiaryViewModel beneficiary;
  final String arrivalEstimate;
  final String paymentDeadline;
  final StatusViewModel status;

  TransactionViewModel({
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

  factory TransactionViewModel.fromEntity(
          TransactionEntity transactionEntity) =>
      TransactionViewModel(
        id: transactionEntity.id,
        createdAt: transactionEntity.createdAt,
        updatedAt: transactionEntity.updatedAt,
        flow: transactionEntity.flow,
        transactionName: transactionEntity.transactionName,
        purpose: transactionEntity.purpose,
        analysisLevel: transactionEntity.analysisLevel,
        quote: (transactionEntity.quote != null)
            ? QuoteViewModel.fromEntity(transactionEntity.quote)
            : null,
        beneficiary: (transactionEntity.beneficiary != null)
            ? BeneficiaryViewModel.fromEntity(transactionEntity.beneficiary)
            : null,
        arrivalEstimate: transactionEntity.arrivalEstimate,
        paymentDeadline: transactionEntity.paymentDeadline,
        status: (transactionEntity.status != null)
            ? StatusViewModel(
                id: transactionEntity.status.id,
                name: transactionEntity.status.name,
              )
            : null,
      );
}
