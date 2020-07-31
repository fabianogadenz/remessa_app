import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';

class SimulatorHeaderWidget extends StatelessWidget {
  SimulatorHeaderWidget({
    Key key,
  }) : super(key: key);

  final _appStore = GetIt.I<AppStore>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Simulador',
              style: TextStyle(
                color: StyleColors.SUPPORT_NEUTRAL_10,
                fontWeight: FontWeight.w200,
                fontSize: 30,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            _appStore.configs.isBetaSimulator
                ? Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      'BETA',
                      style: TextStyle(
                        letterSpacing: 4,
                        fontSize: 12,
                        color: StyleColors.BRAND_PRIMARY_20,
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        GestureDetector(
          onTap: GetIt.I<NavigatorHelper>().pop,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, bottom: 10),
            child: Icon(
              RemessaIcons.close,
              color: StyleColors.BRAND_PRIMARY_20,
              size: 15,
            ),
          ),
        ),
      ],
    );
  }
}
