import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';

class BeneficiaryDataSectionWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool hasDivider;

  const BeneficiaryDataSectionWidget({
    Key key,
    @required this.label,
    @required this.value,
    this.hasDivider = true,
  })  : assert(label != null),
        assert(value != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: hasDivider
            ? Border(
                bottom: BorderSide(
                  color: StyleColors.SUPPORT_NEUTRAL_30,
                ),
              )
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                color: StyleColors.BRAND_SECONDARY_60,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: StyleColors.BRAND_SECONDARY_50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
