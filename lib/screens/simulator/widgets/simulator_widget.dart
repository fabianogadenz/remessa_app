import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/modal_helper.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/error_response_model.dart';
import 'package:remessa_app/models/responses/simulator_response_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/screens/simulator/simulator_screen_animation_store.dart';
import 'package:remessa_app/screens/simulator/widgets/custom_currency_input_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/exchange_rate_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/icon_label_text_cta_widget.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/gradient_button_widget.dart';

class SimulatorWidget extends StatefulWidget {
  const SimulatorWidget({
    Key key,
    this.isScrollDisabled = false,
    this.isLoading = false,
    @required this.controller,
    @required this.simulatorStore,
    @required this.refreshFunction,
    this.simulatorResponse,
    this.simulatorScreenAnimationStore,
  })  : assert(refreshFunction != null),
        assert(simulatorStore != null),
        assert(controller != null),
        super(key: key);

  final bool isScrollDisabled;
  final bool isLoading;
  final SimulatorScreenAnimationStore simulatorScreenAnimationStore;
  final ScrollController controller;
  final Function refreshFunction;
  final SimulatorResponseModel simulatorResponse;
  final SimulatorStore simulatorStore;

  @override
  _SimulatorWidgetState createState() => _SimulatorWidgetState();
}

class _SimulatorWidgetState extends State<SimulatorWidget> {
  final i18n = GetIt.I<I18n>();
  final brlCurrencyCtrl = MoneyMaskedTextController();
  final foreignCurrencyCtrl = MoneyMaskedTextController();
  final _formKey = GlobalKey<FormState>();

  SimulatorStore get simulatorStore => widget.simulatorStore;
  ReactionDisposer reactionDisposer;

  void redirect(String url, {String description, Note note}) {
    GetIt.I<NavigatorHelper>().pushNamed(
      Router.WEBSITE_REDIRECT_ROUTE,
      arguments: WebsiteRedirectScreenArgs(
        url: url,
        description: description,
        note: note,
      ),
    );
  }

