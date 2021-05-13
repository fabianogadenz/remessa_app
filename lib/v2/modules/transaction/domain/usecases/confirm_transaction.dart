import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_confirmation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';

class ConfirmTransaction
    implements
        CommandUseCase<ConfirmTransactionCommand,
            Future<PaymentAccountInfoEntity>> {
  final TransactionRepository _transactionRepository;

  ConfirmTransaction(this._transactionRepository);

  @override
  Future<PaymentAccountInfoEntity> call(
      ConfirmTransactionCommand command) async {
    final paymentAccountInfo = await _transactionRepository.confirm(
      TransactionConfirmationEntity(
        transactionId: command.transactionId,
      ),
    );

    return paymentAccountInfo;
  }
}
