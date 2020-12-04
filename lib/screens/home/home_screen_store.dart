import 'package:mobx/mobx.dart';

part 'home_screen_store.g.dart';

class HomeScreenStore = _HomeScreenStoreBase with _$HomeScreenStore;

abstract class _HomeScreenStoreBase with Store {
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
