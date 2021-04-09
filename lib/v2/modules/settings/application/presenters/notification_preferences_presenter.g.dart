// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_presenter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NotificationPreferencesPresenter
    on _NotificationPreferencesPresenterBase, Store {
  final _$errorMessageAtom =
      Atom(name: '_NotificationPreferencesPresenterBase.errorMessage');

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

  final _$transactionAtom =
      Atom(name: '_NotificationPreferencesPresenterBase.transaction');

  @override
  TransactionViewModel get transaction {
    _$transactionAtom.reportRead();
    return super.transaction;
  }

  @override
  set transaction(TransactionViewModel value) {
    _$transactionAtom.reportWrite(value, super.transaction, () {
      super.transaction = value;
    });
  }

  final _$updateNoficiationPreferencesAsyncAction = AsyncAction(
      '_NotificationPreferencesPresenterBase.updateNoficiationPreferences');

  @override
  Future updateNoficiationPreferences(
      NotificationPreferencesViewModel notificationPreferences) {
    return _$updateNoficiationPreferencesAsyncAction
        .run(() => super.updateNoficiationPreferences(notificationPreferences));
  }

  final _$_NotificationPreferencesPresenterBaseActionController =
      ActionController(name: '_NotificationPreferencesPresenterBase');

  @override
  dynamic setErrorMessage(String value) {
    final _$actionInfo =
        _$_NotificationPreferencesPresenterBaseActionController.startAction(
            name: '_NotificationPreferencesPresenterBase.setErrorMessage');
    try {
      return super.setErrorMessage(value);
    } finally {
      _$_NotificationPreferencesPresenterBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
transaction: ${transaction}
    ''';
  }
}
