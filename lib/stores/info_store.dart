import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/services/info_service.dart';

part 'info_store.g.dart';

class InfoStore = _InfoStoreBase with _$InfoStore;

abstract class _InfoStoreBase with Store {
  @observable
  bool isLoading = true;

  @action
  setIsLoading(bool value) => isLoading = value;

  @observable
  InfoStepperModel info;

  @action
  check() async {
    info = await InfoService.check();
    setIsLoading(false);
  }

  @computed
  get hasInfoToShow => info != null;
}
