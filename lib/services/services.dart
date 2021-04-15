import 'package:get_it/get_it.dart';
import 'package:remessa_app/constants.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/download_service.dart';
import 'package:remessa_app/services/system_service.dart';

class Services {
  static Future<void> register(Constants constants) async {
    final authService = AuthService();
    final systemService = await SystemService.init();

    GetIt.I.registerLazySingleton<AuthService>(
      () => authService,
    );

    GetIt.I.registerLazySingleton<SystemService>(
      () => systemService,
    );

    GetIt.I.registerLazySingleton<DownloadService>(
        () => DownloadService(baseUrl: constants.api['url']));
  }
}
