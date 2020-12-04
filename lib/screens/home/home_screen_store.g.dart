// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeScreenStore on _HomeScreenStoreBase, Store {
  final _$currentTabIndexAtom =
      Atom(name: '_HomeScreenStoreBase.currentTabIndex');

  @override
  int get currentTabIndex {
    _$currentTabIndexAtom.reportRead();
    return super.currentTabIndex;
  }

  @override
  set currentTabIndex(int value) {
    _$currentTabIndexAtom.reportWrite(value, super.currentTabIndex, () {
      super.currentTabIndex = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_HomeScreenStoreBase.errorMessage');

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

  final _$isLoadingAtom = Atom(name: '_HomeScreenStoreBase.isLoading');

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

  final _$_HomeScreenStoreBaseActionController =
      ActionController(name: '_HomeScreenStoreBase');

  @override
  dynamic setCurrentTabIndex(int index) {
    final _$actionInfo = _$_HomeScreenStoreBaseActionController.startAction(
        name: '_HomeScreenStoreBase.setCurrentTabIndex');
    try {
      return super.setCurrentTabIndex(index);
    } finally {
      _$_HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo = _$_HomeScreenStoreBaseActionController.startAction(
        name: '_HomeScreenStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_HomeScreenStoreBaseActionController.startAction(
        name: '_HomeScreenStoreBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_HomeScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentTabIndex: ${currentTabIndex},
errorMessage: ${errorMessage},
isLoading: ${isLoading}
    ''';
  }
}
