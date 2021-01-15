import 'package:remessa_app/v2/modules/transaction/application/viewmodels/cost_description_home_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/cost_description.dart';

class CostDescriptionViewModel {
  List<CostDescriptionHomeViewModel> home;
  List<String> details;

  CostDescriptionViewModel({
    this.home,
    this.details,
  });

  factory CostDescriptionViewModel.fromEntity(
          CostDescriptionEntity costDescriptionEntity) =>
      CostDescriptionViewModel(
        home: costDescriptionEntity.home
                ?.map(
                  (e) => CostDescriptionHomeViewModel(
                    type: e.type,
                    description: e.description,
                    label: e.label,
                  ),
                )
                ?.toList() ??
            [],
        details: costDescriptionEntity.details,
      );
}
