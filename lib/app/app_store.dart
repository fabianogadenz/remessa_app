import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/config_model.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {
  final ConfigModel configs;

  _AppStoreBase(this.configs);

  @observable
  int transactionId;

  @action
  setTransactionId(int value) => transactionId = value;
}
