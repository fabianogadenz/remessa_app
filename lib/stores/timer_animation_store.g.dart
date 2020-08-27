// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerAnimationStore on _TimerAnimationStoreBase, Store {
  final _$tickerAtom = Atom(name: '_TimerAnimationStoreBase.ticker');

  @override
  TickerProvider get ticker {
    _$tickerAtom.reportRead();
    return super.ticker;
  }

  @override
  set ticker(TickerProvider value) {
    _$tickerAtom.reportWrite(value, super.ticker, () {
      super.ticker = value;
    });
  }

  final _$disableCounterAtom =
      Atom(name: '_TimerAnimationStoreBase.disableCounter');

  @override
  bool get disableCounter {
    _$disableCounterAtom.reportRead();
    return super.disableCounter;
  }

  @override
  set disableCounter(bool value) {
    _$disableCounterAtom.reportWrite(value, super.disableCounter, () {
      super.disableCounter = value;
    });
  }

  final _$controllerAtom = Atom(name: '_TimerAnimationStoreBase.controller');

  @override
  AnimationController get controller {
    _$controllerAtom.reportRead();
    return super.controller;
  }

  @override
  set controller(AnimationController value) {
    _$controllerAtom.reportWrite(value, super.controller, () {
      super.controller = value;
    });
  }

  final _$_TimerAnimationStoreBaseActionController =
      ActionController(name: '_TimerAnimationStoreBase');

  @override
  dynamic setTicker(TickerProvider value) {
    final _$actionInfo = _$_TimerAnimationStoreBaseActionController.startAction(
        name: '_TimerAnimationStoreBase.setTicker');
    try {
      return super.setTicker(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDisableCounter(bool value) {
    final _$actionInfo = _$_TimerAnimationStoreBaseActionController.startAction(
        name: '_TimerAnimationStoreBase.setDisableCounter');
    try {
      return super.setDisableCounter(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setController(AnimationController value) {
    final _$actionInfo = _$_TimerAnimationStoreBaseActionController.startAction(
        name: '_TimerAnimationStoreBase.setController');
    try {
      return super.setController(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ticker: ${ticker},
disableCounter: ${disableCounter},
controller: ${controller}
    ''';
  }
}
