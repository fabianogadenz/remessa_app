import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/stores/timer_animation_store.dart';
import 'dart:math' as math;

import 'package:remessa_app/style/colors.dart';

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.color,
  }) : super(repaint: animation);

  final AnimationController animation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    double progress = animation.value * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value || color != old.color;
  }
}

class TimerWidget extends StatelessWidget {
  final timerAnimationStore = GetIt.I<TimerAnimationStore>();
  AnimationController get controller => timerAnimationStore.controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final Duration duration = controller.duration * controller.value;

        final color = timerAnimationStore.disableCounter
            ? StyleColors.BRAND_SECONDARY_30
            : duration.inSeconds >= 50 && duration.inSeconds < 60
                ? StyleColors.BRAND_SECONDARY_60
                : StyleColors.BRAND_SECONDARY_30;

        final timeLeft = 60 - duration.inSeconds;

        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: CustomPaint(
                painter: CustomTimerPainter(
                  animation: controller,
                  color: color,
                ),
              ),
            ),
            Align(
              alignment: FractionalOffset.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    timerAnimationStore.disableCounter
                        ? '0'
                        : '${timeLeft >= 0 ? timeLeft : 0}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
