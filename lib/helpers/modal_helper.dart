import 'package:flutter/material.dart';
import 'package:remessa_app/screens/recurrence/beneficiary_screen.dart';
import 'package:remessa_app/widgets/info_widget.dart';

class ModalHelper {
  static void showInfoBottomSheet(
          BuildContext context, String title, String description,
          [Icon icon]) =>
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => InfoWidget(
          title: title,
          description: description,
          icon: icon,
        ),
      );

  static void showNewTransactionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => BeneficiaryScreen(),
    );
  }
}
