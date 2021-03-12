import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/handlers/copy_text_handler.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';

class LabelValueDataSectionWidget extends StatelessWidget {
  final LabelValueModel data;

  const LabelValueDataSectionWidget({
    Key key,
    @required this.data,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: data.hasDivider
            ? Border(
                bottom: BorderSide(
                  color: StyleColors.SUPPORT_NEUTRAL_30,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text(
              data.label,
              style: TextStyle(
                color: StyleColors.BRAND_SECONDARY_60,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    data.value,
                    style: TextStyle(
                      color: StyleColors.BRAND_SECONDARY_50,
                    ),
                  ),
                ),
                buildCopyButton(context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCopyButton(BuildContext context) {
    final copyTextHandler = CopyTextHandler();

    return data.isCopiable
        ? GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => copyTextHandler(
              context,
              data.label,
              data.value,
            ),
            child: Icon(
              RemessaIcons.copy,
              color: StyleColors.BRAND_PRIMARY_40,
              size: 16,
            ),
          )
        : Container();
  }
}
