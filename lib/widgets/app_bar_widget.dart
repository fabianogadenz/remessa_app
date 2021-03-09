import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function prevAction;
  final double elevation;
  final String text;

  const AppBarWidget({
    Key key,
    this.prevAction,
    this.elevation,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      elevation: elevation,
      automaticallyImplyLeading: false,
      leading: Navigator.canPop(context)
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                if (prevAction != null) prevAction();
                GetIt.I<NavigatorHelper>().pop();
              },
            )
          : null,
      title: Text(text),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
