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
  })  : assert(title != null),
        assert(detailItems != null),
        super(key: key);

  final String title;
  final SectionLink sectionLink;
  final List<Widget> detailItems;
  final bool showDivisor;

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
      padding: EdgeInsets.all(24),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DetailSectionTitleWidget(title),
          ...detailItems,
          sectionLink != null
              ? DetailSectionLink(
                  sectionLink.label,
                  action: sectionLink.action,
                )
              : Container(),
        ],
      ),
    );
  }
}
