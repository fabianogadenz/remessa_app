import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class InitialScreen extends StatelessWidget {
  final i18n = GetIt.I<I18n>();

  _openLogin(BuildContext context) {
    NavigatorHelper.push(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      appBarText: 'lalala',
      isStatic: true,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/full_icon.png',
            width: 250,
          ),
          Text(
            i18n.trans('initial_screen', ['title']),
            style: Theme.of(context).textTheme.title,
            textAlign: TextAlign.center,
          ),
          Image.asset('images/initial_screen.png'),
          BigButton(
            text: i18n.trans('enter'),
            onPressed: () => _openLogin(context),
          ),
        ],
      ),
    );
  }
}

class BigButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const BigButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  })  : assert(text != null),
        assert(onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      child: RaisedButton(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: Text(
          text,
          style: theme.textTheme.button.copyWith(
            fontSize: 20,
            color: theme.primaryColor,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
