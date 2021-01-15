import '../entities/transaction.dart';
import '../entities/transaction_creation.dart';

abstract class TransactionRepository {
  Future<TransactionEntity> create(TransactionCreationEntity transaction);
}
