import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/screens/login/bloc/bloc.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/widgets/text_input/text_input.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginFormWidget extends StatelessWidget {
  LoginFormWidget({
    Key key,
    @required LoginScreenBloc loginScreenBloc,
    @required this.formState,
  })  : _loginScreenBloc = loginScreenBloc,
        assert(loginScreenBloc != null),
        super(key: key);

  final LoginScreenBloc _loginScreenBloc;
  final LoginScreenFormState formState;
  final _formKey = GlobalKey<FormState>();
  final cpfCtrl = MaskedTextController(mask: '000.000.000-00');
  final passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (formState != null) {
      cpfCtrl.text = formState.cpf;
      passwordCtrl.text = formState.password;
    }

    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextInput(
              textFormFieldKey: Key(LoginScreenKeys.cpfInput),
              controller: cpfCtrl,
              labelText: I18n.of(context).trans('document', ['cpf', 'label']),
              hintText: I18n.of(context).trans('document', ['cpf', 'mask']),
              validator: (value) {
                if (value.isEmpty) {
                  return I18n.of(context).trans('requiredField');
                } else if (!CPFValidator.isValid(value)) {
                  return I18n.of(context).trans('login_screen', ['invalidCPF']);
                }
                return null;
              },
            ),
            TextInput(
              controller: passwordCtrl,
              obscureText: true,
              labelText: I18n.of(context).trans('password'),
              validator: (value) {
                if (value.isEmpty) {
                  return I18n.of(context).trans('requiredField');
                }
                return null;
              },
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 20),
              child: RaisedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final cpf = cpfCtrl.value.text;
                    final password = passwordCtrl.value.text;

                    _loginScreenBloc.add(
                      LoginEvent(
                        cpf: cpf,
                        password: password,
                      ),
                    );
                  }

                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Text(
                  I18n.of(context).trans('continue'),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            FlatButton(
              child: Text(
                I18n.of(context).trans('forgotMyPassword'),
              ),
              onPressed: _forgotPassword,
            ),
          ],
        ),
      ),
    );
  }

  _forgotPassword() {
    launch('http://google.com');
  }
}
