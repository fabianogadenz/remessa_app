import 'package:mobx/mobx.dart';
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/models/responses/info_response_model.dart';
import 'package:remessa_app/services/info_service.dart';
import 'package:remessa_app/services/view_generator_service.dart';

part 'info_store.g.dart';

class InfoStore = _InfoStoreBase with _$InfoStore;

abstract class _InfoStoreBase with Store {
  @observable
  bool isLoading = true;

  @action
  setIsLoading(bool value) => isLoading = value;

  @observable
  bool shown = false;

  @action
  setShown(bool value) => shown = value;

  @observable
  InfoResponseModel infoResponseModel;

  @action
  check() async {
    infoResponseModel = await InfoService.check();
    if (hasInfoToShow) await getInfo(infoResponseModel.url);
    setIsLoading(false);
  }

  @computed
  get hasInfoToShow =>
      !shown && infoResponseModel != null && infoResponseModel.url != null;

  @observable
  InfoStepperModel info;

  @action
  getInfo(String url) async {
    info = await ViewGeneratorService.getViewGenerator(url);
  }
}
