import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/system_service.dart';

class Services {
  static Future<void> register() async {
    final authService = await AuthService.init();
    final systemService = await SystemService.init();

    GetIt.I.registerLazySingleton<AuthService>(
      () => authService,
    );

    GetIt.I.registerLazySingleton<SystemService>(
      () => systemService,
    );
  }
}
