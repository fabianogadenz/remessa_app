import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/skeleton_line_widget.dart';

class IconLabelTextCTAWidget extends StatelessWidget {
  const IconLabelTextCTAWidget({
    Key key,
    @required this.icon,
    @required this.label,
    this.actionText,
    this.isLoading = false,
    this.isSuccess = false,
    this.value,
    this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(actionText != null || value != null),
        super(key: key);

  final IconData icon;
  final String label;
  final String actionText;
  final String value;
  final bool isLoading;
  final bool isSuccess;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    Color iconBGColor = StyleColors.BRAND_PRIMARY_40.withOpacity(.1);
    Color iconColor = StyleColors.BRAND_PRIMARY_40;

    if (!isLoading && isSuccess) {
      iconBGColor = StyleColors.SUPPORT_SUCCESS_10.withOpacity(.4);
      iconColor = StyleColors.SUPPORT_SUCCESS_50;
    }

    Widget iconWidget = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: iconBGColor,
      ),
      padding: EdgeInsets.all(10),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );

    Widget actionTextWidget = actionText != null
        ? Text(
            actionText,
            style: TextStyle(
              color: StyleColors.BRAND_PRIMARY_40,
              fontWeight: FontWeight.w600,
            ),
          )
        : Container();

    List<Widget> textWidgets = <Widget>[
      Text(
        label,
        style: TextStyle(
          color: StyleColors.BRAND_SECONDARY_50,
        ),
      ),
      value != null
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  this.value,
                  style: TextStyle(
                    color: StyleColors.BRAND_SECONDARY_50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                actionTextWidget,
              ],
            )
          : actionTextWidget,
    ];

    if (isLoading) {
      iconWidget = SkeletonLineWidget(
        color: StyleColors.BRAND_SECONDARY_10,
        width: 42,
        height: 42,
        borderRadius: BorderRadius.circular(100),
      );

      textWidgets = <Widget>[
        SkeletonLineWidget(
          color: StyleColors.BRAND_SECONDARY_10,
          width: MediaQuery.of(context).size.width - 122,
          height: 11,
          borderRadius: BorderRadius.circular(100),
        ),
        SizedBox(
          height: 8,
        ),
        SkeletonLineWidget(
          color: StyleColors.BRAND_SECONDARY_10,
          width: 80,
          height: 11,
          borderRadius: BorderRadius.circular(100),
        ),
      ];
    }

    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: <Widget>[
          iconWidget,
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: textWidgets,
          ),
        ],
      ),
    );
  }
}
