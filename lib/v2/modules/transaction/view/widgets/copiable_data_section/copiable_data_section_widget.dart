import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/core/widgets/label_value_data_section_widget.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:remessa_app/widgets/outline_button_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CopyableDataSectionWidget extends StatelessWidget {
  final String title;
  final List<LabelValueModel> data;
  final ac.Action action;
  final ac.Action secondaryAction;

  const CopyableDataSectionWidget({
    Key key,
    this.title,
    @required this.data,
    this.action,
    this.secondaryAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          buildTitle(),
          SizedBox(
            height: 24,
          ),
          ...data
              .map(
                (data) => LabelValueDataSectionWidget(
                  data: data,
                ),
              )
              .toList(),
          SizedBox(
            height: 40,
          ),
          buildGradientButtonWidget(),
          SizedBox(
            height: 16,
          ),
          buildOutlineButtonWidget(),
        ],
      ),
    );
  }

  Widget buildTitle() => title != null
      ? Container(
          width: double.infinity,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: StyleColors.BRAND_SECONDARY_60,
            ),
            textAlign: TextAlign.start,
          ),
        )
      : Container();

  Widget buildGradientButtonWidget() {
    return action != null
        ? GradientButtonWidget(
            label: action.name,
            onPressed: action.action,
          )
        : Container();
  }

  Widget buildOutlineButtonWidget() {
    return secondaryAction != null
        ? OutlineButtonWidget(
            label: secondaryAction.name,
            onPressed: secondaryAction.action,
          )
        : Container();
  }
}
