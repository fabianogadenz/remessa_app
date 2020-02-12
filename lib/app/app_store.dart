import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/services/auth_service.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final _authService = GetIt.I<AuthService>();
  final ConfigModel configs;

  _AppStoreBase(this.configs) {
    isLoggedIn = _authService.isLoggedIn;
  }

  @observable
  bool isLoggedIn;

  @action
  refreshIsLoggedIn() => isLoggedIn = _authService.isLoggedIn;

  @action
  logout() {
    _authService.logout();
    isLoggedIn = false;
  }
}
