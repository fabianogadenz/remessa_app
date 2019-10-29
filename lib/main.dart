import 'package:flutter/material.dart';

import 'package:remessa_app/app.dart';
import 'package:remessa_app/setup.dart';

void main() async {
  await SetUp.init();

  runApp(App());
}
