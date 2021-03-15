import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/handlers/show_warning_modal_handler.dart';
import 'package:remessa_app/v2/core/models/label_value_model.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/copiable_data_section/copiable_data_section_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules_toggle/payment_rules_toggle_widget.dart';
import 'package:remessa_app/v2/core/widgets/accent_app_bar_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutPaymentDataScreen extends StatelessWidget {
  final show = ShowWarningModalHandler(
    title: 'Tudo bem! Enviamos um\ne-mail com as informações',
    content:
        'E não esqueça: o pagamento deve ser feito até as 16h30 do dia 13/06 para garantir o câmbio da sua remessa.',
    imageURL:
        'https://cdn.zeplin.io/5e43195007ed419040a52c48/assets/4e31f39b-566d-4c49-8b4c-51b0889f3a46.png',
    isDismissible: true,
    primaryAction: ac.Action(
      name: 'Ok, ir para Remessas',
      actionFunction: () => GetIt.I<NavigatorHelper>().pushNamedAndRemoveUntil(
        AppRouter.DASHBOARD_ROUTE,
      ),
    ),
  );

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
                            'A TED deve ser enviada de uma conta bancária de pessoa física em que você é o titular. Se for uma conta conjunta, <a>comprove sua titularidade no site.</a>',
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
                  ),
                  SizedBox(height: 24),
                  CopyableDataSectionWidget(
                    title: 'Dados bancários para enviar a TED',
                    data: [
                      LabelValueModel(
                        label: 'Valor',
                        value: 'R\$ 5.143,22',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'Banco',
                        value: 'Banco Máxima (243)',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'Agência',
                        value: '0001',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'Conta corrente',
                        value: '4990501-7',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'Favorecido',
                        value: 'Banco Maxima SA',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'CNPJ',
                        value: '07.679.404/0001-00',
                        isCopiable: true,
                      ),
                      LabelValueModel(
                        label: 'Tipo de conta',
                        value: 'Conta Corrente',
                      ),
                      LabelValueModel(
                        label: 'Finalidade da TED',
                        value: 'Crédito em Conta Corrente',
                        hasDivider: false,
                      ),
                    ],
                    action: ac.Action(
                      name: 'Já fiz o pagamento',
                      actionFunction: () {
                        GetIt.I<NavigatorHelper>().pushNamed(
                          AppRouter.CHECKOUT_SUCCESS,
                          // arguments: TransactionDetailsScreenArgs(
                          //   transactionId: transaction.id,
                          // ),
                        );
                      },
                    ),
                    secondaryAction: ac.Action(
                      name: 'Vou pagar depois',
                      actionFunction: () => show(context),
                    ),
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
