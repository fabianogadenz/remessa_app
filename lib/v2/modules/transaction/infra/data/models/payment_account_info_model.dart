import 'package:remessa_app/v2/modules/transaction/domain/entities/payment_account_info.dart';

class PaymentAccountInfoModel implements PaymentAccountInfoEntity {
  @override
  String accountHolderDocumentNumber;
  @override
  String accountHolderName;
  @override
  String accountNumber;
  @override
  String bankCode;
  @override
  String bankName;
  @override
  String branchCode;

  PaymentAccountInfoModel.fromJson(Map<String, dynamic> json) {
    accountHolderDocumentNumber = json['accountHolderDocumentNumber'];
    accountHolderName = json['accountHolderName'];
    accountNumber = json['accountNumber'];
    bankCode = json['bankCode'];
    bankName = json['bankName'];
    branchCode = json['branchCode'];
  }
}
