import 'package:flutter/material.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/promotional_card_widget.dart';
import 'package:remessa_app/widgets/accent_app_bar_widget.dart';
import 'package:remessa_app/widgets/outline_button_widget.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccentAppBarWidget(
        title: 'Remessa em andamento',
        steps: 4,
        currentStep: 4,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                './images/sucess_illlustration.png',
                height: 240,
                alignment: Alignment.centerLeft,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24) +
                  const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  Text(
                    'Tudo certo! Agora, aguarde a identificação do pagamento',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'A maioria dos pagamentos via TED é identificada em aproximadamente 2 horas úteis. Em seguida, vamos enviar uma notificação pelo app com a confirmação do recebimento.',
                    style: TextStyle(
                      color: StyleColors.SUPPORT_NEUTRAL_10,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),
                  PromotionalCardWidget(),
                  SizedBox(height: 32),
                  OutlineButtonWidget(
                    label: 'Ir para Envios',
                    isAccent: true,
                    onPressed: () {},
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
