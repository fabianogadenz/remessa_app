import 'package:flutter/material.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_link_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/detail_section_title_widget.dart';
import 'package:remessa_app/style/colors.dart';

class DetailSectionWidget extends StatelessWidget {
  const DetailSectionWidget({
    Key key,
    this.title,
    this.detailItems,
    this.sectionLink,
    this.showDivisor = true,
    this.hasPadding = true,
  })  : assert(detailItems != null),
        super(key: key);

  final String title;
  final SectionLink sectionLink;
  final List<Widget> detailItems;
  final bool showDivisor;
  final bool hasPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: showDivisor
            ? Border(
                top: BorderSide(
                  color: StyleColors.SUPPORT_NEUTRAL_30,
                ),
              )
            : null,
      ),
      padding: hasPadding ? EdgeInsets.all(24) : EdgeInsets.zero,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          title != null ? DetailSectionTitleWidget(title) : Container(),
          ...detailItems,
          sectionLink != null
              ? DetailSectionLinkWidget(
                  sectionLink.label,
                  action: sectionLink.action,
                )
              : Container(),
        ],
      ),
    );
  }
}
