// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulatorStore on _SimulatorStoreBase, Store {
  Computed<Currencies> _$currenciesComputed;

  @override
  Currencies get currencies =>
      (_$currenciesComputed ??= Computed<Currencies>(() => super.currencies,
              name: '_SimulatorStoreBase.currencies'))
          .value;

  final _$beneficiaryAtom = Atom(name: '_SimulatorStoreBase.beneficiary');

  @override
  Beneficiary get beneficiary {
    _$beneficiaryAtom.reportRead();
    return super.beneficiary;
  }

  @override
  set beneficiary(Beneficiary value) {
    _$beneficiaryAtom.reportWrite(value, super.beneficiary, () {
      super.beneficiary = value;
    });
  }

  final _$isReverseAtom = Atom(name: '_SimulatorStoreBase.isReverse');

  @override
  bool get isReverse {
    _$isReverseAtom.reportRead();
    return super.isReverse;
  }

  @override
  set isReverse(bool value) {
    _$isReverseAtom.reportWrite(value, super.isReverse, () {
      super.isReverse = value;
    });
  }

  final _$shouldRefreshAtom = Atom(name: '_SimulatorStoreBase.shouldRefresh');

  @override
  bool get shouldRefresh {
    _$shouldRefreshAtom.reportRead();
    return super.shouldRefresh;
  }

  @override
  set shouldRefresh(bool value) {
    _$shouldRefreshAtom.reportWrite(value, super.shouldRefresh, () {
      super.shouldRefresh = value;
    });
  }

  final _$quantityAtom = Atom(name: '_SimulatorStoreBase.quantity');

  @override
  double get quantity {
    _$quantityAtom.reportRead();
    return super.quantity;
  }

  @override
  set quantity(double value) {
    _$quantityAtom.reportWrite(value, super.quantity, () {
      super.quantity = value;
    });
  }

  final _$totalValueAtom = Atom(name: '_SimulatorStoreBase.totalValue');

  @override
  double get totalValue {
    _$totalValueAtom.reportRead();
    return super.totalValue;
  }

  @override
  set totalValue(double value) {
    _$totalValueAtom.reportWrite(value, super.totalValue, () {
      super.totalValue = value;
    });
  }

  final _$hasErrorAtom = Atom(name: '_SimulatorStoreBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.reportRead();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.reportWrite(value, super.hasError, () {
      super.hasError = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_SimulatorStoreBase.isLoading');

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

  final _$fieldErrorsAtom = Atom(name: '_SimulatorStoreBase.fieldErrors');

  @override
  List<ErrorResponseModel> get fieldErrors {
    _$fieldErrorsAtom.reportRead();
    return super.fieldErrors;
  }

  @override
  set fieldErrors(List<ErrorResponseModel> value) {
    _$fieldErrorsAtom.reportWrite(value, super.fieldErrors, () {
      super.fieldErrors = value;
    });
  }

  final _$simulatorResponseAtom =
      Atom(name: '_SimulatorStoreBase.simulatorResponse');

  @override
  SimulatorResponseModel get simulatorResponse {
    _$simulatorResponseAtom.reportRead();
    return super.simulatorResponse;
  }

  @override
  set simulatorResponse(SimulatorResponseModel value) {
    _$simulatorResponseAtom.reportWrite(value, super.simulatorResponse, () {
      super.simulatorResponse = value;
    });
  }

  final _$simulatorDefaultValuesResponseModelAtom =
      Atom(name: '_SimulatorStoreBase.simulatorDefaultValuesResponseModel');

  @override
  SimulatorDefaultValuesResponseModel get simulatorDefaultValuesResponseModel {
    _$simulatorDefaultValuesResponseModelAtom.reportRead();
    return super.simulatorDefaultValuesResponseModel;
  }

  @override
  set simulatorDefaultValuesResponseModel(
      SimulatorDefaultValuesResponseModel value) {
    _$simulatorDefaultValuesResponseModelAtom
        .reportWrite(value, super.simulatorDefaultValuesResponseModel, () {
      super.simulatorDefaultValuesResponseModel = value;
    });
  }

  final _$simulateAsyncAction = AsyncAction('_SimulatorStoreBase.simulate');

  @override
  Future simulate() {
    return _$simulateAsyncAction.run(() => super.simulate());
  }

  final _$getDefaultValuesAsyncAction =
      AsyncAction('_SimulatorStoreBase.getDefaultValues');

  @override
  Future getDefaultValues({Currency currency}) {
    return _$getDefaultValuesAsyncAction
        .run(() => super.getDefaultValues(currency: currency));
  }

  final _$_SimulatorStoreBaseActionController =
      ActionController(name: '_SimulatorStoreBase');

  @override
  dynamic setBeneficiary(Beneficiary value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction(
        name: '_SimulatorStoreBase.setBeneficiary');
    try {
      return super.setBeneficiary(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuantity(double value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction(
        name: '_SimulatorStoreBase.setQuantity');
    try {
      return super.setQuantity(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotalValue(double value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction(
        name: '_SimulatorStoreBase.setTotalValue');
    try {
      return super.setTotalValue(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setHasError(bool value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction(
        name: '_SimulatorStoreBase.setHasError');
    try {
      return super.setHasError(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFieldErrors(List<ErrorResponseModel> value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction(
        name: '_SimulatorStoreBase.setFieldErrors');
    try {
      return super.setFieldErrors(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
beneficiary: ${beneficiary},
isReverse: ${isReverse},
shouldRefresh: ${shouldRefresh},
quantity: ${quantity},
totalValue: ${totalValue},
hasError: ${hasError},
isLoading: ${isLoading},
fieldErrors: ${fieldErrors},
simulatorResponse: ${simulatorResponse},
simulatorDefaultValuesResponseModel: ${simulatorDefaultValuesResponseModel},
currencies: ${currencies}
    ''';
  }
}
