import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/tax_details_row_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/tax_details_spotlight_row_widget.dart';

class TaxDetailsColumnSectionWidget extends StatelessWidget {
  const TaxDetailsColumnSectionWidget({
    Key key,
    this.spotlightRow,
    this.items,
  }) : super(key: key);

  final TaxDetailsSpotlightRowWidget spotlightRow;
  final List<TaxDetailsRowWidget> items;

  EdgeInsets _handleEdgeInsets() =>
      (spotlightRow != null) ? EdgeInsets.only(top: 12) : EdgeInsets.all(0);

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
            color: StyleColors.BRAND_PRIMARY_50,
          ),
        ),
      ),
      child: Column(
        children: _items,
      ),
    );
  }
}
