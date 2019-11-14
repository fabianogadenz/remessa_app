import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:test/test.dart';

class SplashScreenTest {
  static run() {
    group('SplashScreen', () {
      final btnEnterFinder = find.text('Entrar');
      final loginTitleKey = find.byValueKey(LoginScreenKeys.title);

      FlutterDriver driver;

      setUpAll(() async {
        driver = await FlutterDriver.connect();

        sleep(Duration(seconds: 3));
      });

      tearDownAll(() async {
        if (driver != null) {
          driver.close();
        }
      });

      test('Navigate to LoginScreen', () async {
        await driver.tap(btnEnterFinder);

        expect(await driver.getText(loginTitleKey), 'Faça seu login');
      });
    });
  }
}
