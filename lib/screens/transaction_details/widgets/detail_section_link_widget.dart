import 'package:flutter/material.dart';
import 'package:remessa_app/v2/core/widgets/link_widget.dart';

class SectionLink {
  final String label;
  final Function action;

  SectionLink(this.label, this.action);
}

class DetailSectionLinkWidget extends StatelessWidget {
  const DetailSectionLinkWidget(
    this.label, {
    Key key,
    this.action,
  }) : super(key: key);

  final String label;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return LinkWidget(
      padding: EdgeInsets.only(top: 16),
      label: label,
      onTap: action,
    );
  }
}
