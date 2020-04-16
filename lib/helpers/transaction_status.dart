import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:tuple/tuple.dart';

enum TransactionStatus {
  OTHER, // 0
  STARTED, // 1
  WAITING_PAYMENT, // 2
  PAYMENT_IDENTIFIED, // 3
  CONFIRMED, // 4
  PENDENCY, // 5
  WAITING_SIGNATURE, // 6
  FINISHED, // 7
  CANCELED, // 8
}

class TransactionStatusHelper {
  static TransactionStatus parse(int statusId) {
    switch (statusId) {
      case 1:
        return TransactionStatus.STARTED;
      case 2:
        return TransactionStatus.WAITING_PAYMENT;
      case 3:
        return TransactionStatus.PAYMENT_IDENTIFIED;
      case 4:
        return TransactionStatus.CONFIRMED;
      case 5:
        return TransactionStatus.PENDENCY;
      case 6:
        return TransactionStatus.WAITING_SIGNATURE;
      case 7:
        return TransactionStatus.FINISHED;
      case 8:
        return TransactionStatus.CANCELED;
      default:
        return TransactionStatus.OTHER;
    }
  }

  static Tuple2<Color, Color> getColor(TransactionStatus status) {
    const warning = Tuple2(StyleColors.SUPPORT_WARNING_40, Colors.black);
    const danger =
        Tuple2(StyleColors.SUPPORT_DANGER_40, StyleColors.SUPPORT_NEUTRAL_10);
    const primary = Tuple2(StyleColors.BRAND_PRIMARY_20, Colors.black);
    const success =
        Tuple2(StyleColors.SUPPORT_SUCCESS_50, StyleColors.SUPPORT_NEUTRAL_10);

    switch (status) {
      case TransactionStatus.STARTED:
        return primary;
      case TransactionStatus.WAITING_PAYMENT:
        return warning;
      case TransactionStatus.PAYMENT_IDENTIFIED:
        return primary;
      case TransactionStatus.CONFIRMED:
        return success;
      case TransactionStatus.PENDENCY:
      case TransactionStatus.WAITING_SIGNATURE:
        return warning;
      case TransactionStatus.FINISHED:
        return success;
      case TransactionStatus.CANCELED:
        return danger;
      default:
        return Tuple2(Colors.transparent, Colors.black);
    }
  }
}
