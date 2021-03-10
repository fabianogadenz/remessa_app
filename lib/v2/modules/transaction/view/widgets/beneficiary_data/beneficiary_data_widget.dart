import 'package:flutter/material.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/core/widgets/label_value_data_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';

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
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            LabelValueDataSectionWidget(
              data: LabelValueModel(
                label: 'Titular da conta',
                value: beneficiary.name,
              ),
            ),
            LabelValueDataSectionWidget(
              data: LabelValueModel(
                label: 'Banco',
                value: beneficiary.bankName,
              ),
            ),
            LabelValueDataSectionWidget(
              data: LabelValueModel(
                label: 'País da conta bancária',
                value: beneficiary.country,
                hasDivider: dynamicValues.isEmpty ? false : true,
              ),
            ),
            ...(dynamicValues
                .asMap()
                .map(
                  (i, value) => MapEntry(
                    i,
                    LabelValueDataSectionWidget(
                      data: LabelValueModel(
                        label: value.label,
                        value: value.value,
                        hasDivider:
                            (i == dynamicValues.length - 1) ? false : true,
                      ),
                    ),
                  ),
                )
                .values
                .toList()),
          ],
        ),
      ),
    );
  }
}
