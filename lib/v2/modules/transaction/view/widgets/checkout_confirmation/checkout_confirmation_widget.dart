import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/account_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/intermediary_bank_info_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_beneficiary_data/checkout_beneficiary_data_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_rules/checkout_payment_rules_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_confirmation/checkout_confirmation_section_widget.dart';
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
            linkAction: ac.Action(
              name: 'Ver dados',
              actionFunction: () {
                GetIt.I<NavigatorHelper>().pushNamed(
                  AppRouter.CHECKOUT_BENEFICIARY_DATA,
                  arguments: CheckoutBeneficiaryDataScreenArgs(
                    // TODO: Remove beneficiary mock
                    beneficiary: BeneficiaryViewModel(
                      name: 'Reinaldo Antunes',
                      bankName: 'Bank of New York',
                      country: 'Estados Unidos',
                      accountInfo: [
                        AccountInfoViewModel(
                          label: 'Campo dinâmico Account Info',
                          value: '1',
                        ),
                      ],
                      intermediaryBankInfo: [
                        IntermediaryBankInfoViewModel(
                          label: 'Campo dinâmico Intermediary Bank Info',
                          value: '2',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.deadline,
            title: 'Prazo do pagamento da TED',
            subTitle: 'Até as 16h30 do dia 13/06/2020',
            linkAction: ac.Action(
              name: 'Ver regras',
              actionFunction: () {
                GetIt.I<NavigatorHelper>().pushNamed(
                  AppRouter.CHECKOUT_PAYMENT_RULES,
                );
              },
            ),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.calendar,
            title: 'Estimativa de chegada',
            subTitle: 'Em até 1 dia útil após a identificação do pagamento ',
            action: ac.Action(
              name: 'Confirmar remessa',
              actionFunction: () {
                GetIt.I<NavigatorHelper>().pushNamed(
                  AppRouter.CHECKOUT_PAYMENT_RULES,
                  arguments: CheckoutPaymentRulesScreenArgs(
                    isProgressive: true,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
