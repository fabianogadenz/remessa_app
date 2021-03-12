import 'package:flutter/material.dart';
import 'package:remessa_app/helpers/transaction_status.dart';

class TransactionStatusWidget extends StatelessWidget {
  const TransactionStatusWidget({
    Key key,
    @required this.status,
    @required this.statusName,
  })  : assert(status != null),
        assert(statusName != null),
        super(key: key);

  final TransactionStatus status;
  final String statusName;

  @override
  Widget build(BuildContext context) {
    final statusColor = TransactionStatusHelper.getColor(status);

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: statusColor.item1,
      ),
      child: Text(
        statusName.toUpperCase(),
        style: TextStyle(
          color: statusColor.item2,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
