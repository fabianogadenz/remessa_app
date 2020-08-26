// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginScreenStore on _LoginScreenStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_LoginScreenStoreBase.isLoading');

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

  final _$errorMessageAtom = Atom(name: '_LoginScreenStoreBase.errorMessage');

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

  final _$loginAsyncAction = AsyncAction('_LoginScreenStoreBase.login');

  @override
  Future login(String cpf, String password) {
    return _$loginAsyncAction.run(() => super.login(cpf, password));
  }

  final _$_LoginScreenStoreBaseActionController =
      ActionController(name: '_LoginScreenStoreBase');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_LoginScreenStoreBaseActionController.startAction(
        name: '_LoginScreenStoreBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_LoginScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo = _$_LoginScreenStoreBaseActionController.startAction(
        name: '_LoginScreenStoreBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_LoginScreenStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
