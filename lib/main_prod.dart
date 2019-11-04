import 'package:flutter/material.dart';

import 'package:remessa_app/app.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/utils/enviroment_model.dart';

void main() async {
  await SetUp(Environment.PROD).init();

  runApp(App());
}
