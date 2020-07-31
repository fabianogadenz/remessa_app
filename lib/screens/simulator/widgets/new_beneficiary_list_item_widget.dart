import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';

class NewBeneficiaryListItemWidget extends StatelessWidget {
  const NewBeneficiaryListItemWidget({
    Key key,
    @required this.newBeneficiaryUrl,
  })  : assert(newBeneficiaryUrl != null),
        super(key: key);

  final String newBeneficiaryUrl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => GetIt.I<NavigatorHelper>().pushNamed(
        Router.WEBSITE_REDIRECT_ROUTE,
        arguments: WebsiteRedirectScreenArgs(
          url: newBeneficiaryUrl,
        ),
      ),
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
                  'Novo beneficiário',
                  style: TextStyle(
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Comece um novo envio',
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
}
