// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionDetailsStore on _TransactionDetailsStoreBase, Store {
  final _$hasErrorAtom = Atom(name: '_TransactionDetailsStoreBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.context.enforceReadPolicy(_$hasErrorAtom);
    _$hasErrorAtom.reportObserved();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.context.conditionallyRunInAction(() {
      super.hasError = value;
      _$hasErrorAtom.reportChanged();
    }, _$hasErrorAtom, name: '${_$hasErrorAtom.name}_set');
  }

  final _$transactionDetailsAtom =
      Atom(name: '_TransactionDetailsStoreBase.transactionDetails');

  @override
  TransactionDetailsResponseModel get transactionDetails {
    _$transactionDetailsAtom.context
        .enforceReadPolicy(_$transactionDetailsAtom);
    _$transactionDetailsAtom.reportObserved();
    return super.transactionDetails;
  }

  @override
  set transactionDetails(TransactionDetailsResponseModel value) {
    _$transactionDetailsAtom.context.conditionallyRunInAction(() {
      super.transactionDetails = value;
      _$transactionDetailsAtom.reportChanged();
    }, _$transactionDetailsAtom, name: '${_$transactionDetailsAtom.name}_set');
  }

  final _$getTransactionDetailsStoreAsyncAction =
      AsyncAction('getTransactionDetailsStore');

  @override
  Future getTransactionDetailsStore(int transactionId) {
    return _$getTransactionDetailsStoreAsyncAction
        .run(() => super.getTransactionDetailsStore(transactionId));
  }

  @override
  String toString() {
    final string =
        'hasError: ${hasError.toString()},transactionDetails: ${transactionDetails.toString()}';
    return '{$string}';
  }
}
