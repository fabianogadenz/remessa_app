import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/constants/image_contants.dart';
import 'package:remessa_app/v2/core/widgets/cached_network_image_widget.dart';

class TransactionValueByCurrencyWidget extends StatelessWidget {
  const TransactionValueByCurrencyWidget({
    Key key,
    this.imageUrl,
    @required this.label,
    @required this.value,
  })  : assert(label != null),
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
            child: imageUrl != null
                ? CachedNetworkImageWigdet(imageURL: imageUrl)
                : Image.asset(ImageConstants.BRAZILIAN_FLAG),
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
