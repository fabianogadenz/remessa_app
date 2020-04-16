import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/helpers/environment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final remoteConfigs = ConfigModel(environment: Environment.PROD);

  await SetUp(remoteConfigs).init();

  runApp(App());
}
