import 'package:flutter/foundation.dart';
import 'package:remessa_app/stores/quote_store.dart';

class TransactionCalculationScreenArgs {
  final QuoteStore quoteStore;
  final bool showTimer;
  final String beneficiaryName;

  const TransactionCalculationScreenArgs({
    @required this.quoteStore,
    @required this.beneficiaryName,
    this.showTimer = false,
  })  : assert(quoteStore != null),
        assert(beneficiaryName != null);
}
