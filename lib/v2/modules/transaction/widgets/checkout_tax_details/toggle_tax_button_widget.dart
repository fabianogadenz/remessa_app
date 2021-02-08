import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class ToggleTaxButtonWidget extends StatelessWidget {
  const ToggleTaxButtonWidget({
    Key key,
    @required this.label,
    @required this.onPressed,
    @required this.icon,
    this.content,
  })  : assert(label != null),
        assert(icon != null),
        super(key: key);

  final String label;
  final String content;
  final IconData icon;
  final Function onPressed;

  _showLabel(bool show) => show
      ? Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: StyleColors.BRAND_PRIMARY_20,
          ),
        )
      : Container();

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (content != null) {
      children.add(
        Text(
          content,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: StyleColors.SUPPORT_NEUTRAL_10,
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: StyleColors.BRAND_PRIMARY_50,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: children
            ..addAll(
              [
                _showLabel(content == null),
                Row(
                  children: [
                    _showLabel(content != null),
                    SizedBox(width: content != null ? 4 : 0),
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      child: Icon(
                        icon,
                        size: 5.8,
                        color: StyleColors.BRAND_PRIMARY_20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}
