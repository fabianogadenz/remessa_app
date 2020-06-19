import 'package:flutter/foundation.dart';

class HowToPayScreenArgs {
  final String paymentDeadline;

  const HowToPayScreenArgs({@required this.paymentDeadline})
      : assert(paymentDeadline != null);
}
