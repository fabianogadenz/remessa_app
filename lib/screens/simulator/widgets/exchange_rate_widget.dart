import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/currency_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/v2/core/tracking/tracking_events.dart';
import 'package:remessa_app/models/responses/simulator_response_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen_args.dart';
import 'package:remessa_app/stores/quote_store.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/stores/timer_animation_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/core/widgets/skeleton_line_widget.dart';
import 'package:remessa_app/v2/core/widgets/timer_widget.dart';

class ExchangeRateWidget extends StatefulWidget {
  const ExchangeRateWidget({
    Key key,
    this.isLoading = false,
    @required this.timerCallback,
    @required this.simulatorStore,
  })  : assert(timerCallback != null),
        assert(simulatorStore != null),
        super(key: key);

  final bool isLoading;
  final SimulatorStore simulatorStore;
  final Function timerCallback;

  @override
  _ExchangeRateWidgetState createState() => _ExchangeRateWidgetState();
}

class _ExchangeRateWidgetState extends State<ExchangeRateWidget> {
  final i18n = GetIt.I<I18n>();
  final timerAnimationStore = GetIt.I<TimerAnimationStore>();
  final QuoteStore quoteStore = QuoteStore();
  ReactionDisposer _reactionDisposer;

  @override
  void initState() {
    super.initState();

    _reactionDisposer = reaction(
      (_) => widget?.simulatorStore?.simulatorResponse,
      (SimulatorResponseModel simulatorResponseModel) =>
          quoteStore.setQuote(simulatorResponseModel?.quote),
    );

    timerAnimationStore.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        timerAnimationStore.setDisableCounter(true);
        widget.timerCallback();
        timerAnimationStore.controller.reverse();
      }

      if (status == AnimationStatus.dismissed) {
        timerAnimationStore.setDisableCounter(false);
        timerAnimationStore.controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        TrackingEvents.log(TrackingEvents.SIMULATOR_TAXES_CLICK);
        quoteStore.setQuote(widget.simulatorStore?.simulatorResponse?.quote);
        GetIt.I<NavigatorHelper>().pushNamed(
          AppRouter.SIMULATOR_CALCULATION_ROUTE,
          arguments: TransactionCalculationScreenArgs(
            quoteStore: quoteStore,
            beneficiaryName:
                widget.simulatorStore?.beneficiary?.beneficiaryName,
            showTimer: true,
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: StyleColors.BRAND_SECONDARY_10.withOpacity(.3),
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(12),
        child: widget.isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: SkeletonLineWidget(
                  color: StyleColors.BRAND_SECONDARY_10,
                  width: MediaQuery.of(context).size.width,
                  height: 11,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 25,
                    height: 25,
                    child: TimerWidget(),
                  ),
                  Observer(builder: (_) {
                    final quote =
                        widget.simulatorStore?.simulatorResponse?.quote;
                    quoteStore.setQuote(quote);

                    final vet = CurrencyHelper.format(
                        quote?.vet?.toString() ?? '0',
                        CurrencyHelper.currencyFormat + '00');

                    if (quote?.vet == quote?.originalVet) {
                      return Text(
                        i18n.populate(
                          i18n.trans('simulator_screen', ['exchange_rate']),
                          {'vet': vet},
                        ),
                        style: TextStyle(
                          color: StyleColors.BRAND_SECONDARY_50,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }

                    final originalVet = CurrencyHelper.format(
                        quote?.originalVet?.toString() ?? '0',
                        CurrencyHelper.currencyFormat + '00');

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          i18n.trans('simulator_screen',
                              ['exchange_rate_with_coupon']),
                          style: TextStyle(
                            color: StyleColors.BRAND_SECONDARY_50,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${i18n.trans("simulator_screen", [
                                "local_currency_field",
                                "currency_acronym"
                              ])} $originalVet',
                              style: TextStyle(
                                color: StyleColors.BRAND_SECONDARY_30,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              '${i18n.trans("simulator_screen", [
                                "local_currency_field",
                                "currency_acronym"
                              ])} $vet',
                              style: TextStyle(
                                color: StyleColors.BRAND_SECONDARY_50,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }),
                  Row(
                    children: <Widget>[
                      Text(
                        i18n.trans('fees'),
                        style: TextStyle(
                          color: StyleColors.BRAND_PRIMARY_40,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: StyleColors.BRAND_PRIMARY_40,
                          size: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}
