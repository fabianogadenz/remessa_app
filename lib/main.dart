import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/services/config_service.dart';
import 'package:remessa_app/setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configService = ConfigService();
  await configService.init();

  final remoteConfigs = configService.getConfigs();

  await SetUp(remoteConfigs).init();

  runApp(App());
}
