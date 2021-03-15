import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/skeleton_line_widget.dart';

class SkeletonCardWidget extends StatelessWidget {
  const SkeletonCardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 50,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
        color: StyleColors.SKELETON_PRIMARY_BACKGROUND.withOpacity(0.7),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SkeletonLineWidget(
              margin: EdgeInsets.only(
                bottom: 10,
              ),
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
            SkeletonLineWidget(
              margin: EdgeInsets.only(
                bottom: 25,
              ),
              height: 20,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SkeletonLineWidget(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                ),
                SkeletonLineWidget(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
