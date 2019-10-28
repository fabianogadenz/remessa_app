import 'package:flutter/material.dart';
import 'package:intercom_flutter/intercom_flutter.dart';

import 'package:remessa_app/app.dart';

void main() async {
  await Intercom.initialize(
    'nucbuzqn',
    iosApiKey: 'ios_sdk-a404f625a23cc834f9d2ee079c7b5b2dbdec533e',
    androidApiKey: 'android_sdk-1781b33f946be31caf417d150915e354756a9b8b',
  );
  runApp(App());
}
