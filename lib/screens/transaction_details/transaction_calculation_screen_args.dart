import 'package:flutter/foundation.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';

class TransactionCalculationScreenArgs {
  final TransactionDetailsResponseModel transactionDetails;

  const TransactionCalculationScreenArgs({@required this.transactionDetails})
      : assert(transactionDetails != null);
}
