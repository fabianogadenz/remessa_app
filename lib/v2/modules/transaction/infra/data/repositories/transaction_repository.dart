import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_confirmation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_creation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/transaction_creation_model.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/transaction_model.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final HttpAdapter httpAdapter;

  TransactionRepositoryImpl(this.httpAdapter);

  @override
  Future<TransactionEntity> create(
      TransactionCreationEntity transaction) async {
    TransactionEntity transactionEntity;

    try {
      final json = await httpAdapter.post(
        '/transaction',
        data: TransactionCreationModel(
          beneficiary: transaction.beneficiary,
          currency: transaction.currency,
          operationType: transaction.operationType,
          quantity: transaction.quantity,
          reverse: transaction.reverse,
          totalValue: transaction.totalValue,
          voucher: transaction.voucher,
        ).toJson(),
      );

      transactionEntity = TransactionModel.fromJson(json);
    } catch (_) {
      // TODO: Implement error handler
    }

    return transactionEntity;
  }

  @override
  Future<void> confirm(TransactionConfirmationEntity transaction) async {
    try {
      await httpAdapter
          .put('/transaction/${transaction.transactionId}/confirm');
    } catch (_) {
      // TODO: Implement error handler
    }
  }
}
