import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class SectionTitleWidget extends StatelessWidget {
  const SectionTitleWidget({
    Key key,
    @required this.text,
  })  : assert(text != null),
        super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 23, bottom: 15),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2.copyWith(
              color: StyleColors.SUPPORT_NEUTRAL_10,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
