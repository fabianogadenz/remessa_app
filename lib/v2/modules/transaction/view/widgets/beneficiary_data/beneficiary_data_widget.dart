import 'package:flutter/material.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/beneficiary_data/beneficiary_data_section_widget.dart';

class BeneficiaryDataWidget extends StatelessWidget {
  final BeneficiaryViewModel beneficiary;

  const BeneficiaryDataWidget({Key key, @required this.beneficiary})
      : assert(beneficiary != null),
        super(key: key);

  List get dynamicValues {
    final values = [];

    values
      ..addAll(beneficiary.accountInfo)
      ..addAll(beneficiary.intermediaryBankInfo);

    return values;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          BeneficiaryDataSectionWidget(
            label: 'Titular da conta',
            value: beneficiary.name,
          ),
          BeneficiaryDataSectionWidget(
            label: 'Banco',
            value: beneficiary.bankName,
          ),
          BeneficiaryDataSectionWidget(
            label: 'País da conta bancária',
            value: beneficiary.country,
            hasDivider: dynamicValues.isEmpty ? false : true,
          ),
          ...(dynamicValues
              .asMap()
              .map(
                (i, value) => MapEntry(
                  i,
                  BeneficiaryDataSectionWidget(
                    label: value.label,
                    value: value.value,
                    hasDivider: (i == dynamicValues.length - 1) ? false : true,
                  ),
                ),
              )
              .values
              .toList()),
        ],
      ),
    );
  }
}
