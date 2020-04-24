import 'package:flutter/material.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_row_widget.dart';
import 'package:remessa_app/screens/transaction_details/widgets/transaction_calculation_spotlight_row_widget.dart';
import 'package:remessa_app/style/colors.dart';

class TransactionCalculationColumnSectionWidget extends StatelessWidget {
  const TransactionCalculationColumnSectionWidget({
    Key key,
    this.spotlightRow,
    this.items,
  }) : super(key: key);

  final TransactionCalculationSpotlightRowWidget spotlightRow;
  final List<TransactionCalculationRowWidget> items;

  EdgeInsets _handleEdgeInsets() => (spotlightRow != null)
      ? EdgeInsets.only(top: 12, bottom: 12)
      : EdgeInsets.all(0);

  @override
  Widget build(BuildContext context) {
    final _items = <Widget>[];

    if (spotlightRow != null) {
      _items.add(spotlightRow);
    }

    if (items != null) {
      if (spotlightRow != null) {
        _items.add(SizedBox(height: 12));
      }

      _items.addAll(items);
    }

    return Container(
      padding: _handleEdgeInsets(),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: StyleColors.SUPPORT_NEUTRAL_30,
          ),
        ),
      ),
      child: Column(
        children: _items,
      ),
    );
  }
}
