import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_acronym_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_image_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_text_form_field_widget.dart';
import 'package:remessa_app/style/colors.dart';

class CustomCurrencyInputWidget extends StatelessWidget {
  const CustomCurrencyInputWidget({
    Key key,
    @required this.controller,
    this.label = '',
    this.currencyImgUrl = '',
    this.currencyAcronym = '',
    this.isChangeable = false,
    this.isLoading = false,
    this.validator,
    this.onChanged,
    this.changeableCallback,
    this.inputFormatters = const [],
    this.errorMessage,
    this.focusNode,
  })  : assert(label != null),
        assert(currencyImgUrl != null),
        assert(currencyAcronym != null),
        super(key: key);

  final TextEditingController controller;
  final Function(String) validator;
  final Function(String) onChanged;
  final String errorMessage;
  final List<TextInputFormatter> inputFormatters;
  final Function changeableCallback;
  final String label;
  final String currencyImgUrl;
  final String currencyAcronym;
  final bool isChangeable;
  final bool isLoading;
  final FocusNode focusNode;

  final _errorColor = StyleColors.SUPPORT_DANGER_40;
  bool get _hasError => errorMessage != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: _hasError ? _errorColor : StyleColors.SUPPORT_NEUTRAL_40,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              label.isNotEmpty
                  ? Text(
                      label,
                      style: TextStyle(
                        color: _hasError
                            ? _errorColor
                            : StyleColors.BRAND_SECONDARY_50,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    )
                  : Container(),
              Container(
                height: 50,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: isChangeable ? changeableCallback : null,
                      child: Row(
                        children: <Widget>[
                          CurrencyImageWidget(
                            imageUrl: currencyImgUrl,
                            isLoading: isLoading,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          CurrencyAcronymWidget(
                            currencyAcronym: currencyAcronym,
                            isChangeable: isChangeable,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),
                    CurrencyTextFormFieldWidget(
                      controller: controller,
                      focusNode: focusNode,
                      inputFormatters: inputFormatters,
                      validator: validator,
                      onChanged: onChanged,
                      isLoading: isLoading,
                      suffixIcon: _hasError
                          ? Icon(
                              RemessaIcons.warning,
                              size: 16,
                              color: StyleColors.SUPPORT_DANGER_40,
                            )
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        _hasError
            ? Column(
                children: <Widget>[
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: _errorColor,
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
