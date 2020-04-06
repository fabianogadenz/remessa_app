import 'package:flutter/material.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_row_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_spotlight_row_widget.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCalculationColumnSectionWidget extends StatelessWidget {
  const TransactionCalculationColumnSectionWidget({
    Key key,
    @required this.spotlightRow,
    this.items,
  })  : assert(spotlightRow != null),
        super(key: key);

  final TransactionCalculationSpotlightRowWidget spotlightRow;
  final List<TransactionCalculationRowWidget> items;

  @override
  Widget build(BuildContext context) {
    final _items = <Widget>[];

    if (items != null) {
      _items.add(SizedBox(height: 12));
      _items.addAll(items);
    }

    return Container(
      margin: EdgeInsets.only(top: 12),
      padding: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: StyleColors.SUPPORT_NEUTRAL_30,
          ),
        ),
      ),
      child: Column(
        children: <Widget>[
          spotlightRow,
          ..._items,
        ],
      ),
    );
  }
}
