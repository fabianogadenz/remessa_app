import 'package:mobx/mobx.dart';

part 'transaction_details_screen_store.g.dart';

class TransactionDetailsScreenStore = _TransactionDetailsScreenStoreBase
    with _$TransactionDetailsScreenStore;

abstract class _TransactionDetailsScreenStoreBase with Store {
  @observable
  bool isLoading = true;

  @action
  setIsLoading(bool value) => isLoading = value;

  @observable
  String errorMessage;

  @action
  setErrorMessage(String value) => errorMessage = value;
}
