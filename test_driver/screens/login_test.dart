import 'package:flutter_driver/flutter_driver.dart';
import 'package:remessa_app/screens/login/keys.dart';
import 'package:test/test.dart';

class LoginScreenTest {
  static run() {
    group('LoginScreen', () {
      final btnContinueFinder = find.text('Continuar');
      final inputCPFFinder = find.byValueKey(LoginScreenKeys.cpfInput);

      FlutterDriver driver;

      setUpAll(() async {
        driver = await FlutterDriver.connect();
      });

      tearDownAll(() async {
        if (driver != null) {
          driver.close();
        }
      });

      test('Invalid CPF', () async {
        await driver.tap(inputCPFFinder);
        await driver.enterText('01234567890');

        await driver.tap(btnContinueFinder);
      });
    });
  }
}
