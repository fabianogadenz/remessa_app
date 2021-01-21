import 'package:remessa_app/v2/modules/transaction/application/viewmodels/intermediary_bank_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';

import 'account_info_viewmodel.dart';

class BeneficiaryViewModel {
  final int id;
  final String name;
  final String country;
  final String bankName;
  final String redirectUrl;
  final List<AccountInfoViewModel> accountInfo;
  final List<IntermediaryBankInfoViewModel> intermediaryBankInfo;

  BeneficiaryViewModel({
    this.id,
    this.name,
    this.country,
    this.bankName,
    this.redirectUrl,
    this.accountInfo,
    this.intermediaryBankInfo,
  });

  factory BeneficiaryViewModel.fromEntity(
          BeneficiaryEntity beneficiaryEntity) =>
      BeneficiaryViewModel(
        id: beneficiaryEntity.id,
        name: beneficiaryEntity.name,
        country: beneficiaryEntity.country,
        bankName: beneficiaryEntity.bankName,
        redirectUrl: beneficiaryEntity.redirectUrl,
        accountInfo: beneficiaryEntity.accountInfo
                ?.map(
                  (e) => AccountInfoViewModel(
                    label: e.label,
                    description: e.description,
                    value: e.value,
                  ),
                )
                ?.toList() ??
            [],
        intermediaryBankInfo: beneficiaryEntity.intermediaryBankInfo
                ?.map(
                  (e) => IntermediaryBankInfoViewModel(
                    id: e.id,
                    description: e.description,
                    isIntermedianBank: e.isIntermedianBank,
                    isRequired: e.isRequired,
                    label: e.label,
                    mask: e.mask,
                    type: e.type,
                    value: e.value,
                  ),
                )
                ?.toList() ??
            [],
      );
}
