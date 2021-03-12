import 'package:flutter/foundation.dart';

class CheckoutPaymentRulesScreenArgs {
  final bool isProgressive;

  CheckoutPaymentRulesScreenArgs({
    @required this.isProgressive,
  }) : assert(isProgressive != null);
}
