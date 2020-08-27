// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
  Computed<Customer> _$customerComputed;

  @override
  Customer get customer =>
      (_$customerComputed ??= Computed<Customer>(() => super.customer,
              name: '_AuthStoreBase.customer'))
          .value;

  final _$isLoggedInAtom = Atom(name: '_AuthStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  final _$logoutAsyncAction = AsyncAction('_AuthStoreBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$loginAsyncAction = AsyncAction('_AuthStoreBase.login');

  @override
  Future<void> login(String cpf, String password) {
    return _$loginAsyncAction.run(() => super.login(cpf, password));
  }

  final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase');

  @override
  dynamic refreshIsLoggedIn() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.refreshIsLoggedIn');
    try {
      return super.refreshIsLoggedIn();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refreshUserIdentity() {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.refreshUserIdentity');
    try {
      return super.refreshUserIdentity();
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
customer: ${customer}
    ''';
  }
}
