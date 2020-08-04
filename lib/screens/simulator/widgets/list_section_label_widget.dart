import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class ListSectionLabelWidget extends StatelessWidget {
  const ListSectionLabelWidget(
    this.label, {
    Key key,
  })  : assert(label != null),
        super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 8),
      margin: const EdgeInsets.only(bottom: 8, top: 24),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: StyleColors.SUPPORT_NEUTRAL_30,
          ),
        ),
      ),
      child: Text(label),
    );
  }
}
