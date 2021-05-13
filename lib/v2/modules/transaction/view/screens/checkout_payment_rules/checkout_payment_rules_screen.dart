import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/chat_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/payment_rules_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/payment_rules/payment_rules_widget.dart';

class CheckoutPaymentRulesScreen extends StatelessWidget {
  final bool isProgressive;
  final String paymentDeadLineDate;

  const CheckoutPaymentRulesScreen({
    Key key,
    this.isProgressive = false,
    @required this.paymentDeadLineDate,
  })  : assert(paymentDeadLineDate != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(
        title: i18n.trans('checkout', ['payment_rules', 'title']),
        currentStep: 2,
        steps: 4,
        isProgressive: isProgressive,
      ),
      backgroundColor: StyleColors.SUPPORT_NEUTRAL_10,
      body: PaymentRulesWidget(
        title: i18n.trans('checkout', ['payment_rules', 'subtitle']),
        paymentRules: [
          PaymentRulesViewModel(
            icon: RemessaIcons.deadline,
            value: i18n.populate(
              i18n.trans('checkout', ['payment_rules', 'rules', '1']),
              {
                'paymentDeadlineHour':
                    GetIt.I<AppStore>().configs.paymentDeadlineHour,
                'paymentDeadLineDate': paymentDeadLineDate,
              },
            ),
            hasDivider: true,
          ),
          PaymentRulesViewModel(
            icon: RemessaIcons.owner,
            value: i18n.populate(
              i18n.trans('checkout', ['payment_rules', 'rules', '2']),
              {
                'trackEvent': TrackingEvents.CHECKOUT_PROVE_ACCOUNT_CLICK,
              },
            ),
            hasDivider: true,
          ),
          PaymentRulesViewModel(
            icon: RemessaIcons.attention_oval_outline,
            value: i18n.trans('checkout', ['payment_rules', 'rules', '3']),
            hasDivider: false,
            isWarning: true,
          ),
        ],
        // TODO: Uncomment isProgressive action
        // action: isProgressive
        //     ? ac.Action(
        //         name: 'Aceito as regras de pagamento',
        //         actionFunction: () {
        //           TrackingEvents.log(
        //               TrackingEvents.CHECKOUT_ACCEPT_PAYMENT_RULES_CLICK);

        //           GetIt.I<NavigatorHelper>().pushNamed(
        //             AppRouter.CHECKOUT_PAYMENT_DATA,
        //           );
        //         },
        //       )
        //     : null,
      ),
    );
  }
}
