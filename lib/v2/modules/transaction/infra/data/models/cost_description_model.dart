import 'package:remessa_app/v2/modules/transaction/domain/entities/cost_description.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/cost_description_home.dart';

import 'cost_description_home_model.dart';

class CostDescriptionModel extends CostDescriptionEntity {
  List<CostDescriptionHomeEntity> home;
  List<String> details;

  CostDescriptionModel.fromJson(Map<String, dynamic> json) {
    if (json['home'] != null) {
      home = List<CostDescriptionHomeModel>();
      json['home'].forEach((v) {
        home.add(CostDescriptionHomeModel.fromJson(v));
      });
    }
    if (json['details'] != null) details = json['details'].cast<String>();
  }
}
