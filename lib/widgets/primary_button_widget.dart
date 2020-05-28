import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class PrimaryButtonWidget extends StatelessWidget {
  const PrimaryButtonWidget(
    this.label, {
    Key key,
    @required this.onPressed,
  }) : super(key: key);

  final Function onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: label.length < 15 ? 60 : 40,
      ),
      color: StyleColors.SUPPORT_NEUTRAL_10,
      onPressed: () => onPressed(),
      child: Text(
        label,
        style: Theme.of(context).textTheme.button.copyWith(
              color: StyleColors.BRAND_PRIMARY_40,
            ),
      ),
    );
  }
}
