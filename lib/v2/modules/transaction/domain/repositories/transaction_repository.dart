import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';

import '../entities/transaction.dart';
import '../entities/transaction_creation.dart';
import '../entities/transaction_confirmation.dart';

abstract class TransactionRepository {
  Future<TransactionEntity> create(TransactionCreationEntity transaction);
  Future<PaymentAccountInfoEntity> confirm(
      TransactionConfirmationEntity transaction);
}
