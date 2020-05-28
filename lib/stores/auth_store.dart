import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/system_service.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final _authService = GetIt.I<AuthService>();

  _AuthStoreBase() {
    isLoggedIn = _authService.isLoggedIn;
  }

  @observable
  bool isLoggedIn;

  @action
  refreshIsLoggedIn() => isLoggedIn = _authService.isLoggedIn;

  @action
  Future<void> logout() async {
    await _authService.logout();
    isLoggedIn = false;
  }

  @action
  Future<void> login(String cpf, String password) async {
    await GetIt.I<AuthService>().login(cpf, password);

    refreshIsLoggedIn();

    GetIt.I<SystemService>().setShowStepper(false);
  }
}
