// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppStore on _AppStoreBase, Store {
  final _$transactionIdAtom = Atom(name: '_AppStoreBase.transactionId');

  @override
  int get transactionId {
    _$transactionIdAtom.reportRead();
    return super.transactionId;
  }

  @override
  set transactionId(int value) {
    _$transactionIdAtom.reportWrite(value, super.transactionId, () {
      super.transactionId = value;
    });
  }

  final _$_AppStoreBaseActionController =
      ActionController(name: '_AppStoreBase');

  @override
  dynamic setTransactionId(int value) {
    final _$actionInfo = _$_AppStoreBaseActionController.startAction(
        name: '_AppStoreBase.setTransactionId');
    try {
      return super.setTransactionId(value);
    } finally {
      _$_AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
transactionId: ${transactionId}
    ''';
  }
}
