import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class LinkWidget extends StatelessWidget {
  final String label;
  final Function action;
  final EdgeInsets padding;
  final double height;
  final double width;

  const LinkWidget({
    Key key,
    @required this.label,
    this.action,
    this.padding,
    this.height,
    this.width,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => action(),
      child: Container(
        padding: padding,
        width: width,
        height: height,
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
