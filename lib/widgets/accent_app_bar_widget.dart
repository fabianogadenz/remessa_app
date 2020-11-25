import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/style/colors.dart';

class AccentAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function prevAction;
  final String title;

  const AccentAppBarWidget({
    Key key,
    @required this.title,
    this.prevAction,
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
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          if (prevAction != null) prevAction();
          GetIt.I<NavigatorHelper>().pop();
        },
      ),
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
