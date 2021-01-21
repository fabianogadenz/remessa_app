import 'package:remessa_app/v2/modules/transaction/domain/entities/fee_tax.dart';

class FeeTaxModel extends FeeTaxEntity {
  String label;
  String description;
  double value;

  FeeTaxModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    value = json['value'].toDouble();
  }
}
