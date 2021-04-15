import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/services/auth_service.dart';
import 'package:remessa_app/services/system_service.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final _authService = GetIt.I<AuthService>();

  @observable
  bool isLoggedIn;

  @observable
  Customer customer;

  @action
  refreshUserIdentity() async {
    final _customer = await _authService.customer;
    final _isLoggedIn = await _authService.isLoggedIn;

    isLoggedIn = _isLoggedIn;
    customer = _customer;

    _authService.setUserIdentity(_customer);
  }

  @action
  Future<void> logout() async {
    await _authService.logout();
    isLoggedIn = false;
  }

  @action
  Future<void> login(String cpf, String password) async {
    await GetIt.I<AuthService>().login(cpf, password);

    refreshUserIdentity();

    GetIt.I<SystemService>().setShowStepper(false);
  }
}
