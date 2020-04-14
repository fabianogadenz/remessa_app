import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/screens/transaction_details/widgets/text_value_widget.dart';
import 'package:remessa_app/style/colors.dart';

class DetailItemWidget extends StatelessWidget {
  const DetailItemWidget({
    Key key,
    this.label,
    this.value,
    this.isValueCopyable = false,
    this.showLabel = true,
    this.copyableValue,
    this.titleSpotlight = false,
    this.valueSpotlight = false,
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

  @override
  Widget build(BuildContext context) {
    final i18n = GetIt.I<I18n>();

    final labelWidgets = <Widget>[
      SizedBox(
        height: titleSpotlight ? 24 : 16,
      ),
    ];

    if (showLabel && label != null) {
      labelWidgets.addAll([
        Text(
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
        ),
        SizedBox(
          height: titleSpotlight ? 8 : 4,
        ),
      ]);
    }

    final textValue = TextValueWidget(
      value,
      color: valueSpotlight
          ? StyleColors.BRAND_SECONDARY_80
          : StyleColors.BRAND_SECONDARY_60,
    );

    return Column(
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
                      onTap: () {
                        TrackEvents.log(
                          TrackEvents.TRANSACTION_COPY_LOCAL_BANCK_INFO,
                          {'label': label},
                        );

                        Clipboard.setData(
                          ClipboardData(text: copyableValue ?? value),
                        );

                        final snackBar = SnackBar(
                          content: Text(
                            i18n.populate(
                              i18n.trans(
                                  'transaction_details_screen', ['copied']),
                              {'label': label},
                            ),
                          ),
                          action: SnackBarAction(
                            textColor: StyleColors.BRAND_PRIMARY_30,
                            label: i18n.trans('ok').toUpperCase(),
                            onPressed: () {},
                          ),
                        );
                        Scaffold.of(context).showSnackBar(snackBar);
                      },
                      child: Icon(
                        Icons.content_copy,
                        color: StyleColors.BRAND_PRIMARY_40,
                        size: 15,
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
    );
  }
}
