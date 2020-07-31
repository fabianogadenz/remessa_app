import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:mobx/mobx.dart';

part 'simulator_screen_animation_store.g.dart';

class SimulatorScreenAnimationStore = _SimulatorScreenAnimationStoreBase
    with _$SimulatorScreenAnimationStore;

abstract class _SimulatorScreenAnimationStoreBase with Store {
  final Duration duration = const Duration(milliseconds: 300);
  final tween = Tween(
    begin: Offset(0, 0),
    end: Offset(0, .66),
  ).chain(CurveTween(curve: Curves.ease));

  @observable
  AnimationController controller;

  @action
  setController(AnimationController value) => controller = value;

  @observable
  bool isExpanded = false;

  @action
  setIsExpanded(bool value) => isExpanded = value;

  @observable
  bool isScrollDisabled = false;

  @action
  setIsScrollDisabled(bool value) => isScrollDisabled = value;

  @observable
  double draggableScrollablePosition = 1;

  @action
  setDraggableScrollablePosition(double value) =>
      draggableScrollablePosition = value;

  @observable
  Function resetDraggableScrollableFunction = () {};

  @action
  setResetDraggableScrollableFunction(Function value) =>
      resetDraggableScrollableFunction = value;

  @action
  handleExpanded({bool disableScroll = false}) {
    resetDraggableScrollableFunction();
    isExpanded ? controller.reverse() : controller.forward();

    setIsExpanded(!isExpanded);
    setDraggableScrollablePosition(.1);
    setIsScrollDisabled(disableScroll);
  }

  void dispose() => controller.dispose();
}
