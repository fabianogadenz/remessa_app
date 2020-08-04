import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/skeleton_line_widget.dart';

class IconLabelTextCTAWidget extends StatelessWidget {
  const IconLabelTextCTAWidget({
    Key key,
    @required this.icon,
    @required this.label,
    @required this.text,
    this.isLoading = false,
    this.onTap,
  })  : assert(icon != null),
        assert(label != null),
        assert(text != null),
        super(key: key);

  final IconData icon;
  final String label;
  final String text;
  final bool isLoading;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: <Widget>[
          isLoading
              ? SkeletonLineWidget(
                  color: StyleColors.BRAND_SECONDARY_10,
                  width: 42,
                  height: 42,
                  borderRadius: BorderRadius.circular(100),
                )
              : Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: StyleColors.BRAND_PRIMARY_40.withOpacity(.1),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Icon(
                    icon,
                    color: StyleColors.BRAND_PRIMARY_40,
                  ),
                ),
          SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: isLoading
                ? <Widget>[
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
                  ]
                : <Widget>[
                    Text(
                      label,
                      style: TextStyle(
                        color: StyleColors.BRAND_SECONDARY_50,
                      ),
                    ),
                    Text(
                      text,
                      style: TextStyle(
                        color: StyleColors.BRAND_PRIMARY_40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
          ),
        ],
      ),
    );
  }
}
