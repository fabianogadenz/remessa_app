import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/skeleton_line_widget.dart';

class CurrencyTextFormFieldWidget extends StatelessWidget {
  const CurrencyTextFormFieldWidget({
    Key key,
    @required this.controller,
    this.isLoading = false,
    this.validator,
    this.onChanged,
    this.inputFormatters = const [],
    this.suffixIcon,
    this.focusNode,
  })  : assert(controller != null),
        super(key: key);

  final TextEditingController controller;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode focusNode;
  final Function(String) validator;
  final Function(String) onChanged;
  final Widget suffixIcon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: isLoading
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Container(
                alignment: Alignment.centerRight,
                child: SkeletonLineWidget(
                  color: StyleColors.BRAND_SECONDARY_10,
                  width: 80,
                  height: 11,
                ),
              ),
            )
          : TextFormField(
              controller: controller,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyHelper.mask,
                ...inputFormatters,
              ],
              focusNode: focusNode,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.right,
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: suffixIcon ?? Container(),
                suffixIconConstraints: BoxConstraints.tight(
                  suffixIcon != null ? Size(20, 8) : Size.zero,
                ),
              ),
              style: TextStyle(
                color: StyleColors.BRAND_PRIMARY_80,
                fontSize: 24,
              ),
            ),
    );
  }
}
