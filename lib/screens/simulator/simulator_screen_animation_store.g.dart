// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_screen_animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulatorScreenAnimationStore
    on _SimulatorScreenAnimationStoreBase, Store {
  final _$controllerAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.controller');

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

  final _$isExpandedAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.isExpanded');

  @override
  bool get isExpanded {
    _$isExpandedAtom.context.enforceReadPolicy(_$isExpandedAtom);
    _$isExpandedAtom.reportObserved();
    return super.isExpanded;
  }

  @override
  set isExpanded(bool value) {
    _$isExpandedAtom.context.conditionallyRunInAction(() {
      super.isExpanded = value;
      _$isExpandedAtom.reportChanged();
    }, _$isExpandedAtom, name: '${_$isExpandedAtom.name}_set');
  }

  final _$isScrollDisabledAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.isScrollDisabled');

  @override
  bool get isScrollDisabled {
    _$isScrollDisabledAtom.context.enforceReadPolicy(_$isScrollDisabledAtom);
    _$isScrollDisabledAtom.reportObserved();
    return super.isScrollDisabled;
  }

  @override
  set isScrollDisabled(bool value) {
    _$isScrollDisabledAtom.context.conditionallyRunInAction(() {
      super.isScrollDisabled = value;
      _$isScrollDisabledAtom.reportChanged();
    }, _$isScrollDisabledAtom, name: '${_$isScrollDisabledAtom.name}_set');
  }

  final _$draggableScrollablePositionAtom = Atom(
      name: '_SimulatorScreenAnimationStoreBase.draggableScrollablePosition');

  @override
  double get draggableScrollablePosition {
    _$draggableScrollablePositionAtom.context
        .enforceReadPolicy(_$draggableScrollablePositionAtom);
    _$draggableScrollablePositionAtom.reportObserved();
    return super.draggableScrollablePosition;
  }

  @override
  set draggableScrollablePosition(double value) {
    _$draggableScrollablePositionAtom.context.conditionallyRunInAction(() {
      super.draggableScrollablePosition = value;
      _$draggableScrollablePositionAtom.reportChanged();
    }, _$draggableScrollablePositionAtom,
        name: '${_$draggableScrollablePositionAtom.name}_set');
  }

  final _$resetDraggableScrollableFunctionAtom = Atom(
      name:
          '_SimulatorScreenAnimationStoreBase.resetDraggableScrollableFunction');

  @override
  Function get resetDraggableScrollableFunction {
    _$resetDraggableScrollableFunctionAtom.context
        .enforceReadPolicy(_$resetDraggableScrollableFunctionAtom);
    _$resetDraggableScrollableFunctionAtom.reportObserved();
    return super.resetDraggableScrollableFunction;
  }

  @override
  set resetDraggableScrollableFunction(Function value) {
    _$resetDraggableScrollableFunctionAtom.context.conditionallyRunInAction(() {
      super.resetDraggableScrollableFunction = value;
      _$resetDraggableScrollableFunctionAtom.reportChanged();
    }, _$resetDraggableScrollableFunctionAtom,
        name: '${_$resetDraggableScrollableFunctionAtom.name}_set');
  }

  final _$_SimulatorScreenAnimationStoreBaseActionController =
      ActionController(name: '_SimulatorScreenAnimationStoreBase');

  @override
  dynamic setController(AnimationController value) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.setController(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsExpanded(bool value) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.setIsExpanded(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsScrollDisabled(bool value) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.setIsScrollDisabled(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setDraggableScrollablePosition(double value) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.setDraggableScrollablePosition(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setResetDraggableScrollableFunction(Function value) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.setResetDraggableScrollableFunction(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic handleExpanded({bool disableScroll = false}) {
    final _$actionInfo =
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction();
    try {
      return super.handleExpanded(disableScroll: disableScroll);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'controller: ${controller.toString()},isExpanded: ${isExpanded.toString()},isScrollDisabled: ${isScrollDisabled.toString()},draggableScrollablePosition: ${draggableScrollablePosition.toString()},resetDraggableScrollableFunction: ${resetDraggableScrollableFunction.toString()}';
    return '{$string}';
  }
}
