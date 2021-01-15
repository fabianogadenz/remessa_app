import 'package:remessa_app/v2/modules/transaction/domain/entities/cost_description_home.dart';

class CostDescriptionHomeModel extends CostDescriptionHomeEntity {
  String type;
  String label;
  String description;

  CostDescriptionHomeModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    label = json['label'];
    description = json['description'];
  }
}
