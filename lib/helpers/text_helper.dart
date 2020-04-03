import 'package:flutter/material.dart';

class TextHelper {
  static Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text.toUpperCase(), style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }

  static double mediumCharsWidth(String text, TextStyle style) =>
      textSize(text, style).width / text.length;

  static int maxStringLength(double charWidth, double limitWidth) =>
      (limitWidth ~/ charWidth);
}
