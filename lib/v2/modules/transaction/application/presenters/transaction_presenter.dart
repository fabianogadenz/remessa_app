import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/models/view_generators/warning_modal_model.dart';
import 'package:remessa_app/v2/core/errors/error_message.dart';
import 'package:remessa_app/v2/core/handlers/show_modal_handler.dart';
import 'package:remessa_app/v2/core/usecase/usecase.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_creation_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/confirm_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/commands/create_transaction_command.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction.dart';

part 'transaction_presenter.g.dart';

class TransactionPresenter = _TransactionPresenterBase
    with _$TransactionPresenter;

abstract class _TransactionPresenterBase with Store {
  final CommandUseCase<CreateTransactionCommand, Future<TransactionEntity>>
      _createTransaction;
  final CommandUseCase<ConfirmTransactionCommand, Future<void>>
      _confirmTransaction;

  _TransactionPresenterBase(
    this._createTransaction,
    this._confirmTransaction,
  );

  @observable
  bool isLoading = false;

  @action
  setIsLoading(bool value) => isLoading = value;

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => errorMessage = value;

  @observable
  TransactionViewModel transaction;

  @action
  createTransaction(TransactionCreationViewModel transactionCreation,
      BuildContext context) async {
    try {
      setErrorMessage('');
      setIsLoading(true);

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
    } on WarningModalModel catch (warning) {
      ShowModalHandler(
        modalWidget: warning.generate(),
        isDismissible: warning.hasCloseButton,
      ).call(context);
    } on ErrorModel catch (error) {
      setErrorMessage(error?.mainError?.message);
    } on ErrorMessage catch (error) {
      setErrorMessage(error.message);
    } finally {
      setIsLoading(false);
    }
  }

  @observable
  bool confirmationSuccess = false;

  @action
  confirmTransaction(BuildContext context) async {
    try {
      setErrorMessage('');
      setIsLoading(true);

      await _confirmTransaction(
        ConfirmTransactionCommand(
          transactionId: transaction.id,
        ),
      );

      confirmationSuccess = true;
    } on ErrorModel catch (error) {
      setErrorMessage(error?.mainError?.message);
    } on ErrorMessage catch (error) {
      setErrorMessage(error.message);
    } on WarningModalModel catch (warning) {
      ShowModalHandler(
        modalWidget: warning.generate(),
        isDismissible: warning.hasCloseButton,
      ).call(context);
    } finally {
      setIsLoading(false);
    }
  }
}
