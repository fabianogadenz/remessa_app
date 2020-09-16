import 'package:flutter/material.dart';
import 'package:remessa_app/actions/action.dart';
import 'package:remessa_app/style/colors.dart';

class WarningActionWidget extends StatelessWidget {
  const WarningActionWidget({
    Key key,
    @required this.description,
    @required this.linkAction,
  }) : super(key: key);

  final String description;
  final LinkAction linkAction;

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
              SizedBox(
                height: 8,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: linkAction.action,
                child: Text(
                  linkAction.name,
                  style: TextStyle(
                    color: StyleColors.SUPPORT_WARNING_60,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
