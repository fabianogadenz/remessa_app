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
  final bool isDisabled;
  final bool isSuccess;
  final bool isLoading;

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
    this.isDisabled = false,
    this.isSuccess = false,
    this.isLoading = false,
    this.onPressed,
  }) : super(key: key);

  Widget handleChild(BuildContext context) {
    if (isLoading)
      return Center(
        child: SizedBox(
          height: 19,
          width: 19,
          child: CircularProgressIndicator(),
        ),
      );

    TextStyle _style = Theme.of(context).textTheme.button;
    final _successColor = StyleColors.SUPPORT_SUCCESS_50.withOpacity(.8);

    if (isSuccess) _style = _style.copyWith(color: _successColor);

    return child ??
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              isSuccess
                  ? Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: _successColor,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    )
                  : Container(),
              Text(
                label,
                style: _style,
              ),
            ],
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isDisabled || isSuccess ? () {} : onPressed,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: isSuccess
              ? StyleColors.SUPPORT_SUCCESS_10.withOpacity(.4)
              : StyleColors.BRAND_SECONDARY_10,
          gradient: isDisabled || isSuccess ? null : gradient,
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
        child: handleChild(context),
      ),
    );
  }
}
