import 'package:remessa_app/v2/modules/transaction/domain/entities/account_info.dart';

class AccountInfoModel extends AccountInfoEntity {
  String label;
  String description;
  String value;

  AccountInfoModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    description = json['description'];
    value = json['value'];
  }
}
