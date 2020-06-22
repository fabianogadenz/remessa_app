import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.controller,
    this.decoration,
    this.focusNode,
  });

  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final TextEditingController controller;
  final InputDecoration decoration;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        key: key,
        controller: controller,
        focusNode: focusNode ?? FocusNode(),
        obscureText: obscureText,
        decoration: decoration ??
            InputDecoration(
              labelText: labelText,
              hintText: hintText,
            ),
        style: TextStyle(
          color: StyleColors.BRAND_PRIMARY_80,
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
