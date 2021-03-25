import 'package:flutter/material.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';

class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int steps;
  final int currentStep;
  final bool isProgressive;

  const CheckoutAppBar({
    Key key,
    @required this.title,
    this.currentStep,
    this.steps = 4,
    this.isProgressive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AccentAppBarWidget(
      title: title,
      steps: steps,
      currentStep: currentStep,
      isProgressive: isProgressive,
      prevAction: isProgressive
          ? () => TrackingEvents.log(TrackingEvents.CHECKOUT_GO_BACK_CLICK)
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
