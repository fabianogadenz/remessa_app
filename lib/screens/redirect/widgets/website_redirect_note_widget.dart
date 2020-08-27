import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';

class WebsiteRedirectNoteWidget extends StatelessWidget {
  const WebsiteRedirectNoteWidget({
    Key key,
    @required this.note,
  }) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: StyleColors.SUPPORT_WARNING_10.withOpacity(.4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                RemessaIcons.timer,
                color: StyleColors.SUPPORT_WARNING_60,
              ),
              SizedBox(
                width: 16,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      note?.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: StyleColors.SUPPORT_WARNING_60,
                      ),
                    ),
                    Text(
                      note?.description,
                      style: TextStyle(
                        color: StyleColors.SUPPORT_WARNING_60,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 70,
        ),
      ],
    );
  }
}
