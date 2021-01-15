import 'package:meta/meta.dart';

class TransactionCreationViewModel {
  final int operationType;
  final bool reverse;
  final double quantity;
  final double totalValue;
  final String voucher;
  final int currencyId;
  final String currencyAbbreviation;
  final int beneficiaryId;

  TransactionCreationViewModel({
    @required this.operationType,
    @required this.reverse,
    @required this.quantity,
    @required this.totalValue,
    @required this.voucher,
    @required this.currencyId,
    @required this.currencyAbbreviation,
    @required this.beneficiaryId,
  });
}
