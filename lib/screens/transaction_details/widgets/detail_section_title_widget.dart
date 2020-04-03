import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class DetailSectionTitleWidget extends StatelessWidget {
  const DetailSectionTitleWidget(
    this.label, {
    Key key,
  })  : assert(label != null),
        super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 14,
        color: StyleColors.BRAND_SECONDARY_80,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
