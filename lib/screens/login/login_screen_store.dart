import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/error_model.dart';
import 'package:remessa_app/stores/auth_store.dart';

part 'login_screen_store.g.dart';

class LoginScreenStore = _LoginScreenStoreBase with _$LoginScreenStore;

abstract class _LoginScreenStoreBase with Store {
  final _authStore = GetIt.I<AuthStore>();

  @observable
  bool isLoading;

  @action
  setIsLoading(bool value) => isLoading = value;

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => errorMessage = value;

  @action
  login(String cpf, String password) async {
    setIsLoading(true);
    setErrorMessage('');

    try {
      await _authStore.login(cpf, password);
    } on ErrorModel catch (e) {
      setErrorMessage(e?.mainError?.message);
    } catch (e) {
      setErrorMessage(e?.error);
    }

    setIsLoading(false);
  }
}
