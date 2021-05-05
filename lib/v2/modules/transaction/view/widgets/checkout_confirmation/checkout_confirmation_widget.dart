import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/date_helper.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/beneficiary_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/application/viewmodels/transaction_viewmodel.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_beneficiary_data/checkout_beneficiary_data_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_rules/checkout_payment_rules_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_confirmation/checkout_confirmation_section_widget.dart';
import 'package:remessa_app/v2/core/actions/action.dart' as ac;

class CheckoutConfirmationWidget extends StatelessWidget {
  final Function confirmTransaction;
  final TransactionViewModel transaction;

  CheckoutConfirmationWidget({
    Key key,
    @required this.confirmTransaction,
    @required this.transaction,
  })  : assert(confirmTransaction != null),
        assert(transaction != null),
        super(key: key);

  final i18n = GetIt.I<I18n>();

  BeneficiaryViewModel get beneficiary => transaction.beneficiary;

  @override
  Widget build(BuildContext context) {
    final paymentDeadLineDate =
        DateHelper.stringToDate(transaction.paymentDeadline);

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
            title: i18n.trans('simulator_screen', ['beneficiary']),
            subTitle: beneficiary.name,
            value: beneficiary.bankName,
            linkAction: ac.Action(
              name: i18n.trans('view_data'),
              actionFunction: () {
                TrackingEvents.log(
                    TrackingEvents.CHECKOUT_VIEW_BENEFICIARY_DETAILS_CLICK);

                GetIt.I<NavigatorHelper>().pushNamed(
                  AppRouter.CHECKOUT_BENEFICIARY_DATA,
                  arguments: CheckoutBeneficiaryDataScreenArgs(
                    beneficiary: beneficiary,
                  ),
                );
              },
            ),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.deadline,
            title: i18n
                .trans('checkout', ['payment_rules', 'ted_deadline', 'title']),
            subTitle: i18n.populate(
              i18n.trans(
                  'checkout', ['payment_rules', 'ted_deadline', 'subtitle']),
              {
                'paymentDeadlineHour':
                    GetIt.I<AppStore>().configs.paymentDeadlineHour,
                'paymentDeadLineDate':
                    DateHelper.formatToBRLong(paymentDeadLineDate),
              },
            ),
            linkAction: ac.Action(
              name: i18n.trans('view_rules'),
              actionFunction: () {
                TrackingEvents.log(
                    TrackingEvents.CHECKOUT_VIEW_PAYMENT_RULES_CLICK);

                GetIt.I<NavigatorHelper>().pushNamed(
                  AppRouter.CHECKOUT_PAYMENT_RULES,
                  arguments: CheckoutPaymentRulesScreenArgs(
                    isProgressive: false,
                    paymentDeadLineDate:
                        DateHelper.formatToBRShort(paymentDeadLineDate),
                  ),
                );
              },
            ),
          ),
          CheckoutConfirmationSectionWidget(
            icon: RemessaIcons.calendar,
            title: i18n.trans('checkout', ['arrival_estimate', 'title']),
            subTitle: i18n.populate(
              i18n.trans('checkout', ['arrival_estimate', 'subtitle']),
              {
                'arrivalEstimate': transaction.arrivalEstimate,
              },
            ),
            action: ac.Action(
              name: i18n.trans('checkout', ['confirm_transaction']),
              actionFunction: () async {
                TrackingEvents.log(
                    TrackingEvents.CHECKOUT_CONFIRM_OPERATION_CLICK);

                await confirmTransaction();
              },
            ),
          ),
        ],
      ),
    );
  }
}
