import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/close_button_widget.dart';

class SimulatorHeaderWidget extends StatelessWidget {
  SimulatorHeaderWidget({
    Key key,
  }) : super(key: key);

  final _appStore = GetIt.I<AppStore>();
  final i18n = GetIt.I<I18n>();

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
              i18n.trans('simulator'),
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
                      i18n.trans('beta'),
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
        CloseButtonWidget(color: StyleColors.BRAND_PRIMARY_20),
      ],
    );
  }
}
