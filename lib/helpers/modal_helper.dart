import 'package:flutter/material.dart';
import 'package:remessa_app/actions/link_action.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_selection_widget.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/info_widget.dart';

class ModalHelper {
  static void showInfoBottomSheet(
          BuildContext context, String title, String description,
          [Icon icon, LinkAction linkAction]) =>
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => InfoWidget(
          title: title,
          description: description,
          icon: icon,
          footer: linkAction != null
              ? GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: linkAction.action,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Text(
                      linkAction.name,
                      style: TextStyle(
                        color: StyleColors.SUPPORT_NEUTRAL_10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              : Container(),
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
