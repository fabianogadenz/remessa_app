import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/transaction_details/widgets/text_value_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/handlers/copy_text_handler.dart';

class DetailItemWidget extends StatelessWidget {
  DetailItemWidget({
    Key key,
    this.label,
    this.value,
    this.isValueCopyable = false,
    this.showLabel = true,
    this.copyableValue,
    this.titleSpotlight = false,
    this.valueSpotlight = false,
    this.onTapInfo,
  })  : assert(!isValueCopyable || label != null),
        assert(value != null),
        super(key: key);

  final String label;
  final String value;
  final bool isValueCopyable;
  final bool showLabel;
  final String copyableValue;
  final bool titleSpotlight;
  final bool valueSpotlight;
  final Function onTapInfo;

  final i18n = GetIt.I<I18n>();
  final copyTextHandler = CopyTextHandler();

  copy(BuildContext context) {
    TrackingEvents.log(
      TrackingEvents.TRANSACTION_COPY_LOCAL_BANCK_INFO,
      {'label': label},
    );

    copyTextHandler(context, label, copyableValue ?? value);
  }

  @override
  Widget build(BuildContext context) {
    final labelWidgets = <Widget>[
      SizedBox(
        height: titleSpotlight ? 32 : 16,
      ),
    ];

    if (showLabel && label != null) {
      final _labelText = Text(
        label,
        style: titleSpotlight
            ? TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: StyleColors.BRAND_SECONDARY_80,
              )
            : TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: StyleColors.BRAND_SECONDARY_50,
              ),
      );

      if (onTapInfo != null) {
        labelWidgets.add(
          Row(
            children: [
              _labelText,
              SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: onTapInfo,
                child: Icon(
                  Icons.info,
                  color: StyleColors.BRAND_PRIMARY_40,
                  size: 17,
                ),
              ),
            ],
          ),
        );
      } else {
        labelWidgets.add(
          Row(
            children: [
              Expanded(child: _labelText),
            ],
          ),
        );
      }

      labelWidgets.add(
        SizedBox(
          height: titleSpotlight ? 8 : 4,
        ),
      );
    }

    final textValue = TextValueWidget(
      value,
      color: valueSpotlight
          ? StyleColors.BRAND_SECONDARY_80
          : StyleColors.BRAND_SECONDARY_60,
    );

    return GestureDetector(
      onTap: onTapInfo ?? (isValueCopyable ? () => copy(context) : null),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ...labelWidgets,
          isValueCopyable
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => copy(context),
                        child: Icon(
                          RemessaIcons.copy,
                          color: StyleColors.BRAND_PRIMARY_40,
                          size: 16,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      textValue,
                    ],
                  ),
                )
              : textValue,
        ],
      ),
    );
  }
}
