// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionPresenter on _TransactionPresenterBase, Store {
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

  final _$createTransactionAsyncAction =
      AsyncAction('_TransactionPresenterBase.createTransaction');

  @override
  Future createTransaction(TransactionCreationViewModel transactionCreation) {
    return _$createTransactionAsyncAction
        .run(() => super.createTransaction(transactionCreation));
  }

  final _$confirmTransactionAsyncAction =
      AsyncAction('_TransactionPresenterBase.confirmTransaction');

  @override
  Future confirmTransaction() {
    return _$confirmTransactionAsyncAction
        .run(() => super.confirmTransaction());
  }

  final _$_TransactionPresenterBaseActionController =
      ActionController(name: '_TransactionPresenterBase');

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
errorMessage: ${errorMessage},
transaction: ${transaction}
    ''';
  }
}
