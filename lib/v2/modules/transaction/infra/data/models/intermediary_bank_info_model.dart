import 'package:remessa_app/v2/modules/transaction/domain/entities/intermediary_bank_info.dart';

class IntermediaryBankInfoModel extends IntermediaryBankInfoEntity {
  String description;
  bool isRequired;
  String mask;
  String label;
  String type;
  String id;
  String value;
  bool isIntermedianBank;

  IntermediaryBankInfoModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    isRequired = json['required'];
    mask = json['mask'];
    label = json['label'];
    type = json['type'];
    id = json['id'];
    value = json['value'];
    isIntermedianBank = json['isIntermedianBank'];
  }
}
