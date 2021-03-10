import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/copiable_data_section/copiable_data_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules_toggle/payment_rules_toggle_widget.dart';
import 'package:remessa_app/widgets/accent_app_bar_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutPaymentDataScreen extends StatelessWidget {
  final List<PaymentRulesViewModel> paymentRules;
  final List<LabelValueModel> data;

  const CheckoutPaymentDataScreen({
    Key key,
    @required this.paymentRules,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccentAppBarWidget(
        title: 'Dados para pagamento',
        steps: 4,
        currentStep: 3,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24) +
                  const EdgeInsets.only(bottom: 24, top: 32),
              child: Column(
                children: [
                  Text(
                    'Faça uma TED para confirmar sua remessa',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                    ),
                  ),
                  SizedBox(height: 32),
                  PaymentRulesToggleWidget(
                    paymentRules: paymentRules,
                  ),
                  SizedBox(height: 24),
                  CopyableDataSectionWidget(
                    title: 'Dados bancários para enviar a TED',
                    data: data,
                    action: ac.Action(name: 'Já fiz o pagamento'),
                    secondaryAction: ac.Action(name: 'Vou pagar depois '),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
