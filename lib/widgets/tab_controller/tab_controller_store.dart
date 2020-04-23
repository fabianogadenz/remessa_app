import 'package:mobx/mobx.dart';

part 'tab_controller_store.g.dart';

class TabControllerStore = _TabControllerStoreBase with _$TabControllerStore;

abstract class _TabControllerStoreBase with Store {
  @observable
  int currentTabIndex = 0;

  @action
  setCurrentTabIndex(int index) => currentTabIndex = index;

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => errorMessage = value;

  @observable
  bool isLoading;

  @action
  setIsLoading(bool value) {
    isLoading = value;
    setErrorMessage('');
  }
}
