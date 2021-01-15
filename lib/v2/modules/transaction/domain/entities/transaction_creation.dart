import 'beneficiary.dart';
import 'currency.dart';

class TransactionCreationEntity {
  int operationType;
  bool reverse;
  double quantity;
  double totalValue;
  String voucher;
  CurrencyEntity currency;
  BeneficiaryEntity beneficiary;

  TransactionCreationEntity({
    this.operationType,
    this.reverse,
    this.quantity,
    this.totalValue,
    this.voucher,
    this.currency,
    this.beneficiary,
  });
}
