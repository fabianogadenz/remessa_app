import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class DotIndicatorsWidget extends StatelessWidget {
  const DotIndicatorsWidget({
    Key key,
    @required this.length,
    @required this.currentIndex,
    this.selectedColor = StyleColors.SUPPORT_NEUTRAL_10,
    this.defaultColor,
  })  : assert(length != null && currentIndex != null),
        super(key: key);

  final int length;
  final int currentIndex;
  final Color selectedColor;
  final Color defaultColor;

  @override
  Widget build(BuildContext context) {
    final _defaultColor = defaultColor ?? selectedColor.withOpacity(.2);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        length,
        (int index) => Container(
          decoration: BoxDecoration(
            color: currentIndex == index ? selectedColor : _defaultColor,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 8,
          height: 8,
          margin: EdgeInsets.symmetric(horizontal: 4),
        ),
      ),
    );
  }
}
