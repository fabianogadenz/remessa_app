import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/skeleton_line_widget.dart';

class CurrencyImageWidget extends StatelessWidget {
  const CurrencyImageWidget({
    Key key,
    this.imageUrl,
    this.isLoading = false,
  }) : super(key: key);

  final String imageUrl;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? SkeletonLineWidget(
            color: StyleColors.BRAND_SECONDARY_10,
            width: 22,
            height: 22,
          )
        : ClipOval(
            child: Container(
              width: 22,
              height: 22,
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imageUrl,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                        value: downloadProgress.progress,
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: Icon(
                          Icons.error,
                          size: 14,
                          color: StyleColors.SUPPORT_DANGER_40,
                        ),
                      ),
                      fit: BoxFit.fill,
                    )
                  : Image.asset('images/flag_brazil.png'),
            ),
          );
  }
}
