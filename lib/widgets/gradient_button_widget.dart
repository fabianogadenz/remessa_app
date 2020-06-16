import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class GradientButtonWidget extends StatelessWidget {
  final String label;
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final bool hasShadow;
  final Function onPressed;

  const GradientButtonWidget({
    Key key,
    this.label,
    this.child,
    this.gradient = const LinearGradient(
      colors: <Color>[
        StyleColors.BRAND_PRIMARY_40,
        StyleColors.BRAND_PRIMARY_60,
      ],
    ),
    this.width = double.infinity,
    this.height,
    this.hasShadow = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(100),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: StyleColors.BRAND_PRIMARY_80.withOpacity(0.3),
                    offset: Offset(0.0, 5),
                    blurRadius: 5,
                  ),
                ]
              : [],
        ),
        child: child ??
            Center(
              child: Text(
                label,
                style: Theme.of(context).textTheme.button,
              ),
            ),
      ),
    );
  }
}
