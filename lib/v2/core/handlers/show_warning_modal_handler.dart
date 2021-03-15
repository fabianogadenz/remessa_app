import 'package:flutter/material.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/v2/core/widgets/warning_modal/warning_modal_widget.dart';

class ShowWarningModalHandler {
  final String content;
  final String title;
  final String imageURL;
  final bool isDismissible;
  final ac.Action primaryAction;
  final ac.Action secondaryAction;

  ShowWarningModalHandler({
    this.content,
    this.title,
    this.imageURL,
    this.isDismissible,
    this.primaryAction,
    this.secondaryAction,
  });

  call(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      builder: (BuildContext context) => WarningModalWidget(
        title: title,
        content: content,
        imageURL: imageURL,
        hasCloseButton: isDismissible,
        primaryAction: primaryAction,
        secondaryAction: secondaryAction,
      ),
    );
  }
}
