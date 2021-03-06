import 'package:flutter/material.dart';
import 'package:remessa_app/v2/core/actions/link_action.dart';
import 'package:remessa_app/style/colors.dart';

class WarningActionWidget extends StatelessWidget {
  const WarningActionWidget({
    Key key,
    @required this.description,
    this.linkAction,
  }) : super(key: key);

  final String description;
  final LinkAction linkAction;

  @override
  Widget build(BuildContext context) {
    final sBox = SizedBox(
      height: 8,
    );

    return Column(
      children: [
        SizedBox(
          height: 32,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: StyleColors.SUPPORT_WARNING_10.withOpacity(.6),
          ),
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: TextStyle(
                  color: StyleColors.SUPPORT_WARNING_60,
                  letterSpacing: .2,
                  height: 1.8,
                ),
              ),
              linkAction != null
                  ? GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => linkAction.action(context),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sBox,
                            Text(
                              linkAction.name,
                              style: TextStyle(
                                color: StyleColors.SUPPORT_WARNING_60,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : sBox,
            ],
          ),
        ),
      ],
    );
  }
}
