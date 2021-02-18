import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/cached_network_image_widget.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/widgets/outline_button_widget.dart';

class WarningModalWidget extends StatelessWidget {
  final String title;
  final String content;
  final String imageURL;
  final bool hasCloseButton;
  final ac.Action primaryAction;
  final ac.Action secondaryAction;

  const WarningModalWidget({
    Key key,
    @required this.title,
    @required this.content,
    @required this.imageURL,
    this.hasCloseButton = true,
    this.primaryAction,
    this.secondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 52,
              width: double.infinity,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: hasCloseButton
                  ? GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: Icon(
                        RemessaIcons.close,
                        color: StyleColors.BRAND_PRIMARY_40,
                        size: 18,
                      ),
                    )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CachedNetworkImageWigdet(imageURL: imageURL),
                  SizedBox(height: 32),
                  Text(
                    title,
                    style: TextStyle(
                      color: StyleColors.BRAND_SECONDARY_50,
                      fontSize: 24,
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    content,
                    style: TextStyle(color: StyleColors.BRAND_SECONDARY_50),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  primaryAction != null
                      ? GradientButtonWidget(
                          label: primaryAction.name,
                          onPressed: primaryAction.action,
                        )
                      : Container(),
                  SizedBox(height: 16),
                  secondaryAction != null
                      ? OutlineButtonWidget(
                          label: secondaryAction.name,
                          onPressed: secondaryAction.action,
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}