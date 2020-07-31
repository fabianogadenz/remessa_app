import 'package:flutter/animation.dart';
import 'package:flutter/scheduler.dart';
import 'package:mobx/mobx.dart';

part 'timer_animation_store.g.dart';

class TimerAnimationStore = _TimerAnimationStoreBase with _$TimerAnimationStore;

abstract class _TimerAnimationStoreBase with Store {
  @observable
  TickerProvider ticker;

  @action
  setTicker(TickerProvider value) => ticker = value;

  @observable
  bool disableCounter = false;

  @action
  setDisableCounter(bool value) => disableCounter = value;

  @observable
  AnimationController controller;

  @action
  setController(AnimationController value) => controller = value;

  void dispose() => controller != null ? controller.dispose() : null;
}
