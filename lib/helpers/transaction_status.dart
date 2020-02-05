import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:tuple/tuple.dart';

class TransactionStatus {
  static Tuple2<Color, Color> getColor(int statusId) {
    const warning = Tuple2(StyleColors.SUPPORT_WARNING_40, Colors.black);
    const danger = Tuple2(StyleColors.SUPPORT_DANGER_40, Colors.white);
    const primary = Tuple2(StyleColors.BRAND_PRIMARY_20, Colors.black);
    const success = Tuple2(StyleColors.SUPPORT_SUCCESS_50, Colors.white);

    switch (statusId) {
      case 1:
        return primary;
      case 2:
        return warning;
      case 3:
        return primary;
      case 4:
        return success;
      case 5:
      case 6:
        return warning;
      case 7:
        return success;
      case 8:
        return danger;
      default:
        return Tuple2(Colors.transparent, Colors.black);
    }
  }
}
