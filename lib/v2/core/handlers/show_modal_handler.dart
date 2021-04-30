import 'package:flutter/material.dart';

class ShowModalHandler {
  final bool isDismissible;
  final Widget modalWidget;

  ShowModalHandler({
    this.isDismissible = true,
    @required this.modalWidget,
  });

  call(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (BuildContext context) => modalWidget,
    );
  }
}
