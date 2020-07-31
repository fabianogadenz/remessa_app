import 'package:flutter/material.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_selection_widget.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/widgets/info_widget.dart';

class ModalHelper {
  static void showInfoBottomSheet(
          BuildContext context, String title, String description,
          [Icon icon]) =>
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => InfoWidget(
          title: title,
          description: description,
          icon: icon,
        ),
      );

  static void showCurrencySelectionBottomSheet(
      BuildContext context, SimulatorStore simulatorStore) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => CurrencySelectionWidget(
        simulatorStore: simulatorStore,
      ),
    );
  }
}
