import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';

class PaymentAccountInfoViewModel {
  String accountHolderName;
  String accountHolderDocumentNumber;
  String bankName;
  String bankCode;
  String branchCode;
  String accountNumber;

  PaymentAccountInfoViewModel({
    this.accountHolderName,
    this.accountHolderDocumentNumber,
    this.bankName,
    this.bankCode,
    this.branchCode,
    this.accountNumber,
  });

  factory PaymentAccountInfoViewModel.fromEntity(
          PaymentAccountInfoEntity paymentAccountInfoEntity) =>
      PaymentAccountInfoViewModel(
        accountHolderName: paymentAccountInfoEntity.accountHolderName,
        accountHolderDocumentNumber:
            paymentAccountInfoEntity.accountHolderDocumentNumber,
        bankName: paymentAccountInfoEntity.bankName,
        bankCode: paymentAccountInfoEntity.bankCode,
        branchCode: paymentAccountInfoEntity.branchCode,
        accountNumber: paymentAccountInfoEntity.accountNumber,
      );
}
