import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/icon_highlight_widget.dart';
import 'package:remessa_app/widgets/link_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class PromotionalCardWidget extends StatelessWidget {
  final String title;
  final String content;
  final IconData iconData;
  final ac.Action action;

  const PromotionalCardWidget({
    Key key,
    @required this.title,
    @required this.content,
    @required this.iconData,
    @required this.action,
  })  : assert(title != null),
        assert(content != null),
        assert(iconData != null),
        assert(action != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconHighlightWidget(
            icon: iconData,
            iconColor: StyleColors.SUPPORT_SUCCESS_40,
            backgroundColor: StyleColors.SUPPORT_SUCCESS_40.withOpacity(.1),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: StyleColors.BRAND_SECONDARY_60,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(
                    color: StyleColors.BRAND_SECONDARY_50,
                  ),
                ),
                SizedBox(height: 16),
                LinkWidget(
                  width: double.infinity,
                  label: action.name,
                  onTap: action.action,
                  suffixIcon: Icon(
                    RemessaIcons.arrow_right,
                    color: StyleColors.BRAND_PRIMARY_40,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
