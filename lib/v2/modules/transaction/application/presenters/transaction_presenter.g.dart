// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionPresenter on _TransactionPresenterBase, Store {
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

  final _$createAsyncAction = AsyncAction('_TransactionPresenterBase.create');

  @override
  Future create(TransactionCreationViewModel transactionCreation) {
    return _$createAsyncAction.run(() => super.create(transactionCreation));
  }

  @override
  String toString() {
    return '''
transaction: ${transaction}
    ''';
  }
}
