import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/progress_app_bar/progress_app_bar_line_widget.dart';

class AccentAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function prevAction;
  final String title;
  final int steps;
  final int currentStep;

  bool get isProgressive => steps != null && currentStep != null;

  const AccentAppBarWidget({
    Key key,
    @required this.title,
    this.prevAction,
    this.steps,
    this.currentStep,
  })  : assert(title != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(
        color: StyleColors.SUPPORT_NEUTRAL_10,
      ),
      elevation: 0,
      automaticallyImplyLeading: false,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (prevAction != null) prevAction();
                Navigator.pop(context);
              },
            )
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: StyleColors.SUPPORT_NEUTRAL_10,
        ),
      ),
      bottom: isProgressive
          ? ProgressAppBarLineWidget(
              steps: steps,
              currentStep: currentStep,
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
