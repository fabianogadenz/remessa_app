import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_account_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';

class ConfirmatedTransactionViewModel {
  final TransactionViewModel transaction;
  final PaymentAccountInfoViewModel paymentAccountInfo;

  ConfirmatedTransactionViewModel({
    this.transaction,
    this.paymentAccountInfo,
  });

  factory ConfirmatedTransactionViewModel.parse(
          PaymentAccountInfoEntity paymentAccountInfoEntity,
          TransactionViewModel transactionViewModel) =>
      ConfirmatedTransactionViewModel(
        transaction: transactionViewModel,
        paymentAccountInfo:
            PaymentAccountInfoViewModel.fromEntity(paymentAccountInfoEntity),
      );
}
