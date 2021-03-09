import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class OutlineButtonWidget extends StatelessWidget {
  const OutlineButtonWidget({
    Key key,
    @required this.label,
    this.onPressed,
    this.isAccent = false,
  }) : super(key: key);

  final String label;
  final Function onPressed;
  final bool isAccent;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlineButton(
        padding: EdgeInsets.all(15),
        borderSide: BorderSide(
          color: isAccent
              ? StyleColors.SUPPORT_NEUTRAL_10
              : StyleColors.BRAND_PRIMARY_40,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button.copyWith(
                color: isAccent
                    ? StyleColors.SUPPORT_NEUTRAL_10
                    : StyleColors.BRAND_PRIMARY_40,
              ),
        ),
      ),
    );
  }
}
