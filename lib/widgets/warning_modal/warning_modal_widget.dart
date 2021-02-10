import 'package:flutter/material.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class WarningModalWidget extends StatelessWidget {
  final String title;
  final String content;
  final String imageURL;
  final bool hasCloseButton;
  final ac.Action primaryAction;
  final ac.Action secondaryAction;

  const WarningModalWidget({
    Key key,
    @required this.title,
    @required this.content,
    @required this.imageURL,
    this.hasCloseButton = false,
    this.primaryAction,
    this.secondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(title),
          Text(content),
          // GradientButtonWidget(),
        ],
      ),
    );
  }
}
