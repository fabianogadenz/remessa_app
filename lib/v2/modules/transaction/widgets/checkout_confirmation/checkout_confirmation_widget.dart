import 'package:flutter/material.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/widgets/checkout_confirmation/checkout_confirmation_section_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutConfirmationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: StyleColors.SUPPORT_SHADOW_60.withOpacity(0.25),
            spreadRadius: 0,
            blurRadius: 10,
          ),
          BoxShadow(
            color: StyleColors.SUPPORT_SHADOW_50.withOpacity(0.2),
            spreadRadius: 8,
            blurRadius: 24,
            offset: Offset(1, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.user,
            title: 'Beneficiário',
            subTitle: 'Reinaldo Antunes',
            value: 'Bank of New York',
            linkAction: ac.Action(name: 'Ver dados'),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.deadline,
            title: 'Prazo do pagamento da TED',
            subTitle: 'Até as 16h30 do dia 13/06/2020',
            linkAction: ac.Action(
                name: 'Ver regras', actionFunction: () => print('msksksk')),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.calendar,
            title: 'Estimativa de chegada',
            subTitle: 'Em até 1 dia útil após a identificação do pagamento ',
            action: ac.Action(name: 'Confirmar remessa'),
          ),
        ],
      ),
    );
  }
}
