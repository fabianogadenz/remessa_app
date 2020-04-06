import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class SectionLink {
  final String label;
  final Function action;

  SectionLink(this.label, this.action);
}

class DetailSectionLink extends StatelessWidget {
  const DetailSectionLink(
    this.label, {
    Key key,
    this.action,
  }) : super(key: key);

  final String label;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: InkWell(
        onTap: () => action(),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: StyleColors.BRAND_PRIMARY_40,
          ),
        ),
      ),
    );
  }
}
