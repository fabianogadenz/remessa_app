import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/text_helper.dart';

class StringHelper {
  static String limiter(String str, int limit) =>
      str.substring(0, limit).trim();

  static String handleLimiterWithEllipsis(String str, int limit) =>
      str.length > limit ? '${limiter(str, limit - 3)}...' : str;

  static String handleLimiterWithEllipsisFromTextWidthAndStyle(
      String str, double limitWidth, TextStyle textStyle) {
    final charWidth = TextHelper.mediumCharsWidth(str, textStyle);

    final maxStringLength = TextHelper.maxStringLength(charWidth, limitWidth);

    return handleLimiterWithEllipsis(str, maxStringLength);
  }
}
