import 'package:flutter/material.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/cached_network_image_widget.dart';
import 'package:remessa_app/v2/core/widgets/link_widget.dart';

class InfoStepperContentWidget extends StatelessWidget {
  final InfoStepperHeader header;
  final String title;
  final String content;
  final String imageURL;

  const InfoStepperContentWidget({
    Key key,
    this.header,
    @required this.title,
    @required this.content,
    this.imageURL,
  })  : assert(title != null && content != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildHeader(context),
          imageURL != null ? Expanded(child: _buildContent()) : _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (header != null) {
      final titleWidget = Text(
        header.title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: StyleColors.BRAND_PRIMARY_80,
          fontSize: 16,
        ),
      );

      if (header.link != null) {
        final link = header?.link;
        final linkAction = link?.linkAction;

        return Column(
          children: [
            titleWidget,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(link.prefix),
                SizedBox(
                  width: 4,
                ),
                LinkWidget(
                  label: linkAction.name,
                  onTap: () => linkAction.action(context),
                ),
              ],
            ),
          ],
        );
      }

      return titleWidget;
    }

    return Container();
  }

  Widget _buildContent() {
    Widget imageWidget = Container();

    if (imageURL != null) {
      imageWidget = ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 5,
          maxHeight: 85,
          minWidth: 5,
        ),
        child: CachedNetworkImageWigdet(
          imageURL: imageURL,
          loaderColor: StyleColors.BRAND_PRIMARY_40,
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          imageWidget,
          SizedBox(
            height: 24,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: StyleColors.BRAND_PRIMARY_80,
              fontSize: 24,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: StyleColors.BRAND_SECONDARY_50,
            ),
          ),
        ],
      ),
    );
  }
}
