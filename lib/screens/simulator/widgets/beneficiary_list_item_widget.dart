import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/actions/address_missing_fields_action.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/user_avatar_widget.dart';

class BeneficiaryListItemWidget extends StatelessWidget {
  final Beneficiary beneficiary;

  const BeneficiaryListItemWidget({
    Key key,
    @required this.beneficiary,
    this.onTap,
  })  : assert(beneficiary != null),
        super(key: key);

  final Function onTap;

  get isDisabled => beneficiary?.isDisabled != null && beneficiary.isDisabled;

  @override
  Widget build(BuildContext context) {
    final limitTextWidth = MediaQuery.of(context).size.width * .6;

    Color beneficiaryNameColor = StyleColors.SUPPORT_NEUTRAL_10;
    Color beneficiaryBankColor = StyleColors.SUPPORT_NEUTRAL_10;

    if (isDisabled) {
      beneficiaryNameColor = beneficiaryNameColor.withOpacity(.6);
      beneficiaryBankColor = beneficiaryBankColor.withOpacity(.6);
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
      behavior: HitTestBehavior.opaque,
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

        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: StyleColors.SUPPORT_NEUTRAL_10.withOpacity(.2),
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 25),
        child: IntrinsicHeight(
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
                    backgroundColor: StyleColors.BRAND_PRIMARY_50,
                    lettersColor: StyleColors.BRAND_PRIMARY_20,
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
                      child: currencyCountryFlag != null
                          ? ClipOval(
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 14,
                                    height: 14,
                                    child: currencyCountryFlag,
                                  ),
                                  isDisabled
                                      ? Container(
                                          width: 14,
                                          height: 14,
                                          color: StyleColors.BRAND_PRIMARY_60
                                              .withOpacity(.5),
                                        )
                                      : Container(),
                                ],
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
              (beneficiary?.hasAddressMissingFields ?? false)
                  ? _buildAddressMissingFieldsAlert(context)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildAddressMissingFieldsAlert(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          bottom: 8,
          top: 8,
          left: 8,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            final i18n = GetIt.I<I18n>();

            final addBeneficiaryAction =
                AddressMissingFieldsAction(beneficiary);

            return ModalHelper.showInfoBottomSheet(
                context,
                i18n.trans('info', ['addressMissingFields', 'title']),
                i18n.trans('info', ['addressMissingFields', 'description']),
                Icon(
                  Icons.info,
                  size: 20,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: addBeneficiaryAction.action,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Text(
                      addBeneficiaryAction.name,
                      style: TextStyle(
                        color: StyleColors.SUPPORT_NEUTRAL_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: StyleColors.SUPPORT_WARNING_10,
            ),
            child: Icon(
              RemessaIcons.attention,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
