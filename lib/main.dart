import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/helpers/enviroment_model.dart';

void main() async {
  await SetUp(Environment.DEV).init();

  runApp(App());
}
