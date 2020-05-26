// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_details_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TransactionDetailsScreenStore
    on _TransactionDetailsScreenStoreBase, Store {
  final _$isLoadingAtom =
      Atom(name: '_TransactionDetailsScreenStoreBase.isLoading');

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

  final _$errorMessageAtom =
      Atom(name: '_TransactionDetailsScreenStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.context.enforceReadPolicy(_$errorMessageAtom);
    _$errorMessageAtom.reportObserved();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.context.conditionallyRunInAction(() {
      super.errorMessage = value;
      _$errorMessageAtom.reportChanged();
    }, _$errorMessageAtom, name: '${_$errorMessageAtom.name}_set');
  }

  final _$_TransactionDetailsScreenStoreBaseActionController =
      ActionController(name: '_TransactionDetailsScreenStoreBase');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo =
        _$_TransactionDetailsScreenStoreBaseActionController.startAction();
    try {
      return super.setIsLoading(value);
    } finally {
      _$_TransactionDetailsScreenStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo =
        _$_TransactionDetailsScreenStoreBaseActionController.startAction();
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_TransactionDetailsScreenStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},errorMessage: ${errorMessage.toString()}';
    return '{$string}';
  }
}
