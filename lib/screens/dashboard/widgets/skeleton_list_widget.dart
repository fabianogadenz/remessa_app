import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/skeleton_line_widget.dart';

class SkeletonListWidget extends StatelessWidget {
  const SkeletonListWidget({
    Key key,
  }) : super(key: key);

  _buildSkeleton() => Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(7)),
          color: StyleColors.SKELETON_PRIMARY_BACKGROUND.withOpacity(0.7),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SkeletonLineWidget(
                    margin: EdgeInsets.only(
                      bottom: 5,
                    ),
                    width: 127,
                  ),
                  SkeletonLineWidget(
                    width: 50,
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SkeletonLineWidget(
                    margin: EdgeInsets.only(
                      bottom: 5,
                    ),
                    width: 110,
                  ),
                  SkeletonLineWidget(
                    width: 83,
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, _) => _buildSkeleton(),
        childCount: 5,
      ),
    );
  }
}
