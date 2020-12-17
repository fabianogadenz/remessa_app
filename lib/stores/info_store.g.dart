// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$InfoStore on _InfoStoreBase, Store {
  Computed<dynamic> _$hasInfoToShowComputed;

  @override
  dynamic get hasInfoToShow =>
      (_$hasInfoToShowComputed ??= Computed<dynamic>(() => super.hasInfoToShow,
              name: '_InfoStoreBase.hasInfoToShow'))
          .value;

  final _$isLoadingAtom = Atom(name: '_InfoStoreBase.isLoading');

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

  final _$shownAtom = Atom(name: '_InfoStoreBase.shown');

  @override
  bool get shown {
    _$shownAtom.reportRead();
    return super.shown;
  }

  @override
  set shown(bool value) {
    _$shownAtom.reportWrite(value, super.shown, () {
      super.shown = value;
    });
  }

  final _$infoResponseModelAtom =
      Atom(name: '_InfoStoreBase.infoResponseModel');

  @override
  InfoResponseModel get infoResponseModel {
    _$infoResponseModelAtom.reportRead();
    return super.infoResponseModel;
  }

  @override
  set infoResponseModel(InfoResponseModel value) {
    _$infoResponseModelAtom.reportWrite(value, super.infoResponseModel, () {
      super.infoResponseModel = value;
    });
  }

  final _$infoAtom = Atom(name: '_InfoStoreBase.info');

  @override
  InfoStepperModel get info {
    _$infoAtom.reportRead();
    return super.info;
  }

  @override
  set info(InfoStepperModel value) {
    _$infoAtom.reportWrite(value, super.info, () {
      super.info = value;
    });
  }

  final _$checkAsyncAction = AsyncAction('_InfoStoreBase.check');

  @override
  Future check() {
    return _$checkAsyncAction.run(() => super.check());
  }

  final _$getInfoAsyncAction = AsyncAction('_InfoStoreBase.getInfo');

  @override
  Future getInfo(String url) {
    return _$getInfoAsyncAction.run(() => super.getInfo(url));
  }

  final _$_InfoStoreBaseActionController =
      ActionController(name: '_InfoStoreBase');

  @override
  dynamic setIsLoading(bool value) {
    final _$actionInfo = _$_InfoStoreBaseActionController.startAction(
        name: '_InfoStoreBase.setIsLoading');
    try {
      return super.setIsLoading(value);
    } finally {
      _$_InfoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setShown(bool value) {
    final _$actionInfo = _$_InfoStoreBaseActionController.startAction(
        name: '_InfoStoreBase.setShown');
    try {
      return super.setShown(value);
    } finally {
      _$_InfoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
shown: ${shown},
infoResponseModel: ${infoResponseModel},
info: ${info},
hasInfoToShow: ${hasInfoToShow}
    ''';
  }
}
