import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class InitialScreen extends StatelessWidget {
  _openLogin(BuildContext context) {
    NavigatorHelper.push(context, LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(
              'images/full_icon.png',
              width: 250,
            ),
            Text(
              I18n.of(context).trans('initial_page:title'),
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            Image.asset('images/initial_screen.png'),
            Container(
              width: double.infinity,
              child: RaisedButton(
                child: Text(
                  I18n.of(context).trans('enter'),
                  style: Theme.of(context).textTheme.button,
                ),
                onPressed: () => _openLogin(context),
              ),
            )
          ],
        ),
      ),
    );
  }
}
