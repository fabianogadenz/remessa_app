import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/helpers/environment_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SetUp.registerConfig();

  final remoteConfigs = ConfigModel(environment: Environment.DEV);

  await SetUp(remoteConfigs).init();

  runApp(App());
}
