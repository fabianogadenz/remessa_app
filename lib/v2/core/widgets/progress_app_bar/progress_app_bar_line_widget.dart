import 'package:flutter/material.dart';

import 'package:remessa_app/style/colors.dart';

class ProgressAppBarLineWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final int steps;
  final int currentStep;

  const ProgressAppBarLineWidget({
    Key key,
    @required this.steps,
    @required this.currentStep,
  })  : assert(steps != null && currentStep != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final progressStepWidth = MediaQuery.of(context).size.width / steps;

    return Container(
      alignment: Alignment.centerLeft,
      height: 4,
      color: StyleColors.BRAND_PRIMARY_50,
      child: Container(
        color: StyleColors.BRAND_PRIMARY_30,
        width: progressStepWidth * currentStep,
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 4);
}
