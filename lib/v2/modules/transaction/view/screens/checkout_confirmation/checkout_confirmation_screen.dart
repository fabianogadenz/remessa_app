import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/v2/modules/transaction/application/presenters/transaction_presenter.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_confirmation/checkout_confirmation_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/checkout_tax_details_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screens.dart';

class CheckoutConfirmationScreen extends StatefulWidget {
  final TransactionPresenter transactionPresenter;

  const CheckoutConfirmationScreen(
      {Key key, @required this.transactionPresenter})
      : assert(transactionPresenter != null),
        super(key: key);

  @override
  _CheckoutConfirmationScreenState createState() =>
      _CheckoutConfirmationScreenState();
}

class _CheckoutConfirmationScreenState
    extends State<CheckoutConfirmationScreen> {
  TransactionPresenter get _transactionPresenter => widget.transactionPresenter;
  ReactionDisposer reactionDisposer;

  @override
  void initState() {
    reactionDisposer = reaction(
        (_) => _transactionPresenter.confirmationSuccess, (bool success) {
      if (success) {
        GetIt.I<NavigatorHelper>().pushNamed(AppRouter.CHECKOUT_PAYMENT_DATA);
      }
    });

    _transactionPresenter.setErrorMessage('');

    super.initState();
  }

  @override
  void dispose() {
    _transactionPresenter.setErrorMessage('');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => GetIt.I<Screens>().widget(
        appBarWidget: CheckoutAppBar(
          title:
              GetIt.I<I18n>().trans('checkout', ['transaction_confirmation']),
          currentStep: 1,
          steps: 3,
        ),
        safeAreaConfig: SafeAreaConfig(bottom: false),
        showAppBar: true,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Column(
              children: [
                CheckoutTaxDetailsWidget(
                  transaction: _transactionPresenter.transaction,
                ),
                SizedBox(height: 24),
                CheckoutConfirmationWidget(
                  transaction: _transactionPresenter.transaction,
                  confirmTransaction: () =>
                      _transactionPresenter.confirmTransaction(context),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      )
        ..errorStreamController.add(_transactionPresenter.errorMessage)
        ..loaderStreamController.add(_transactionPresenter.isLoading),
    );
  }
}
