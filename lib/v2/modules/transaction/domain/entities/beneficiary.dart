import 'account_info.dart';
import 'intermediary_bank_info.dart';

class BeneficiaryEntity {
  int id;
  String name;
  String country;
  String bankName;
  String redirectUrl;
  List<AccountInfoEntity> accountInfo;
  List<IntermediaryBankInfoEntity> intermediaryBankInfo;

  BeneficiaryEntity({
    this.id,
    this.name,
    this.country,
    this.bankName,
    this.redirectUrl,
    this.accountInfo,
    this.intermediaryBankInfo,
  });
}
