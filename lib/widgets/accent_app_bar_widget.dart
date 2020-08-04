import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class AccentAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const AccentAppBarWidget({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      iconTheme: IconThemeData(
        color: StyleColors.SUPPORT_NEUTRAL_10,
      ),
      elevation: 0,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          color: StyleColors.SUPPORT_NEUTRAL_10,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
