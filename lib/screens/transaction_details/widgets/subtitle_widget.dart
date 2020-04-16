import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget(
    this.value, {
    Key key,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w300,
        color: StyleColors.BRAND_PRIMARY_80,
      ),
    );
  }
}
