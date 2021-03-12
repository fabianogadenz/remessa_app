import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules/payment_rules_widget.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutPaymentRulesScreen extends StatelessWidget {
  final bool isProgressive;

  const CheckoutPaymentRulesScreen({
    Key key,
    this.isProgressive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccentAppBarWidget(
        title: 'Regras de pagamento',
        currentStep: 2,
        steps: 4,
        isProgressive: isProgressive,
      ),
      backgroundColor: StyleColors.SUPPORT_NEUTRAL_10,
      body: PaymentRulesWidget(
        title: 'Antes de fazer o pagamento, confira as regras',
        paymentRules: [
          PaymentRulesViewModel(
            icon: RemessaIcons.deadline,
            value:
                'Você tem até as 16h30 do dia 13/06 para realizar o pagamento via TED.',
            hasDivider: true,
          ),
          PaymentRulesViewModel(
            icon: RemessaIcons.owner,
            value:
                'A TED deve ser enviada de uma conta bancária de pessoa física em que você é o titular. Se for uma conta conjunta, <a href="https://google.com">comprove sua titularidade no site.</a>',
            hasDivider: true,
          ),
          PaymentRulesViewModel(
            icon: RemessaIcons.attention_oval_outline,
            value:
                'Caso o pagamento não seja identificado dentro do prazo ou seja feito por outro meio que não seja TED, sua remessa será cancelada.',
            hasDivider: false,
            isWarning: true,
          ),
        ],
        action: isProgressive
            ? ac.Action(
                name: 'Aceito as regras de pagamento',
                actionFunction: () {
                  GetIt.I<NavigatorHelper>().pushNamed(
                    AppRouter.CHECKOUT_PAYMENT_DATA,
                    // arguments: TransactionDetailsScreenArgs(
                    //   transactionId: transaction.id,
                    // ),
                  );
                },
              )
            : null,
      ),
    );
  }
}
