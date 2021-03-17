import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules/rule_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules_toggle/payment_rules_toggle_header_widget.dart';

class PaymentRulesToggleWidget extends StatefulWidget {
  final List<PaymentRulesViewModel> paymentRules;

  const PaymentRulesToggleWidget({
    Key key,
    @required this.paymentRules,
  }) : super(key: key);

  @override
  _PaymentRulesToggleWidgetState createState() =>
      _PaymentRulesToggleWidgetState();
}

class _PaymentRulesToggleWidgetState extends State<PaymentRulesToggleWidget> {
  bool isExpanded = false;

  _toggle() {
    if (!isExpanded) {
      TrackingEvents.log(TrackingEvents.CHECKOUT_VIEW_TRANSFER_RULES_CLICK);
    }

    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggle,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: StyleColors.BRAND_PRIMARY_50,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 300),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstCurve: Curves.easeIn,
          secondCurve: Curves.ease,
          firstChild: isExpanded
              ? Container()
              : PaymentRulesToggleHeaderWidget(
                  text: 'Ver regras da transferência',
                  iconData: RemessaIcons.arrow_down,
                ),
          secondChild: isExpanded
              ? Column(
                  children: [
                    PaymentRulesToggleHeaderWidget(
                      text: 'Esconder regras da transferência',
                      iconData: RemessaIcons.arrow_up,
                    ),
                    ...widget.paymentRules
                        .map(
                          (rule) => RuleSectionWidget(
                            icon: rule.icon,
                            value: rule.value,
                            hasDivider: rule.hasDivider,
                            isDarkMode: true,
                            isWarning: rule.isWarning,
                          ),
                        )
                        .toList(),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
