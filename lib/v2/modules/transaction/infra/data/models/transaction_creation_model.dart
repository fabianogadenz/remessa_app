import 'package:remessa_app/v2/modules/transaction/domain/entities/beneficiary.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/currency.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/transaction_creation.dart';

class TransactionCreationModel extends TransactionCreationEntity {
  int operationType;
  bool reverse;
  double quantity;
  double totalValue;
  String voucher;
  CurrencyEntity currency;
  BeneficiaryEntity beneficiary;

  TransactionCreationModel({
    this.operationType,
    this.reverse,
    this.quantity,
    this.totalValue,
    this.voucher,
    this.currency,
    this.beneficiary,
  });

  Map<String, dynamic> toJson() => {
        'idOperationType': this.operationType,
        'reverse': this.reverse,
        'quantity': this.quantity,
        'totalValue': this.totalValue,
        'idCurrency': this?.currency?.id,
        'abbreviation': this?.currency?.abbreviation,
        'idBeneficiary': this?.beneficiary?.id,
        'voucherCode': this.voucher,
      };
}
