import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class DividerWithTextWidget extends StatelessWidget {
  const DividerWithTextWidget(
    this.label, {
    Key key,
  }) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Divider(
            color: StyleColors.SUPPORT_NEUTRAL_40,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            label,
            style: TextStyle(
              color: StyleColors.SUPPORT_NEUTRAL_40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Flexible(
          child: Divider(
            color: StyleColors.SUPPORT_NEUTRAL_40,
          ),
        ),
      ],
    );
  }
}
