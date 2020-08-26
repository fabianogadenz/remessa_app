// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'beneficiary_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BeneficiaryStore on _BeneficiaryStoreBase, Store {
  final _$hasErrorAtom = Atom(name: '_BeneficiaryStoreBase.hasError');

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

  final _$isLoadingAtom = Atom(name: '_BeneficiaryStoreBase.isLoading');

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

  final _$beneficiaryResponseModelAtom =
      Atom(name: '_BeneficiaryStoreBase.beneficiaryResponseModel');

  @override
  BeneficiaryResponseModel get beneficiaryResponseModel {
    _$beneficiaryResponseModelAtom.reportRead();
    return super.beneficiaryResponseModel;
  }

  @override
  set beneficiaryResponseModel(BeneficiaryResponseModel value) {
    _$beneficiaryResponseModelAtom
        .reportWrite(value, super.beneficiaryResponseModel, () {
      super.beneficiaryResponseModel = value;
    });
  }

  final _$getBeneficiariesAsyncAction =
      AsyncAction('_BeneficiaryStoreBase.getBeneficiaries');

  @override
  Future getBeneficiaries() {
    return _$getBeneficiariesAsyncAction.run(() => super.getBeneficiaries());
  }

  @override
  String toString() {
    return '''
hasError: ${hasError},
isLoading: ${isLoading},
beneficiaryResponseModel: ${beneficiaryResponseModel}
    ''';
  }
}
