import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class TextInput extends StatelessWidget {
  const TextInput({
    Key key,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.controller,
    this.textFormFieldKey,
  }) : super(key: key);

  final String labelText;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final String Function(String) validator;
  final TextEditingController controller;
  final Key textFormFieldKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        key: textFormFieldKey,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
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
