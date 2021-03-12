import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class LinkWidget extends StatelessWidget {
  final String label;
  final Function onTap;
  final Icon suffixIcon;
  final EdgeInsets padding;
  final double height;
  final double width;

  const LinkWidget({
    Key key,
    @required this.label,
    this.onTap,
    this.padding,
    this.height,
    this.width,
    this.suffixIcon,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTap(),
      child: Container(
        padding: padding,
        width: width,
        height: height,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: StyleColors.BRAND_PRIMARY_40,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            suffixIcon ?? Container(),
          ],
        ),
      ),
    );
  }
}
