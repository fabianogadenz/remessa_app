import 'package:flutter/material.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_appbar/checkout_appbar_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_confirmation/checkout_confirmation_widget.dart';
import 'package:remessa_app/v2/modules/transaction/view/widgets/checkout_tax_details/checkout_tax_details_widget.dart';

class CheckoutConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CheckoutAppBar(
        title: 'Confirmação da remessa',
        currentStep: 1,
        steps: 4,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              CheckoutTaxDetailsWidget(),
              SizedBox(height: 24),
              CheckoutConfirmationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
