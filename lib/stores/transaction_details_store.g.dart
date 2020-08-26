// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionDetailsStore on _TransactionDetailsStoreBase, Store {
  final _$hasErrorAtom = Atom(name: '_TransactionDetailsStoreBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$transactionDetailsAtom =
      Atom(name: '_TransactionDetailsStoreBase.transactionDetails');

  @override
  TransactionDetailsResponseModel get transactionDetails {
    _$transactionDetailsAtom.reportRead();
    return super.transactionDetails;
  }

  @override
  set transactionDetails(TransactionDetailsResponseModel value) {
    _$transactionDetailsAtom.reportWrite(value, super.transactionDetails, () {
      super.transactionDetails = value;
    });
  }

  final _$getTransactionDetailsStoreAsyncAction =
      AsyncAction('_TransactionDetailsStoreBase.getTransactionDetailsStore');

  @override
  Future getTransactionDetailsStore(int transactionId) {
    return _$getTransactionDetailsStoreAsyncAction
        .run(() => super.getTransactionDetailsStore(transactionId));
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
transactionDetails: ${transactionDetails}
    ''';
  }
}
