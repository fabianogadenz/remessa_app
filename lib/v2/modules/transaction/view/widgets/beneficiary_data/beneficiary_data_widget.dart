import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/core/widgets/label_value_data_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';

class BeneficiaryDataWidget extends StatelessWidget {
  final BeneficiaryViewModel beneficiary;

  BeneficiaryDataWidget({Key key, @required this.beneficiary})
      : assert(beneficiary != null),
        super(key: key);

  final i18n = GetIt.I<I18n>();

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
                label: i18n.trans('account_owner'),
                value: beneficiary.name,
              ),
            ),
            LabelValueDataSectionWidget(
              data: LabelValueModel(
                label: i18n.trans('bank'),
                value: beneficiary.bankName,
              ),
            ),
            LabelValueDataSectionWidget(
              data: LabelValueModel(
                label: i18n
                    .trans('checkout', ['beneficiary_bank_account_country']),
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
