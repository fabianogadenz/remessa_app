import 'package:flutter/material.dart';

class IconHighlightWidget extends StatelessWidget {
  const IconHighlightWidget({
    Key key,
    @required this.icon,
    @required this.iconColor,
    @required this.backgroundColor,
  }) : super(key: key);

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      padding: const EdgeInsets.all(10),
      child: Icon(
        icon,
        color: iconColor,
        size: 20,
      ),
    );
  }
}
