import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/currency_model.dart';
import 'package:remessa_app/models/responses/simulator_default_values_response_model.dart';
import 'package:remessa_app/screens/simulator/widgets/currency_item_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/list_section_label_widget.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/close_button_widget.dart';
import 'package:screens/overlay_widget.dart';

class CurrencySelectionWidget extends StatelessWidget {
  CurrencySelectionWidget({
    Key key,
    @required this.simulatorStore,
  })  : assert(simulatorStore != null),
        super(key: key);

  final SimulatorStore simulatorStore;
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();
  Currencies get currencies => simulatorStore?.currencies;

  CurrencyItemWidget _mapCurrency(currency) => CurrencyItemWidget(
        currencyImageUrl: currency.flagUrl,
        currencyName: currency.name,
        currencyAcronym: currency.abbreviation,
        onTap: () {
          TrackEvents.log(
            TrackEvents.SIMULATOR_SELECT_CURRENCY_CLICK,
            {
              'currency': currency?.abbreviation,
            },
          );

          simulatorStore.getDefaultValues(
            currency: Currency(
              id: currency.id,
              abbreviation: currency.abbreviation,
            ),
          );

          navigator.pop();
        },
      );

  Widget _buildCurrencyList(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 65,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListSectionLabelWidget(
                i18n.trans(
                  'simulator_screen',
                  ['currency_selection', 'most_useds'],
                ),
              ),
              ...(currencies?.mostUseds ?? []).map(_mapCurrency).toList(),
              ListSectionLabelWidget(
                i18n.trans(
                  'simulator_screen',
                  ['currency_selection', 'others'],
                ),
              ),
              ...(currencies?.others ?? []).map(_mapCurrency).toList(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final header = Container(
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 8,
          ),
          Container(
            height: 4,
            width: 60,
            decoration: BoxDecoration(
              color: StyleColors.SUPPORT_NEUTRAL_30,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  i18n.trans(
                    'simulator_screen',
                    ['currency_selection', 'title'],
                  ),
                  style: TextStyle(
                    color: StyleColors.BRAND_PRIMARY_80,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                CloseButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );

    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: BoxDecoration(
        color: StyleColors.SUPPORT_NEUTRAL_10,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15),
        ),
      ),
      child: OverlayWidget(
        _buildCurrencyList(context),
        fixedOverlayWidgets: <Widget>[header],
        loaderWidget: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                StyleColors.BRAND_PRIMARY_60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
