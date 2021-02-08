import 'package:meta/meta.dart';

class ConfirmTransactionCommand {
  final int transactionId;

  ConfirmTransactionCommand({
    @required this.transactionId,
  });
}
