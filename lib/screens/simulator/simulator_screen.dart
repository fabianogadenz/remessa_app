import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/snowplow_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/models/utm_model.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/simulator/simulator_screen_animation_store.dart';
import 'package:remessa_app/screens/simulator/widgets/simulator_beneficiaries_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/simulator_header_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/simulator_widget.dart';
import 'package:remessa_app/stores/beneficiary_store.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/stores/timer_animation_store.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/v2/modules/transaction/application/presenters/transaction_presenter.dart';
import 'package:remessa_app/widgets/primary_button_widget.dart';
import 'package:screens/safe_area_config.dart';
import 'package:screens/screens.dart';

class SimulatorScreen extends StatefulWidget {
  final int preSelectedBeneficiaryId;
  final TransactionPresenter transactionPresenter;

  const SimulatorScreen({
    Key key,
    this.preSelectedBeneficiaryId,
    @required this.transactionPresenter,
  }) : super(key: key);

  @override
  _SimulatorScreenState createState() => _SimulatorScreenState();
}

class _SimulatorScreenState extends State<SimulatorScreen>
    with TickerProviderStateMixin, RouteAware {
  final navigator = GetIt.I<NavigatorHelper>();
  final i18n = GetIt.I<I18n>();

  final beneficiaryStore = BeneficiaryStore()..getBeneficiaries();
  final simulatorStore = SimulatorStore();

  final timerAnimationStore = GetIt.I<TimerAnimationStore>();
  final simulatorScreenAnimationStore = SimulatorScreenAnimationStore();

  int get _preSelectedBeneficiaryId => widget.preSelectedBeneficiaryId;

  Widget emptyState;

  _SimulatorScreenState() {
    emptyState = Container(
      width: 235,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('images/simulator_empty.png'),
          SizedBox(
            height: 26,
          ),
          Text(
            i18n.trans('simulator_screen', ['empty_state']),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: StyleColors.SUPPORT_NEUTRAL_10,
            ),
          ),
        ],
      ),
    );
  }

  final List<ReactionDisposer> reactionDesposers = [];

  simulate({bool disableLoad = false}) async {
    if (disableLoad) {
      return await simulatorStore.simulate();
    }

    await simulatorStore.getDefaultValues();
  }

  @override
  void initState() {
    super.initState();

    timerAnimationStore
      ..setController(
        AnimationController(
          vsync: this,
          duration: Duration(seconds: 60),
          reverseDuration: Duration(seconds: 1),
        ),
      )
      ..setTicker(this);

    reactionDesposers.addAll(
      [
        reaction(
          (_) => simulatorStore?.simulatorResponse,
          (_) {
            final controller = GetIt.I<TimerAnimationStore>().controller;

            controller.isAnimating
                ? controller.reverse()
                : controller.forward();
          },
        ),
        reaction(
          (_) => simulatorStore.beneficiary,
          (_) => simulate(),
        ),
        when(
          (_) =>
              beneficiaryStore?.beneficiaryResponseModel?.beneficiaries != null,
          () {
            final beneficiaries =
                beneficiaryStore.beneficiaryResponseModel.beneficiaries;

            if (beneficiaries.isEmpty) return;

            if (_preSelectedBeneficiaryId != null) {
              final _beneficiary = beneficiaries.firstWhere(
                (Beneficiary beneficiary) =>
                    beneficiary.id == _preSelectedBeneficiaryId &&
                    !beneficiary.isDisabled,
              );

              simulatorStore.setBeneficiary(_beneficiary);

              return;
            }

            if (beneficiaries.length == 1) {
              simulatorStore.setBeneficiary(beneficiaries[0]);
              return;
            }

            if (beneficiaries.length > 1) {
              simulatorScreenAnimationStore.handleExpanded(disableScroll: true);
              return;
            }
          },
        ),
        when(
          (_) => beneficiaryStore.hasError || simulatorStore.hasError,
          () {
            if (simulatorStore.fieldErrors == null) {
              navigator.pop();
            }
          },
        ),
      ],
    );

    simulatorScreenAnimationStore.setController(
      AnimationController(
        vsync: this,
        duration: simulatorScreenAnimationStore.duration,
      ),
    );
  }

  @override
  void didPopNext() {
    FlutterUxcam.tagScreenName(UxCamHelper.SIMULATOR);
  }

  @override
  void dispose() {
    reactionDesposers.forEach((disposer) => disposer());
    timerAnimationStore.dispose();
    simulatorScreenAnimationStore.dispose();
    simulatorStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final isLoading = beneficiaryStore.isLoading || simulatorStore.isLoading;
      final beneficiaries =
          beneficiaryStore?.beneficiaryResponseModel?.beneficiaries ?? [];

      return GetIt.I<Screens>().widget(
        isStatic: true,
        safeAreaConfig: SafeAreaConfig(
          bottom: false,
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                height: beneficiaries.isEmpty
                    ? MediaQuery.of(context).size.height - 50
                    : null,
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: beneficiaries.isEmpty
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.start,
                  children: <Widget>[
                    SimulatorHeaderWidget(),
                    isLoading || beneficiaries.isNotEmpty
                        ? SimulatorBeneficiariesWidget(
                            simulatorStore: simulatorStore,
                            simulatorScreenAnimationStore:
                                simulatorScreenAnimationStore,
                            isLoading: isLoading,
                            beneficiaryResponseModel:
                                beneficiaryStore?.beneficiaryResponseModel,
                          )
                        : emptyState,
                    !isLoading && beneficiaries.isEmpty
                        ? SafeArea(
                            child: Container(
                              width: double.infinity,
                              height: 48,
                              child: PrimaryButtonWidget(
                                i18n.trans('start'),
                                onPressed: _onStartClick,
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            isLoading || beneficiaries.isNotEmpty
                ? buildSimulatorOverflow(context, isLoading)
                : Container(),
          ],
        ),
      );
    });
  }

  _onStartClick() {
    TrackEvents.log(TrackEvents.BENEFICIARY_NEW_TRANSACTION_CLICK);

    GetIt.I<SnowplowHelper>().track(
      category: SnowplowHelper.BENEFICIARY_CATEGORY,
      action: SnowplowHelper.CLICK_ACTION,
      label: SnowplowHelper.ADD_NEW_BENEFICIARY,
    );

    AppRouter.websiteRedirect(
      beneficiaryStore?.beneficiaryResponseModel?.defaultUrl,
      utm: UTM(
        campaign: UTM.ADD_NEW_BENEFICIARY_CAMPAIGN,
      ),
    );
  }

  Widget buildSimulatorOverflow(BuildContext context, bool isLoading) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: SizedBox.expand(
        child: SlideTransition(
          position: simulatorScreenAnimationStore.tween
              .animate(simulatorScreenAnimationStore.controller),
          child:
              // NotificationListener<DraggableScrollableNotification>(
              // onNotification: (notification) {
              //   simulatorScreenAnimationStore
              //       .setDraggableScrollablePosition(
              //           notification.extent);
              //   simulatorScreenAnimationStore
              //       .setIsExpanded(notification.extent < .85);
              //   return true;
              // },
              DraggableScrollableSheet(
            maxChildSize: .85,
            initialChildSize: .85,
            minChildSize: .85,
            // minChildSize: .1,
            builder: (context, scrollCtrl) {
              return SimulatorWidget(
                simulatorStore: simulatorStore,
                transactionPresenter: widget.transactionPresenter,
                simulatorScreenAnimationStore: simulatorScreenAnimationStore,
                isScrollDisabled: true,
                // simulatorScreenAnimationStore.isScrollDisabled,
                isLoading: isLoading,
                controller: scrollCtrl,
                simulatorResponse: simulatorStore?.simulatorResponse,
                refreshFunction: () => simulate(disableLoad: true),
              );
            },
          ),
          // ),
        ),
      ),
    );
  }
}
