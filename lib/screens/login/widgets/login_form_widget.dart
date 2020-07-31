import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/url_helper.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/divider_with_text_widget.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';
import 'package:remessa_app/widgets/text_input/text_input_widget.dart';

class LoginFormWidget extends StatefulWidget {
  LoginFormWidget({
    Key key,
    @required this.login,
  })  : assert(login != null),
        super(key: key);

  final Future<dynamic> Function(String, String) login;

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();
  final _formKey = GlobalKey<FormState>();

  final cpfCtrl = MaskedTextController(
    mask: GetIt.I<I18n>().trans(
      'document',
      ['cpf', 'mask'],
    ),
  );

  final passwordFocus = FocusNode();
  final passwordCtrl = TextEditingController();

  bool cpfHasError = false;

  @override
  void initState() {
    UxCamHelper.protectField(passwordFocus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextInputWidget(
                key: Key(LoginScreenKeys.cpfInput),
                controller: cpfCtrl,
                decoration: InputDecoration(
                  suffixIconConstraints: BoxConstraints(
                    maxHeight: 0,
                    minWidth: 25,
                  ),
                  suffixIcon: cpfHasError
                      ? Icon(
                          RemessaIcons.warning,
                          size: 16,
                          color: StyleColors.SUPPORT_DANGER_40,
                        )
                      : null,
                  labelText: i18n.trans('document', ['cpf', 'label']),
                  hintText: i18n.trans('document', ['cpf', 'mask']),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      cpfHasError = true;
                    });

                    return i18n.trans('requiredField');
                  } else if (!CPFValidator.isValid(value)) {
                    setState(() {
                      cpfHasError = true;
                    });

                    return i18n.trans('login_screen', ['invalidCPF']);
                  }

                  setState(() {
                    cpfHasError = false;
                  });

                  return null;
                },
              ),
              TextInputWidget(
                controller: passwordCtrl,
                focusNode: passwordFocus,
                obscureText: true,
                labelText: i18n.trans('password'),
                validator: (value) {
                  if (value.isEmpty) {
                    return i18n.trans('requiredField');
                  }
                  return null;
                },
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                child: GradientButtonWidget(
                  onPressed: () => _login(context),
                  label: i18n.trans('continue'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: GestureDetector(
                  child: Text(
                    i18n.trans('forgotMyPassword'),
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: StyleColors.BRAND_PRIMARY_40,
                          fontSize: 16,
                        ),
                  ),
                  onTap: _forgotPassword,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 22),
                child: DividerWithTextWidget(
                  i18n.trans('or'),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 20),
                child: OutlineButton(
                  padding: EdgeInsets.all(15),
                  borderSide: BorderSide(
                    color: StyleColors.BRAND_PRIMARY_40,
                  ),
                  onPressed: _register,
                  child: Text(
                    i18n.trans('login_screen', ['register']),
                    style: Theme.of(context).textTheme.button.copyWith(
                          color: StyleColors.BRAND_PRIMARY_40,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState.validate()) {
      final cpf = cpfCtrl.value.text;
      final password = passwordCtrl.value.text;

      TrackEvents.log(TrackEvents.LOGIN_SUBMIT_LOGIN_VALID);

      await widget.login(cpf, password);
    } else {
      TrackEvents.log(TrackEvents.LOGIN_SUBMIT_LOGIN_INVALID);
    }

    passwordCtrl.clear();
  }

  _forgotPassword() {
    TrackEvents.log(TrackEvents.LOGIN_FORGOT_PASSWORD_CLICK);
    FocusScope.of(context).requestFocus(FocusNode());
    navigator.pushNamed(
      Router.WEBSITE_REDIRECT_ROUTE,
      arguments: WebsiteRedirectScreenArgs(
        url: UrlHelper.FORGOT_PASSWORD_URL,
      ),
    );
  }

  _register() {
    TrackEvents.log(TrackEvents.LOGIN_REGISTER_CLICK);
    FocusScope.of(context).requestFocus(FocusNode());
    navigator.pushNamed(
      Router.WEBSITE_REDIRECT_ROUTE,
      arguments: WebsiteRedirectScreenArgs(
        url: UrlHelper.REGISTER_URL,
      ),
    );
  }
}
