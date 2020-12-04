import 'package:flutter/material.dart';
import 'package:remessa_app/actions/action.dart' as ac;
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:remessa_app/widgets/link_widget.dart';

class InfoStepperActionsWidget extends StatelessWidget {
  final ac.Action action;
  final ac.Action linkAction;

  const InfoStepperActionsWidget({
    Key key,
    @required this.action,
    this.linkAction,
  })  : assert(action != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GradientButtonWidget(
            onPressed: action.action,
            label: action.name,
          ),
          (linkAction != null)
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    LinkWidget(
                      padding: const EdgeInsets.only(top: 4),
                      label: linkAction.name,
                      action: linkAction.action,
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}