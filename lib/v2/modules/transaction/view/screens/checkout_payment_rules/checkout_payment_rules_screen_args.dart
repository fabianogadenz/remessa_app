import 'package:flutter/foundation.dart';

class CheckoutPaymentRulesScreenArgs {
  final bool isProgressive;
  final String paymentDeadLineDate;

  CheckoutPaymentRulesScreenArgs({
    @required this.isProgressive,
    @required this.paymentDeadLineDate,
  })  : assert(isProgressive != null),
        assert(paymentDeadLineDate != null);
}
