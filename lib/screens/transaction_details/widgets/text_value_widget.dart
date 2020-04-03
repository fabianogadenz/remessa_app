import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TextValueWidget extends StatelessWidget {
  const TextValueWidget(
    this.value, {
    Key key,
    this.color = StyleColors.BRAND_SECONDARY_60,
  }) : super(key: key);

  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 14,
        color: color,
      ),
    );
  }
}
