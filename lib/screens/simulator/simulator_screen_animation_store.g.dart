// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simulator_screen_animation_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SimulatorScreenAnimationStore
    on _SimulatorScreenAnimationStoreBase, Store {
  final _$controllerAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.controller');

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

  final _$isExpandedAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.isExpanded');

  @override
  bool get isExpanded {
    _$isExpandedAtom.reportRead();
    return super.isExpanded;
  }

  @override
  set isExpanded(bool value) {
    _$isExpandedAtom.reportWrite(value, super.isExpanded, () {
      super.isExpanded = value;
    });
  }

  final _$isScrollDisabledAtom =
      Atom(name: '_SimulatorScreenAnimationStoreBase.isScrollDisabled');

  @override
  bool get isScrollDisabled {
    _$isScrollDisabledAtom.reportRead();
    return super.isScrollDisabled;
  }

  @override
  set isScrollDisabled(bool value) {
    _$isScrollDisabledAtom.reportWrite(value, super.isScrollDisabled, () {
      super.isScrollDisabled = value;
    });
  }

  final _$draggableScrollablePositionAtom = Atom(
      name: '_SimulatorScreenAnimationStoreBase.draggableScrollablePosition');

  @override
  double get draggableScrollablePosition {
    _$draggableScrollablePositionAtom.reportRead();
    return super.draggableScrollablePosition;
  }

  @override
  set draggableScrollablePosition(double value) {
    _$draggableScrollablePositionAtom
        .reportWrite(value, super.draggableScrollablePosition, () {
      super.draggableScrollablePosition = value;
    });
  }

  final _$resetDraggableScrollableFunctionAtom = Atom(
      name:
          '_SimulatorScreenAnimationStoreBase.resetDraggableScrollableFunction');

  @override
  Function get resetDraggableScrollableFunction {
    _$resetDraggableScrollableFunctionAtom.reportRead();
    return super.resetDraggableScrollableFunction;
  }

  @override
  set resetDraggableScrollableFunction(Function value) {
    _$resetDraggableScrollableFunctionAtom
        .reportWrite(value, super.resetDraggableScrollableFunction, () {
      super.resetDraggableScrollableFunction = value;
    });
  }

  final _$_SimulatorScreenAnimationStoreBaseActionController =
      ActionController(name: '_SimulatorScreenAnimationStoreBase');

  @override
  dynamic setController(AnimationController value) {
    final _$actionInfo = _$_SimulatorScreenAnimationStoreBaseActionController
        .startAction(name: '_SimulatorScreenAnimationStoreBase.setController');
    try {
      return super.setController(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsExpanded(bool value) {
    final _$actionInfo = _$_SimulatorScreenAnimationStoreBaseActionController
        .startAction(name: '_SimulatorScreenAnimationStoreBase.setIsExpanded');
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
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction(
            name: '_SimulatorScreenAnimationStoreBase.setIsScrollDisabled');
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
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction(
            name:
                '_SimulatorScreenAnimationStoreBase.setDraggableScrollablePosition');
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
        _$_SimulatorScreenAnimationStoreBaseActionController.startAction(
            name:
                '_SimulatorScreenAnimationStoreBase.setResetDraggableScrollableFunction');
    try {
      return super.setResetDraggableScrollableFunction(value);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  dynamic handleExpanded({bool disableScroll = false}) {
    final _$actionInfo = _$_SimulatorScreenAnimationStoreBaseActionController
        .startAction(name: '_SimulatorScreenAnimationStoreBase.handleExpanded');
    try {
      return super.handleExpanded(disableScroll: disableScroll);
    } finally {
      _$_SimulatorScreenAnimationStoreBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
controller: ${controller},
isExpanded: ${isExpanded},
isScrollDisabled: ${isScrollDisabled},
draggableScrollablePosition: ${draggableScrollablePosition},
resetDraggableScrollableFunction: ${resetDraggableScrollableFunction}
    ''';
  }
}
