import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules/rule_section_widget.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';

class PaymentRulesWidget extends StatelessWidget {
  final List<PaymentRulesViewModel> paymentRules;
  final String title;
  final bool isDarkMode;
  final ac.Action action;

  const PaymentRulesWidget({
    Key key,
    @required this.paymentRules,
    this.title,
    this.action,
    this.isDarkMode = false,
  }) : super(key: key);

  bool get _hasTitle => title != null && title.isNotEmpty;

  _handleTitle() => _hasTitle
      ? Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: StyleColors.BRAND_SECONDARY_60,
              ),
            ),
            SizedBox(height: 8),
          ],
        )
      : Container();

  _handleAction() => action != null
      ? Column(
          children: [
            SizedBox(height: 8),
            GradientButtonWidget(
              label: action.name,
              onPressed: action.action,
            ),
          ],
        )
      : Container();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _handleTitle(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: paymentRules
                    .map(
                      (rule) => RuleSectionWidget(
                        icon: rule.icon,
                        value: rule.value,
                        hasDivider: rule.hasDivider,
                        isDarkMode: isDarkMode,
                        isWarning: rule.isWarning,
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          _handleAction()
        ],
      ),
    );
  }
}
