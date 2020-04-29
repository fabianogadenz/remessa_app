// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$transactionIdAtom = Atom(name: '_AppStoreBase.transactionId');

  @override
  int get transactionId {
    _$transactionIdAtom.context.enforceReadPolicy(_$transactionIdAtom);
    _$transactionIdAtom.reportObserved();
    return super.transactionId;
  }

  @override
  set transactionId(int value) {
    _$transactionIdAtom.context.conditionallyRunInAction(() {
      super.transactionId = value;
      _$transactionIdAtom.reportChanged();
    }, _$transactionIdAtom, name: '${_$transactionIdAtom.name}_set');
  }

  final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase');

  @override
  dynamic setTransactionId(int value) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction();
    try {
      return super.setTransactionId(value);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'transactionId: ${transactionId.toString()}';
    return '{$string}';
  }
}