  ErrorResponseModel _getFieldError(String fieldName) {
    if (simulatorStore?.fieldErrors == null) return null;

    try {
      return (simulatorStore?.fieldErrors ?? [])
          .firstWhere((err) => err?.field == fieldName, orElse: null);
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    reactionDisposer = autorun(
      (_) {
        final response = simulatorStore?.simulatorResponse;

        if (response == null) return;

        final brlValue = response.quote.nationalCurrencyTotalAmount;
        final foreignValue = response.quote.foreignCurrencyAmount;

        if (brlValue != brlCurrencyCtrl.numberValue)
          brlCurrencyCtrl.updateValue(brlValue ?? 0);

        if (foreignValue != foreignCurrencyCtrl.numberValue)
          foreignCurrencyCtrl.updateValue(foreignValue ?? 0);
      },
    );

    super.initState();
  }

  @override
  void dispose() {
    reactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final beneficiaryFirstName =
        simulatorStore?.beneficiary?.beneficiaryName != null
            ? simulatorStore?.beneficiary?.beneficiaryName?.split(' ')[0] ??
                'Beneficiário'
            : 'Beneficiário';

    final currency = widget.simulatorResponse?.currency;

    return Observer(
      builder: (_) {
        return AbsorbPointer(
          absorbing: widget.isLoading ||
              (widget?.simulatorScreenAnimationStore?.isExpanded ?? false),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: StyleColors.BRAND_PRIMARY_80,
                  blurRadius: 30,
                ),
              ],
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            child: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  controller: widget.controller,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      widget.isScrollDisabled
                          ? SizedBox(height: 4)
                          : Container(
                              height: 4,
                              width: 60,
                              decoration: BoxDecoration(
                                color: StyleColors.SUPPORT_NEUTRAL_30,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            children: <Widget>[
                              CustomCurrencyInputWidget(
                                controller: brlCurrencyCtrl,
                                label: 'Você envia',
                                currencyAcronym: 'BRL',
                                isLoading: widget.isLoading,
                                errorMessage:
                                    _getFieldError('BRL_VALUE')?.message,
                                onChanged: (_) {
                                  final response =
                                      simulatorStore?.simulatorResponse;

                                  if (!(response is SimulatorResponseModel))
                                    return;

                                  if (brlCurrencyCtrl.numberValue !=
                                          response.quote
                                              .nationalCurrencyTotalAmount ||
                                      brlCurrencyCtrl.numberValue !=
                                          simulatorStore.totalValue) {
                                    simulatorStore.setTotalValue(
                                        brlCurrencyCtrl.numberValue);
                                    widget.refreshFunction();
                                  }
                                },
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              CustomCurrencyInputWidget(
                                controller: foreignCurrencyCtrl,
                                label: '$beneficiaryFirstName recebe',
                                currencyImgUrl: currency?.flagUrl ?? '',
                                currencyAcronym: currency?.abbreviation ?? '',
                                isChangeable:
                                    simulatorStore?.beneficiary?.currency ==
                                        null,
                                changeableCallback: () {
                                  TrackEvents.log(
                                    TrackEvents.SIMULATOR_CHANGE_CURRENCY_CLICK,
                                    {
                                      'currency': currency?.abbreviation,
                                    },
                                  );
                                  ModalHelper.showCurrencySelectionBottomSheet(
                                    context,
                                    simulatorStore,
                                  );
                                },
                                isLoading: widget.isLoading,
                                errorMessage:
                                    _getFieldError('FOREIGN_VALUE')?.message,
                                onChanged: (_) {
                                  final response =
                                      simulatorStore?.simulatorResponse;

                                  if (!(response is SimulatorResponseModel))
                                    return;

                                  if (foreignCurrencyCtrl.numberValue !=
                                          response
                                              .quote.foreignCurrencyAmount &&
                                      foreignCurrencyCtrl.numberValue !=
                                          simulatorStore.quantity) {
                                    simulatorStore.setQuantity(
                                        foreignCurrencyCtrl.numberValue);
                                    widget.refreshFunction();
                                  }
                                },
                              ),
                              SizedBox(
                                height: 24,
                              ),
                              ExchangeRateWidget(
                                isLoading: widget.isLoading,
                                timerCallback: widget.refreshFunction,
                                simulatorStore: simulatorStore,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              IconLabelTextCTAWidget(
                                icon: RemessaIcons.percent,
                                label: 'Tem um desconto?',
                                text: 'Simule ou insira um cupom aqui',
                                isLoading: widget.isLoading,
                                onTap: () {
                                  TrackEvents.log(
                                      TrackEvents.SIMULATOR_ADD_COUPON_CLICK);
                                  redirect(simulatorStore
                                      ?.simulatorResponse?.redirectUrl);
                                },
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              IconLabelTextCTAWidget(
                                icon: RemessaIcons.graph,
                                label: 'Acompanhe a evolução da moeda',
                                text:
                                    'Ver o gráfico de ${currency?.abbreviation}',
                                isLoading: widget.isLoading,
                                onTap: () {
                                  TrackEvents.log(
                                      TrackEvents.SIMULATOR_FOLLOW_UP_CLICK);
                                  redirect(
                                      widget.simulatorResponse?.quotationUrl ??
                                          '');
                                },
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 270,
                  bottom: 24,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: GradientButtonWidget(
                        height: 48,
                        width: MediaQuery.of(context).size.width - 48,
                        isDisabled: widget.isLoading,
                        label: 'Enviar remessa',
                        onPressed: () {
                          TrackEvents.log(TrackEvents.SIMULATOR_SIMULATE_CLICK);
                          redirect(
                            simulatorStore?.simulatorResponse?.redirectUrl,
                            description: i18n.trans(
                              'website_redirect_screen',
                              ['description', 'recurrence'],
                            ),
                            note: Note(
                              title: 'Sua cotação pode ser atualizada',
                              description:
                                  'Confira o valor final na confirmação da remessa.',
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
