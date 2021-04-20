// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStoreBase, Store {
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

  final _$customerAtom = Atom(name: '_AuthStoreBase.customer');

  @override
  Customer get customer {
    _$customerAtom.reportRead();
    return super.customer;
  }

  @override
  set customer(Customer value) {
    _$customerAtom.reportWrite(value, super.customer, () {
      super.customer = value;
    });
  }

  final _$refreshUserIdentityAsyncAction =
      AsyncAction('_AuthStoreBase.refreshUserIdentity');

  @override
  Future refreshUserIdentity() {
    return _$refreshUserIdentityAsyncAction
        .run(() => super.refreshUserIdentity());
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

  @override
  String toString() {
    return '''
isLoggedIn: ${isLoggedIn},
customer: ${customer}
    ''';
  }
}
