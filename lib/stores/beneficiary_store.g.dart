// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BeneficiaryStore on _BeneficiaryStoreBase, Store {
  final _$isLoadingAtom = Atom(name: '_BeneficiaryStoreBase.isLoading');

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

  final _$beneficiaryResponseModelAtom =
      Atom(name: '_BeneficiaryStoreBase.beneficiaryResponseModel');

  @override
  BeneficiaryResponseModel get beneficiaryResponseModel {
    _$beneficiaryResponseModelAtom.context
        .enforceReadPolicy(_$beneficiaryResponseModelAtom);
    _$beneficiaryResponseModelAtom.reportObserved();
    return super.beneficiaryResponseModel;
  }

  @override
  set beneficiaryResponseModel(BeneficiaryResponseModel value) {
    _$beneficiaryResponseModelAtom.context.conditionallyRunInAction(() {
      super.beneficiaryResponseModel = value;
      _$beneficiaryResponseModelAtom.reportChanged();
    }, _$beneficiaryResponseModelAtom,
        name: '${_$beneficiaryResponseModelAtom.name}_set');
  }

  final _$getBeneficiariesAsyncAction = AsyncAction('getBeneficiaries');

  @override
  Future getBeneficiaries() {
    return _$getBeneficiariesAsyncAction.run(() => super.getBeneficiaries());
  }

  @override
  String toString() {
    final string =
        'isLoading: ${isLoading.toString()},beneficiaryResponseModel: ${beneficiaryResponseModel.toString()}';
    return '{$string}';
  }
}
