import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/core/widgets/icon_highlight_widget.dart';

class RuleSectionWidget extends StatelessWidget {
  final IconData icon;
  final String value;
  final bool hasDivider;
  final bool isWarning;
  final bool isDarkMode;

  const RuleSectionWidget({
    Key key,
    @required this.icon,
    @required this.value,
    this.hasDivider = true,
    this.isWarning = false,
    this.isDarkMode = false,
  })  : assert(icon != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        border: hasDivider
            ? Border(
                bottom: BorderSide(
                  color: isDarkMode
                      ? StyleColors.BRAND_PRIMARY_50
                      : StyleColors.SUPPORT_NEUTRAL_30,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: IconHighlightWidget(
              icon: icon,
              backgroundColor: isWarning
                  ? isDarkMode
                      ? StyleColors.SUPPORT_WARNING_30
                      : StyleColors.SUPPORT_WARNING_40.withOpacity(.1)
                  : isDarkMode
                      ? StyleColors.BRAND_PRIMARY_50
                      : StyleColors.BRAND_PRIMARY_40.withOpacity(.1),
              iconColor: isDarkMode
                  ? StyleColors.SUPPORT_NEUTRAL_10
                  : isWarning
                      ? StyleColors.SUPPORT_WARNING_40
                      : StyleColors.BRAND_PRIMARY_40,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Html(
              data: value,
              onLinkTap: (url) {
                // TODO: Replace specific tracking with a generic one
                TrackingEvents.log(TrackingEvents.CHECKOUT_PROVE_ACCOUNT_CLICK);
                AppRouter.websiteRedirect(url);
              },
              style: {
                'div': Style(
                  lineHeight: 1.8,
                  color: isDarkMode
                      ? StyleColors.SUPPORT_NEUTRAL_10
                      : StyleColors.BRAND_SECONDARY_50,
                ),
                'a': Style(
                  lineHeight: 1.8,
                  color: isDarkMode
                      ? StyleColors.SUPPORT_NEUTRAL_10
                      : StyleColors.BRAND_PRIMARY_40,
                  fontWeight: FontWeight.w600,
                  textDecoration: TextDecoration.none,
                ),
              },
            ),
          ),
        ],
      ),
    );
  }
}
