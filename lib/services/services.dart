import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';

class Services {
  static Future<void> register() async {
    final authService = await AuthService.init();

    GetIt.I.registerLazySingleton<AuthService>(
      () => authService,
    );
  }
}
