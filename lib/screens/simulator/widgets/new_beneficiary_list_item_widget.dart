import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/snowplow_helper.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/models/utm_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';

class NewBeneficiaryListItemWidget extends StatelessWidget {
  NewBeneficiaryListItemWidget({
    Key key,
    @required this.newBeneficiaryUrl,
  })  : assert(newBeneficiaryUrl != null),
        super(key: key);

  final i18n = GetIt.I<I18n>();
  final String newBeneficiaryUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: StyleColors.SUPPORT_NEUTRAL_10.withOpacity(.2),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 25),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: StyleColors.BRAND_PRIMARY_50,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: 40,
                  height: 40,
                  child: Center(
                    child: Icon(
                      RemessaIcons.add,
                      size: 12,
                      color: StyleColors.BRAND_PRIMARY_20,
                    ),
                  ),
                ),
                Positioned(
                  top: 28,
                  right: -2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: StyleColors.BRAND_PRIMARY_60,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  i18n.trans(
                    'simulator_screen',
                    ['beneficiary_selection', 'new_beneficiary'],
                  ),
                  style: TextStyle(
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  i18n.trans(
                    'simulator_screen',
                    ['beneficiary_selection', 'new_transaction'],
                  ),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StyleColors.BRAND_PRIMARY_20,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onTap() {
    TrackingEvents.log(TrackingEvents.BENEFICIARY_NEW_TRANSACTION_CLICK);

    GetIt.I<SnowplowHelper>().track(
      category: SnowplowHelper.BENEFICIARY_CATEGORY,
      action: SnowplowHelper.CLICK_ACTION,
      label: SnowplowHelper.ADD_NEW_BENEFICIARY,
    );

    AppRouter.websiteRedirect(
      newBeneficiaryUrl,
      utm: UTM(
        campaign: UTM.ADD_NEW_BENEFICIARY_CAMPAIGN,
      ),
    );
  }
}
