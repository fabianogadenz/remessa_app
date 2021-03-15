import 'package:flutter/foundation.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';

class CheckoutBeneficiaryDataScreenArgs {
  final BeneficiaryViewModel beneficiary;

  CheckoutBeneficiaryDataScreenArgs({@required this.beneficiary})
      : assert(beneficiary != null);
}
