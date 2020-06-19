import 'package:flutter/foundation.dart';
import 'package:remessa_app/models/responses/transaction_details_response_model.dart';

class BeneficiaryDataScreenArgs {
  final TransactionDetailsResponseModel transactionDetails;

  const BeneficiaryDataScreenArgs({@required this.transactionDetails})
      : assert(transactionDetails != null);
}
