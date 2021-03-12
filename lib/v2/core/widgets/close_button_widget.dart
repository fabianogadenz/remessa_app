import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';

class CloseButtonWidget extends StatelessWidget {
  const CloseButtonWidget({
    Key key,
    this.color = StyleColors.BRAND_PRIMARY_40,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: GetIt.I<NavigatorHelper>().pop,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
        child: Icon(
          RemessaIcons.close,
          color: color,
          size: 16,
        ),
      ),
    );
  }
}
