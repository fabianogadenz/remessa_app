// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionsStore on _TransactionsStoreBase, Store {
  final _$isLoadingTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.isLoadingTransactions');

  @override
  bool get isLoadingTransactions {
    _$isLoadingTransactionsAtom.reportRead();
    return super.isLoadingTransactions;
  }

  @override
  set isLoadingTransactions(bool value) {
    _$isLoadingTransactionsAtom.reportWrite(value, super.isLoadingTransactions,
        () {
      super.isLoadingTransactions = value;
    });
  }

  final _$openTransactionsPaginationAtom =
      Atom(name: '_TransactionsStoreBase.openTransactionsPagination');

  @override
  PaginationModel get openTransactionsPagination {
    _$openTransactionsPaginationAtom.reportRead();
    return super.openTransactionsPagination;
  }

  @override
  set openTransactionsPagination(PaginationModel value) {
    _$openTransactionsPaginationAtom
        .reportWrite(value, super.openTransactionsPagination, () {
      super.openTransactionsPagination = value;
    });
  }

  final _$openTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.openTransactions');

  @override
  ObservableList<Transaction> get openTransactions {
    _$openTransactionsAtom.reportRead();
    return super.openTransactions;
  }

  @override
  set openTransactions(ObservableList<Transaction> value) {
    _$openTransactionsAtom.reportWrite(value, super.openTransactions, () {
      super.openTransactions = value;
    });
  }

  final _$closedTransactionsPaginationAtom =
      Atom(name: '_TransactionsStoreBase.closedTransactionsPagination');

  @override
  PaginationModel get closedTransactionsPagination {
    _$closedTransactionsPaginationAtom.reportRead();
    return super.closedTransactionsPagination;
  }

  @override
  set closedTransactionsPagination(PaginationModel value) {
    _$closedTransactionsPaginationAtom
        .reportWrite(value, super.closedTransactionsPagination, () {
      super.closedTransactionsPagination = value;
    });
  }

  final _$closedTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.closedTransactions');

  @override
  ObservableList<Transaction> get closedTransactions {
    _$closedTransactionsAtom.reportRead();
    return super.closedTransactions;
  }

  @override
  set closedTransactions(ObservableList<Transaction> value) {
    _$closedTransactionsAtom.reportWrite(value, super.closedTransactions, () {
      super.closedTransactions = value;
    });
  }

  final _$getOpenTransactionsAsyncAction =
      AsyncAction('_TransactionsStoreBase.getOpenTransactions');

  @override
  Future getOpenTransactions(int page) {
    return _$getOpenTransactionsAsyncAction
        .run(() => super.getOpenTransactions(page));
  }

  final _$getClosedTransactionsAsyncAction =
      AsyncAction('_TransactionsStoreBase.getClosedTransactions');

  @override
  Future getClosedTransactions(int page) {
    return _$getClosedTransactionsAsyncAction
        .run(() => super.getClosedTransactions(page));
  }

  final _$getTransactionsAsyncAction =
      AsyncAction('_TransactionsStoreBase.getTransactions');

  @override
  Future getTransactions(
      {int openTransactionsPage, int closedTransactionsPage}) {
    return _$getTransactionsAsyncAction.run(() => super.getTransactions(
        openTransactionsPage: openTransactionsPage,
        closedTransactionsPage: closedTransactionsPage));
  }

  final _$_TransactionsStoreBaseActionController =
      ActionController(name: '_TransactionsStoreBase');

  @override
  dynamic setIsLoadingTransactions(bool value) {
    final _$actionInfo = _$_TransactionsStoreBaseActionController.startAction(
        name: '_TransactionsStoreBase.setIsLoadingTransactions');
    try {
      return super.setIsLoadingTransactions(value);
    } finally {
      _$_TransactionsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoadingTransactions: ${isLoadingTransactions},
openTransactionsPagination: ${openTransactionsPagination},
openTransactions: ${openTransactions},
closedTransactionsPagination: ${closedTransactionsPagination},
closedTransactions: ${closedTransactions}
    ''';
  }
}
