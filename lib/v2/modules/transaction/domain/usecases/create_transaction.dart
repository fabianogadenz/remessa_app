import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/create_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/currency.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_creation.dart';
import 'package:remessa_app/v2/modules/transaction/domain/repositories/transaction_repository.dart';

class CreateTransaction
    implements
        CommandUseCase<CreateTransactionCommand, Future<TransactionEntity>> {
  final TransactionRepository _transactionRepository;

  CreateTransaction(this._transactionRepository);

  @override
  Future<TransactionEntity> call(CreateTransactionCommand command) async {
    TransactionEntity createdTransaction;

    try {
      createdTransaction = await _transactionRepository.create(
        TransactionCreationEntity(
          operationType: command.operationType,
          reverse: command.reverse,
          quantity: command.quantity,
          totalValue: command.totalValue,
          voucher: command.voucher,
          currency: CurrencyEntity(
            id: command.currencyId,
            abbreviation: command.currencyAbbreviation,
          ),
          beneficiary: BeneficiaryEntity(
            id: command.beneficiaryId,
          ),
        ),
      );
    } catch (_) {
      // TODO: Add error handler
    }

    return createdTransaction;
  }
}
