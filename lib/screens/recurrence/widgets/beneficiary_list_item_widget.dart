import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/user_avatar_widget.dart';

class BeneficiaryListItemWidget extends StatelessWidget {
  final Beneficiary beneficiary;

  BeneficiaryListItemWidget({
    Key key,
    @required this.beneficiary,
  })  : assert(beneficiary != null),
        super(key: key);
  final i18n = GetIt.I<I18n>();

  get isDisabled => beneficiary?.isDisabled != null && beneficiary.isDisabled;

  @override
  Widget build(BuildContext context) {
    final limitTextWidth = MediaQuery.of(context).size.width * 0.5;

    Color beneficiaryNameColor = StyleColors.BRAND_SECONDARY_60;
    Color beneficiaryBankColor = StyleColors.BRAND_SECONDARY_50;
    Color actionButtonColor = StyleColors.BRAND_PRIMARY_40;

    if (isDisabled) {
      beneficiaryNameColor = StyleColors.BRAND_SECONDARY_40;
      beneficiaryBankColor = StyleColors.BRAND_SECONDARY_20;
      actionButtonColor = StyleColors.BRAND_SECONDARY_20;
    }

    final currencyCountryFlag = beneficiary?.country?.flagUrl != null
        ? CachedNetworkImage(
            imageUrl: beneficiary.country.flagUrl,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Center(
              child: Icon(
                Icons.error,
                size: 14,
                color: StyleColors.SUPPORT_DANGER_40,
              ),
            ),
            fit: BoxFit.fill,
          )
        : null;

    final beneficiaryNameTextStyle = TextStyle(
      color: beneficiaryNameColor,
      fontWeight: FontWeight.w600,
    );

    final beneficiaryBankTextStyle = TextStyle(
      color: beneficiaryBankColor,
      fontSize: 12,
    );

    return GestureDetector(
      onTap: () {
        if (isDisabled) {
          TrackEvents.log(
            TrackEvents.BENEFICIARY_DISABLED_CLICK,
            {'beneficiary_status': beneficiary.statusName},
          );
          return ModalHelper.showInfoBottomSheet(
            context,
            beneficiary.info.title,
            beneficiary.info.description,
            Icon(
              Icons.info,
              size: 20,
            ),
          );
        }

        TrackEvents.log(
          TrackEvents.BENEFICIARY_SELECT_CLICK,
          {'beneficiary_currency': beneficiary.currency},
        );
        GetIt.I<NavigatorHelper>().pushNamed(
          Router.WEBSITE_REDIRECT_ROUTE,
          arguments: WebsiteRedirectScreenArgs(
            url: beneficiary.redirectUrl,
            description: i18n.trans(
              'website_redirect_screen',
              ['description', 'recurrence'],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: StyleColors.BRAND_PRIMARY_80.withOpacity(0.1),
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
                UserAvatarWidget(
                  userName: beneficiary.beneficiaryName,
                  isDisabled: beneficiary.isDisabled,
                ),
                Positioned(
                  top: 28,
                  right: -2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: StyleColors.SUPPORT_NEUTRAL_10,
                      ),
                    ),
                    child: currencyCountryFlag != null
                        ? ClipOval(
                            child: Container(
                              width: 14,
                              height: 14,
                              child: isDisabled
                                  ? ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.grey,
                                        BlendMode.saturation,
                                      ),
                                      child: currencyCountryFlag,
                                    )
                                  : currencyCountryFlag,
                            ),
                          )
                        : Container(),
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
                  StringHelper.handleLimiterWithEllipsisFromTextWidthAndStyle(
                    beneficiary.beneficiaryName,
                    limitTextWidth,
                    beneficiaryNameTextStyle,
                  ),
                  style: beneficiaryNameTextStyle,
                ),
                Text(
                  StringHelper.handleLimiterWithEllipsisFromTextWidthAndStyle(
                    beneficiary.bankName,
                    limitTextWidth,
                    beneficiaryBankTextStyle,
                  ),
                  style: beneficiaryBankTextStyle,
                ),
                SizedBox(
                  height: 8,
                ),
                isDisabled
                    ? Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: StyleColors.SUPPORT_WARNING_10,
                        ),
                        child: Text(
                          beneficiary.statusName.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: StyleColors.SUPPORT_WARNING_60,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            Expanded(
              child: Text(
                i18n.populate(
                  i18n.trans('beneficiary_screen', ['send_currency']),
                  {'currency': beneficiary.currency},
                ).trim(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: actionButtonColor,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
