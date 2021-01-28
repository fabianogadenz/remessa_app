import '../entities/transaction.dart';
import '../entities/transaction_creation.dart';
import '../entities/transaction_confirmation.dart';

abstract class TransactionRepository {
  Future<TransactionEntity> create(TransactionCreationEntity transaction);
  Future<void> confirm(TransactionConfirmationEntity transaction);
}
