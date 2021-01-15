import 'package:mobx/mobx.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_creation_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/create_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';

part 'transaction_presenter.g.dart';

class TransactionPresenter = _TransactionPresenterBase
    with _$TransactionPresenter;

abstract class _TransactionPresenterBase with Store {
  final CommandUseCase<CreateTransactionCommand, Future<TransactionEntity>>
      _createTransaction;

  _TransactionPresenterBase(this._createTransaction);

  @observable
  TransactionViewModel transaction;

  @action
  create(TransactionCreationViewModel transactionCreation) async {
    final createdTransaction = await _createTransaction(
      CreateTransactionCommand(
        beneficiaryId: transactionCreation.beneficiaryId,
        currencyId: transactionCreation.currencyId,
        currencyAbbreviation: transactionCreation.currencyAbbreviation,
        operationType: transactionCreation.operationType,
        quantity: transactionCreation.quantity,
        reverse: transactionCreation.reverse,
        totalValue: transactionCreation.totalValue,
        voucher: transactionCreation.voucher,
      ),
    );

    transaction = TransactionViewModel.fromEntity(createdTransaction);
  }
}
