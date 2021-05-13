// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionPresenter on _TransactionPresenterBase, Store {
  final _$isLoadingAtom = Atom(name: '_TransactionPresenterBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$errorMessageAtom =
      Atom(name: '_TransactionPresenterBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$transactionAtom = Atom(name: '_TransactionPresenterBase.transaction');

  @override
  TransactionViewModel get transaction {
    _$transactionAtom.reportRead();
    return super.transaction;
  }

  @override
  set transaction(TransactionViewModel value) {
    _$transactionAtom.reportWrite(value, super.transaction, () {
      super.transaction = value;
    });
  }

  final _$confirmationSuccessAtom =
      Atom(name: '_TransactionPresenterBase.confirmationSuccess');

  @override
  bool get confirmationSuccess {
    _$confirmationSuccessAtom.reportRead();
    return super.confirmationSuccess;
  }

  @override
  set confirmationSuccess(bool value) {
    _$confirmationSuccessAtom.reportWrite(value, super.confirmationSuccess, () {
      super.confirmationSuccess = value;
    });
  }

  final _$confirmatedTransactionAtom =
      Atom(name: '_TransactionPresenterBase.confirmatedTransaction');

  @override
  ConfirmatedTransactionViewModel get confirmatedTransaction {
    _$confirmatedTransactionAtom.reportRead();
    return super.confirmatedTransaction;
  }

  @override
  set confirmatedTransaction(ConfirmatedTransactionViewModel value) {
    _$confirmatedTransactionAtom
        .reportWrite(value, super.confirmatedTransaction, () {
      super.confirmatedTransaction = value;
    });
  }

  final _$createTransactionAsyncAction =
      AsyncAction('_TransactionPresenterBase.createTransaction');

  @override
  Future createTransaction(
      TransactionCreationViewModel transactionCreation, BuildContext context) {
    return _$createTransactionAsyncAction
        .run(() => super.createTransaction(transactionCreation, context));
  }

  final _$confirmTransactionAsyncAction =
      AsyncAction('_TransactionPresenterBase.confirmTransaction');

  @override
  Future confirmTransaction(BuildContext context) {
    return _$confirmTransactionAsyncAction
        .run(() => super.confirmTransaction(context));
  }

  final _$_TransactionPresenterBaseActionController =
      ActionController(name: '_TransactionPresenterBase');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_TransactionPresenterBaseActionController
        .startAction(name: '_TransactionPresenterBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_TransactionPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo = _$_TransactionPresenterBaseActionController
        .startAction(name: '_TransactionPresenterBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_TransactionPresenterBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
transaction: ${transaction},
confirmationSuccess: ${confirmationSuccess},
confirmatedTransaction: ${confirmatedTransaction}
    ''';
  }
}
