import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/services/remote_config_service.dart';
import 'package:remessa_app/setup.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final configVersion = await RemoteConfigService.getConfigVersion();
  final remoteConfigs = await RemoteConfigService.getConfigs(configVersion);

  await SetUp(remoteConfigs).init();

  runApp(App());
}
