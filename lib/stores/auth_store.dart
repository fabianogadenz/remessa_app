import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
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

  @computed
  Customer get customer => _authService.customer;

  @action
  refreshUserIdentity() => _authService.setUserIdentity(customer);

  @action
  Future<void> logout() async {
    isLoggedIn = false;
    await _authService.logout();
  }

  @action
  Future<void> login(String cpf, String password) async {
    await GetIt.I<AuthService>().login(cpf, password);

    refreshIsLoggedIn();

    GetIt.I<SystemService>().setShowStepper(false);
  }
}
