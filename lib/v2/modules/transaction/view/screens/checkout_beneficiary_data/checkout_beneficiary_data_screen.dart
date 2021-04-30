import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/beneficiary_data/beneficiary_data_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';

class CheckoutBeneficiaryDataScreen extends StatelessWidget {
  final BeneficiaryViewModel beneficiary;

  const CheckoutBeneficiaryDataScreen({Key key, @required this.beneficiary})
      : assert(beneficiary != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColors.SUPPORT_NEUTRAL_10,
      appBar: CheckoutAppBar(
        title: GetIt.I<I18n>().trans('checkout', ['beneficiary_data']),
      ),
      body: BeneficiaryDataWidget(
        beneficiary: beneficiary,
      ),
    );
  }
}
