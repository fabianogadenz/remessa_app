import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:remessa_app/style/colors.dart';

class CachedNetworkImageWigdet extends StatelessWidget {
  final String imageURL;
  final Color loaderColor;

  const CachedNetworkImageWigdet({
    Key key,
    @required this.imageURL,
    this.loaderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageURL,
      progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
          value: downloadProgress.progress,
          valueColor: AlwaysStoppedAnimation<Color>(loaderColor),
        ),
      ),
      errorWidget: (context, url, error) => Center(
        child: Icon(
          Icons.error,
          size: 14,
          color: StyleColors.SUPPORT_DANGER_40,
        ),
      ),
      fit: BoxFit.fill,
    );
  }
}
