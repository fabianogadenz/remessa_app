// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DashboardScreenStore on _DashboardScreenStore, Store {
  Computed<bool> _$isEmptyComputed;

  @override
  bool get isEmpty =>
      (_$isEmptyComputed ??= Computed<bool>(() => super.isEmpty)).value;

  final _$openTransactionsPaginationAtom =
      Atom(name: '_DashboardScreenStore.openTransactionsPagination');

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
      Atom(name: '_DashboardScreenStore.openTransactions');

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
      Atom(name: '_DashboardScreenStore.closedTransactionsPagination');

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
      Atom(name: '_DashboardScreenStore.closedTransactions');

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

  final _$isLoadingAtom = Atom(name: '_DashboardScreenStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
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

  final _$_DashboardScreenStoreActionController =
      ActionController(name: '_DashboardScreenStore');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_DashboardScreenStoreActionController.startAction();
    try {
      return super.setIsLoading(value);
    } finally {
      _$_DashboardScreenStoreActionController.endAction(_$actionInfo);
    }
  }
}
