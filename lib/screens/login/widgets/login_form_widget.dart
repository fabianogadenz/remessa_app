import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/screens/login/bloc/bloc.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:remessa_app/style/colors.dart';
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
  final i18n = GetIt.I<I18n>();
  final _formKey = GlobalKey<FormState>();
  final cpfCtrl = MaskedTextController(
    mask: GetIt.I<I18n>().trans(
      'document',
      ['cpf', 'mask'],
    ),
  );
  final passwordCtrl = TextEditingController();
  final amplitude = GetIt.I<AmplitudeFlutter>();

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
              labelText: i18n.trans('document', ['cpf', 'label']),
              hintText: i18n.trans('document', ['cpf', 'mask']),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return i18n.trans('requiredField');
                } else if (!CPFValidator.isValid(value)) {
                  return i18n.trans('login_screen', ['invalidCPF']);
                }
                return null;
              },
            ),
            TextInput(
              controller: passwordCtrl,
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
              child: RaisedButton(
                elevation: 0,
                onPressed: () => _login(context),
                child: Text(
                  i18n.trans('continue'),
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: FlatButton(
                child: Text(
                  i18n.trans('forgotMyPassword'),
                  style: Theme.of(context).textTheme.button.copyWith(
                        color: StyleColors.BRAND_PRIMARY_40,
                        fontSize: 16,
                      ),
                ),
                onPressed: _forgotPassword,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _login(BuildContext context) {
    if (_formKey.currentState.validate()) {
      final cpf = cpfCtrl.value.text;
      final password = passwordCtrl.value.text;

      amplitude.logEvent(name: TrackEvents.SUBMIT_LOGIN_VALID);

      _loginScreenBloc.add(
        LoginEvent(
          cpf: cpf,
          password: password,
        ),
      );
    } else {
      amplitude.logEvent(name: TrackEvents.SUBMIT_LOGIN_INVALID);

      passwordCtrl.clear();
    }

    FocusScope.of(context).requestFocus(FocusNode());
  }

  _forgotPassword() {
    amplitude.logEvent(name: TrackEvents.FORGOT_PASSWORD_CLICK);
    launch('https://www.remessaonline.com.br/recuperar-senha');
  }
}
