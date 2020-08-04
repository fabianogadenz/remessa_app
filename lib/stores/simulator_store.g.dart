// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulatorStore on _SimulatorStoreBase, Store {
  Computed<Currencies> _$currenciesComputed;

  @override
  Currencies get currencies =>
      (_$currenciesComputed ??= Computed<Currencies>(() => super.currencies))
          .value;

  final _$beneficiaryAtom = Atom(name: '_SimulatorStoreBase.beneficiary');

  @override
  Beneficiary get beneficiary {
    _$beneficiaryAtom.context.enforceReadPolicy(_$beneficiaryAtom);
    _$beneficiaryAtom.reportObserved();
    return super.beneficiary;
  }

  @override
  set beneficiary(Beneficiary value) {
    _$beneficiaryAtom.context.conditionallyRunInAction(() {
      super.beneficiary = value;
      _$beneficiaryAtom.reportChanged();
    }, _$beneficiaryAtom, name: '${_$beneficiaryAtom.name}_set');
  }

  final _$isReverseAtom = Atom(name: '_SimulatorStoreBase.isReverse');

  @override
  bool get isReverse {
    _$isReverseAtom.context.enforceReadPolicy(_$isReverseAtom);
    _$isReverseAtom.reportObserved();
    return super.isReverse;
  }

  @override
  set isReverse(bool value) {
    _$isReverseAtom.context.conditionallyRunInAction(() {
      super.isReverse = value;
      _$isReverseAtom.reportChanged();
    }, _$isReverseAtom, name: '${_$isReverseAtom.name}_set');
  }

  final _$shouldRefreshAtom = Atom(name: '_SimulatorStoreBase.shouldRefresh');

  @override
  bool get shouldRefresh {
    _$shouldRefreshAtom.context.enforceReadPolicy(_$shouldRefreshAtom);
    _$shouldRefreshAtom.reportObserved();
    return super.shouldRefresh;
  }

  @override
  set shouldRefresh(bool value) {
    _$shouldRefreshAtom.context.conditionallyRunInAction(() {
      super.shouldRefresh = value;
      _$shouldRefreshAtom.reportChanged();
    }, _$shouldRefreshAtom, name: '${_$shouldRefreshAtom.name}_set');
  }

  final _$quantityAtom = Atom(name: '_SimulatorStoreBase.quantity');

  @override
  double get quantity {
    _$quantityAtom.context.enforceReadPolicy(_$quantityAtom);
    _$quantityAtom.reportObserved();
    return super.quantity;
  }

  @override
  set quantity(double value) {
    _$quantityAtom.context.conditionallyRunInAction(() {
      super.quantity = value;
      _$quantityAtom.reportChanged();
    }, _$quantityAtom, name: '${_$quantityAtom.name}_set');
  }

  final _$totalValueAtom = Atom(name: '_SimulatorStoreBase.totalValue');

  @override
  double get totalValue {
    _$totalValueAtom.context.enforceReadPolicy(_$totalValueAtom);
    _$totalValueAtom.reportObserved();
    return super.totalValue;
  }

  @override
  set totalValue(double value) {
    _$totalValueAtom.context.conditionallyRunInAction(() {
      super.totalValue = value;
      _$totalValueAtom.reportChanged();
    }, _$totalValueAtom, name: '${_$totalValueAtom.name}_set');
  }

  final _$hasErrorAtom = Atom(name: '_SimulatorStoreBase.hasError');

  @override
  bool get hasError {
    _$hasErrorAtom.context.enforceReadPolicy(_$hasErrorAtom);
    _$hasErrorAtom.reportObserved();
    return super.hasError;
  }

  @override
  set hasError(bool value) {
    _$hasErrorAtom.context.conditionallyRunInAction(() {
      super.hasError = value;
      _$hasErrorAtom.reportChanged();
    }, _$hasErrorAtom, name: '${_$hasErrorAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_SimulatorStoreBase.isLoading');

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

  final _$fieldErrorsAtom = Atom(name: '_SimulatorStoreBase.fieldErrors');

  @override
  List<ErrorResponseModel> get fieldErrors {
    _$fieldErrorsAtom.context.enforceReadPolicy(_$fieldErrorsAtom);
    _$fieldErrorsAtom.reportObserved();
    return super.fieldErrors;
  }

  @override
  set fieldErrors(List<ErrorResponseModel> value) {
    _$fieldErrorsAtom.context.conditionallyRunInAction(() {
      super.fieldErrors = value;
      _$fieldErrorsAtom.reportChanged();
    }, _$fieldErrorsAtom, name: '${_$fieldErrorsAtom.name}_set');
  }

  final _$simulatorResponseAtom =
      Atom(name: '_SimulatorStoreBase.simulatorResponse');

  @override
  SimulatorResponseModel get simulatorResponse {
    _$simulatorResponseAtom.context.enforceReadPolicy(_$simulatorResponseAtom);
    _$simulatorResponseAtom.reportObserved();
    return super.simulatorResponse;
  }

  @override
  set simulatorResponse(SimulatorResponseModel value) {
    _$simulatorResponseAtom.context.conditionallyRunInAction(() {
      super.simulatorResponse = value;
      _$simulatorResponseAtom.reportChanged();
    }, _$simulatorResponseAtom, name: '${_$simulatorResponseAtom.name}_set');
  }

  final _$simulatorDefaultValuesResponseModelAtom =
      Atom(name: '_SimulatorStoreBase.simulatorDefaultValuesResponseModel');

  @override
  SimulatorDefaultValuesResponseModel get simulatorDefaultValuesResponseModel {
    _$simulatorDefaultValuesResponseModelAtom.context
        .enforceReadPolicy(_$simulatorDefaultValuesResponseModelAtom);
    _$simulatorDefaultValuesResponseModelAtom.reportObserved();
    return super.simulatorDefaultValuesResponseModel;
  }

  @override
  set simulatorDefaultValuesResponseModel(
      SimulatorDefaultValuesResponseModel value) {
    _$simulatorDefaultValuesResponseModelAtom.context.conditionallyRunInAction(
        () {
      super.simulatorDefaultValuesResponseModel = value;
      _$simulatorDefaultValuesResponseModelAtom.reportChanged();
    }, _$simulatorDefaultValuesResponseModelAtom,
        name: '${_$simulatorDefaultValuesResponseModelAtom.name}_set');
  }

  final _$simulateAsyncAction = AsyncAction('simulate');

  @override
  Future simulate() {
    return _$simulateAsyncAction.run(() => super.simulate());
  }

  final _$getDefaultValuesAsyncAction = AsyncAction('getDefaultValues');

  @override
  Future getDefaultValues({Currency currency}) {
    return _$getDefaultValuesAsyncAction
        .run(() => super.getDefaultValues(currency: currency));
  }

  final _$_SimulatorStoreBaseActionController =
      ActionController(name: '_SimulatorStoreBase');

  @override
  dynamic setBeneficiary(Beneficiary value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction();
    try {
      return super.setBeneficiary(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQuantity(double value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction();
    try {
      return super.setQuantity(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTotalValue(double value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction();
    try {
      return super.setTotalValue(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setHasError(bool value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction();
    try {
      return super.setHasError(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFieldErrors(List<ErrorResponseModel> value) {
    final _$actionInfo = _$_SimulatorStoreBaseActionController.startAction();
    try {
      return super.setFieldErrors(value);
    } finally {
      _$_SimulatorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'beneficiary: ${beneficiary.toString()},isReverse: ${isReverse.toString()},shouldRefresh: ${shouldRefresh.toString()},quantity: ${quantity.toString()},totalValue: ${totalValue.toString()},hasError: ${hasError.toString()},isLoading: ${isLoading.toString()},fieldErrors: ${fieldErrors.toString()},simulatorResponse: ${simulatorResponse.toString()},simulatorDefaultValuesResponseModel: ${simulatorDefaultValuesResponseModel.toString()},currencies: ${currencies.toString()}';
    return '{$string}';
  }
}
