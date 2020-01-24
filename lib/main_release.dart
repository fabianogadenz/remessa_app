import 'package:flutter/material.dart';

import 'package:remessa_app/app/app.dart';
import 'package:remessa_app/models/responses/remote_config_response_model.dart';
import 'package:remessa_app/setup.dart';
import 'package:remessa_app/helpers/environment_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final remoteConfigs =
      RemoteConfigResponseModel(environment: Environment.RELEASE);

  await SetUp(remoteConfigs).init();

  runApp(App());
}
