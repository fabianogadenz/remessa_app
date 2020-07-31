// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer_animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TimerAnimationStore on _TimerAnimationStoreBase, Store {
  final _$tickerAtom = Atom(name: '_TimerAnimationStoreBase.ticker');

  @override
  TickerProvider get ticker {
    _$tickerAtom.context.enforceReadPolicy(_$tickerAtom);
    _$tickerAtom.reportObserved();
    return super.ticker;
  }

  @override
  set ticker(TickerProvider value) {
    _$tickerAtom.context.conditionallyRunInAction(() {
      super.ticker = value;
      _$tickerAtom.reportChanged();
    }, _$tickerAtom, name: '${_$tickerAtom.name}_set');
  }

  final _$disableCounterAtom =
      Atom(name: '_TimerAnimationStoreBase.disableCounter');

  @override
  bool get disableCounter {
    _$disableCounterAtom.context.enforceReadPolicy(_$disableCounterAtom);
    _$disableCounterAtom.reportObserved();
    return super.disableCounter;
  }

  @override
  set disableCounter(bool value) {
    _$disableCounterAtom.context.conditionallyRunInAction(() {
      super.disableCounter = value;
      _$disableCounterAtom.reportChanged();
    }, _$disableCounterAtom, name: '${_$disableCounterAtom.name}_set');
  }

  final _$controllerAtom = Atom(name: '_TimerAnimationStoreBase.controller');

  @override
  AnimationController get controller {
    _$controllerAtom.context.enforceReadPolicy(_$controllerAtom);
    _$controllerAtom.reportObserved();
    return super.controller;
  }

  @override
  set controller(AnimationController value) {
    _$controllerAtom.context.conditionallyRunInAction(() {
      super.controller = value;
      _$controllerAtom.reportChanged();
    }, _$controllerAtom, name: '${_$controllerAtom.name}_set');
  }

  final _$_TimerAnimationStoreBaseActionController =
      ActionController(name: '_TimerAnimationStoreBase');

  @override
  dynamic setTicker(TickerProvider value) {
    final _$actionInfo =
        _$_TimerAnimationStoreBaseActionController.startAction();
    try {
      return super.setTicker(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDisableCounter(bool value) {
    final _$actionInfo =
        _$_TimerAnimationStoreBaseActionController.startAction();
    try {
      return super.setDisableCounter(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setController(AnimationController value) {
    final _$actionInfo =
        _$_TimerAnimationStoreBaseActionController.startAction();
    try {
      return super.setController(value);
    } finally {
      _$_TimerAnimationStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'ticker: ${ticker.toString()},disableCounter: ${disableCounter.toString()},controller: ${controller.toString()}';
    return '{$string}';
  }
}
