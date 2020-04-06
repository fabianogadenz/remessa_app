// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionsStore on _TransactionsStoreBase, Store {
  final _$isLoadingTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.isLoadingTransactions');

  @override
  bool get isLoadingTransactions {
    _$isLoadingTransactionsAtom.context
        .enforceReadPolicy(_$isLoadingTransactionsAtom);
    _$isLoadingTransactionsAtom.reportObserved();
    return super.isLoadingTransactions;
  }

  @override
  set isLoadingTransactions(bool value) {
    _$isLoadingTransactionsAtom.context.conditionallyRunInAction(() {
      super.isLoadingTransactions = value;
      _$isLoadingTransactionsAtom.reportChanged();
    }, _$isLoadingTransactionsAtom,
        name: '${_$isLoadingTransactionsAtom.name}_set');
  }

  final _$openTransactionsPaginationAtom =
      Atom(name: '_TransactionsStoreBase.openTransactionsPagination');

  @override
  PaginationModel get openTransactionsPagination {
    _$openTransactionsPaginationAtom.context
        .enforceReadPolicy(_$openTransactionsPaginationAtom);
    _$openTransactionsPaginationAtom.reportObserved();
    return super.openTransactionsPagination;
  }

  @override
  set openTransactionsPagination(PaginationModel value) {
    _$openTransactionsPaginationAtom.context.conditionallyRunInAction(() {
      super.openTransactionsPagination = value;
      _$openTransactionsPaginationAtom.reportChanged();
    }, _$openTransactionsPaginationAtom,
        name: '${_$openTransactionsPaginationAtom.name}_set');
  }

  final _$openTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.openTransactions');

  @override
  ObservableList<Transaction> get openTransactions {
    _$openTransactionsAtom.context.enforceReadPolicy(_$openTransactionsAtom);
    _$openTransactionsAtom.reportObserved();
    return super.openTransactions;
  }

  @override
  set openTransactions(ObservableList<Transaction> value) {
    _$openTransactionsAtom.context.conditionallyRunInAction(() {
      super.openTransactions = value;
      _$openTransactionsAtom.reportChanged();
    }, _$openTransactionsAtom, name: '${_$openTransactionsAtom.name}_set');
  }

  final _$closedTransactionsPaginationAtom =
      Atom(name: '_TransactionsStoreBase.closedTransactionsPagination');

  @override
  PaginationModel get closedTransactionsPagination {
    _$closedTransactionsPaginationAtom.context
        .enforceReadPolicy(_$closedTransactionsPaginationAtom);
    _$closedTransactionsPaginationAtom.reportObserved();
    return super.closedTransactionsPagination;
  }

  @override
  set closedTransactionsPagination(PaginationModel value) {
    _$closedTransactionsPaginationAtom.context.conditionallyRunInAction(() {
      super.closedTransactionsPagination = value;
      _$closedTransactionsPaginationAtom.reportChanged();
    }, _$closedTransactionsPaginationAtom,
        name: '${_$closedTransactionsPaginationAtom.name}_set');
  }

  final _$closedTransactionsAtom =
      Atom(name: '_TransactionsStoreBase.closedTransactions');

  @override
  ObservableList<Transaction> get closedTransactions {
    _$closedTransactionsAtom.context
        .enforceReadPolicy(_$closedTransactionsAtom);
    _$closedTransactionsAtom.reportObserved();
    return super.closedTransactions;
  }

  @override
  set closedTransactions(ObservableList<Transaction> value) {
    _$closedTransactionsAtom.context.conditionallyRunInAction(() {
      super.closedTransactions = value;
      _$closedTransactionsAtom.reportChanged();
    }, _$closedTransactionsAtom, name: '${_$closedTransactionsAtom.name}_set');
  }

  final _$getOpenTransactionsAsyncAction = AsyncAction('getOpenTransactions');

  @override
  Future getOpenTransactions(int page) {
    return _$getOpenTransactionsAsyncAction
        .run(() => super.getOpenTransactions(page));
  }

  final _$getClosedTransactionsAsyncAction =
      AsyncAction('getClosedTransactions');

  @override
  Future getClosedTransactions(int page) {
    return _$getClosedTransactionsAsyncAction
        .run(() => super.getClosedTransactions(page));
  }

  final _$getTransactionsAsyncAction = AsyncAction('getTransactions');

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
    final _$actionInfo = _$_TransactionsStoreBaseActionController.startAction();
    try {
      return super.setIsLoadingTransactions(value);
    } finally {
      _$_TransactionsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoadingTransactions: ${isLoadingTransactions.toString()},openTransactionsPagination: ${openTransactionsPagination.toString()},openTransactions: ${openTransactions.toString()},closedTransactionsPagination: ${closedTransactionsPagination.toString()},closedTransactions: ${closedTransactions.toString()}';
    return '{$string}';
  }
}
