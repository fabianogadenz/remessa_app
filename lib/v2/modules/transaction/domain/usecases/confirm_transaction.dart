import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_confirmation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';

class ConfirmTransaction
    implements CommandUseCase<ConfirmTransactionCommand, Future<void>> {
  final TransactionRepository _transactionRepository;

  ConfirmTransaction(this._transactionRepository);

  @override
  Future<void> call(ConfirmTransactionCommand command) async {
    await _transactionRepository.confirm(
      TransactionConfirmationEntity(
        transactionId: command.transactionId,
      ),
    );
  }
}
