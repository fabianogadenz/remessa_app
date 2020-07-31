import 'package:flutter/foundation.dart';

class TransactionDetailsScreenArgs {
  final int transactionId;

  const TransactionDetailsScreenArgs({@required this.transactionId})
      : assert(transactionId != null);
}
