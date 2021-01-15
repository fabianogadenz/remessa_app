import 'package:remessa_app/v2/modules/transaction/domain/entities/account_info.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/intermediary_bank_info.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/account_info_model.dart';
import 'package:remessa_app/v2/modules/transaction/infra/data/models/intermediary_bank_info_model.dart';

class BeneficiaryModel extends BeneficiaryEntity {
  int id;
  String name;
  String country;
  String bankName;
  String redirectUrl;
  List<AccountInfoEntity> accountInfo;
  List<IntermediaryBankInfoEntity> intermediaryBankInfo;

  BeneficiaryModel.fromJson(Map<String, dynamic> json) {
    id = json['historyId'];
    name = json['name'];
    country = json['country'];
    bankName = json['bankName'];
    redirectUrl = json['redirectUrl'];
    if (json['accountInfo'] != null) {
      accountInfo = List<AccountInfoModel>();
      json['accountInfo'].forEach((v) {
        accountInfo.add(AccountInfoModel.fromJson(v));
      });
    }
    if (json['intermediaryBankInfo'] != null) {
      intermediaryBankInfo = List<IntermediaryBankInfoModel>();
      json['intermediaryBankInfo'].forEach((v) {
        intermediaryBankInfo.add(IntermediaryBankInfoModel.fromJson(v));
      });
    }
  }
}
