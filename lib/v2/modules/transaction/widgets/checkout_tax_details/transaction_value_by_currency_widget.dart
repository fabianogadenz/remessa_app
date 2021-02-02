import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionValueByCurrencyWidget extends StatelessWidget {
  const TransactionValueByCurrencyWidget({
    Key key,
    @required this.imageUrl,
    @required this.label,
    @required this.value,
  })  : assert(imageUrl != null),
        assert(label != null),
        assert(value != null),
        super(key: key);

  final String imageUrl;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Container(
            width: 34,
            height: 34,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
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
            ),
          ),
        ),
        SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: StyleColors.SUPPORT_NEUTRAL_10,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: StyleColors.SUPPORT_NEUTRAL_10,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
