import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLineWidget extends StatelessWidget {
  const SkeletonLineWidget({
    Key key,
    this.margin,
    this.color,
    this.height,
    @required this.width,
  })  : assert(width != null),
        super(key: key);

  final EdgeInsets margin;
  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color ?? StyleColors.SUPPORT_NEUTRAL_20.withOpacity(0.2),
      ),
      child: SkeletonAnimation(
        child: Container(
          height: height ?? 12,
          width: width,
        ),
      ),
    );
  }
}
