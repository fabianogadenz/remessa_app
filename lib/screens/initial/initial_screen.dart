import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/screen/screen_widget.dart';

class InitialScreen extends StatelessWidget {
  final i18n = GetIt.I<I18n>();

  _openLogin(BuildContext context) async {
    GetIt.I<AmplitudeFlutter>().logEvent(name: TrackEvents.SPLASH_ENTER_CLICK);
    NavigatorHelper.push(context, LoginScreen());
    await SetUp.startOneSignal();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScreenWidget(
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
            style: theme.textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          Image.asset('images/initial_screen.png'),
          // Container(
          //   width: double.infinity,
          //   child: RaisedButton(
          //     elevation: 0,
          //     color: StyleColors.SUPPORT_NEUTRAL_10,
          //     onPressed: () => _openLogin(context),
          //     child: Text(
          //       i18n.trans('enter'),
          //       style: theme.textTheme.button.copyWith(
          //         color: theme.primaryColor,
          //       ),
          //     ),
          //   ),
          // ),
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
        elevation: 0,
        color: StyleColors.SUPPORT_NEUTRAL_10,
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
