// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tab_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TabControllerStore on _TabControllerStoreBase, Store {
  final _$currentTabIndexAtom =
      Atom(name: '_TabControllerStoreBase.currentTabIndex');

  @override
  int get currentTabIndex {
    _$currentTabIndexAtom.context.enforceReadPolicy(_$currentTabIndexAtom);
    _$currentTabIndexAtom.reportObserved();
    return super.currentTabIndex;
  }

  @override
  set currentTabIndex(int value) {
    _$currentTabIndexAtom.context.conditionallyRunInAction(() {
      super.currentTabIndex = value;
      _$currentTabIndexAtom.reportChanged();
    }, _$currentTabIndexAtom, name: '${_$currentTabIndexAtom.name}_set');
  }

  final _$errorMessageAtom = Atom(name: '_TabControllerStoreBase.errorMessage');

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

  final _$isLoadingAtom = Atom(name: '_TabControllerStoreBase.isLoading');

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

  final _$_TabControllerStoreBaseActionController =
      ActionController(name: '_TabControllerStoreBase');

  @override
  dynamic setCurrentTabIndex(int index) {
    final _$actionInfo =
        _$_TabControllerStoreBaseActionController.startAction();
    try {
      return super.setCurrentTabIndex(index);
    } finally {
      _$_TabControllerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo =
        _$_TabControllerStoreBaseActionController.startAction();
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_TabControllerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo =
        _$_TabControllerStoreBaseActionController.startAction();
    try {
      return super.setIsLoading(value);
    } finally {
      _$_TabControllerStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'currentTabIndex: ${currentTabIndex.toString()},errorMessage: ${errorMessage.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}
