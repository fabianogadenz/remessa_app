import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.controller,
    this.decoration,
    this.focusNode,
    this.hasError = false,
    this.isDisabled = false,
    this.inputFormatters = const [],
    this.maxLength,
  });

  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final Function(String) onChanged;
  final TextEditingController controller;
  final InputDecoration decoration;
  final FocusNode focusNode;
  final bool hasError;
  final bool isDisabled;
  final List<TextInputFormatter> inputFormatters;
  final int maxLength;

  final _errorColor = StyleColors.SUPPORT_DANGER_40;

  @override
  Widget build(BuildContext context) {
    InputDecoration _decoration = decoration ??
        InputDecoration(
          labelText: labelText,
          hintText: hintText,
        );

    if (hasError) {
      _decoration = _decoration.copyWith(
        labelStyle: TextStyle(color: _errorColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _errorColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: _errorColor),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        key: key,
        controller: controller,
        focusNode: focusNode ?? FocusNode(),
        obscureText: obscureText,
        readOnly: isDisabled,
        maxLength: maxLength,
        autocorrect: false,
        enableSuggestions: false,
        inputFormatters: [
          ...inputFormatters,
        ],
        decoration: _decoration.copyWith(
          counterText: '',
          suffixIcon: hasError
              ? Icon(
                  RemessaIcons.warning,
                  size: 16,
                  color: StyleColors.SUPPORT_DANGER_40,
                )
              : null,
        ),
        style: TextStyle(
          color: StyleColors.BRAND_PRIMARY_80,
          decoration: TextDecoration.none,
        ),
        keyboardType: keyboardType,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
