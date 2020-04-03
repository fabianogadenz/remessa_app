// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$isLoggedInAtom = Atom(name: '_AppStoreBase.isLoggedIn');

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.context.enforceReadPolicy(_$isLoggedInAtom);
    _$isLoggedInAtom.reportObserved();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.context.conditionallyRunInAction(() {
      super.isLoggedIn = value;
      _$isLoggedInAtom.reportChanged();
    }, _$isLoggedInAtom, name: '${_$isLoggedInAtom.name}_set');
  }

  final _$logoutAsyncAction = AsyncAction('logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase');

  @override
  dynamic refreshIsLoggedIn() {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction();
    try {
      return super.refreshIsLoggedIn();
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'isLoggedIn: ${isLoggedIn.toString()}';
    return '{$string}';
  }
}
