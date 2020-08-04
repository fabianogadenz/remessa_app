import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:remessa_app/helpers/string_helper.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/models/responses/beneficiary_response_model.dart';
import 'package:remessa_app/presentation/remessa_icons_icons.dart';
import 'package:remessa_app/screens/simulator/widgets/beneficiary_list_item_widget.dart';
import 'package:remessa_app/screens/simulator/widgets/new_beneficiary_list_item_widget.dart';
import 'package:remessa_app/screens/simulator/simulator_screen_animation_store.dart';
import 'package:remessa_app/stores/simulator_store.dart';
import 'package:remessa_app/style/colors.dart';

class SimulatorBeneficiariesWidget extends StatefulWidget {
  const SimulatorBeneficiariesWidget({
    Key key,
    @required this.simulatorStore,
    @required this.simulatorScreenAnimationStore,
    @required this.beneficiaryResponseModel,
    this.isLoading = false,
  })  : assert(simulatorStore != null),
        assert(simulatorScreenAnimationStore != null),
        super(key: key);

  final SimulatorStore simulatorStore;
  final SimulatorScreenAnimationStore simulatorScreenAnimationStore;
  final BeneficiaryResponseModel beneficiaryResponseModel;
  final bool isLoading;

  @override
  _SimulatorBeneficiariesWidgetState createState() =>
      _SimulatorBeneficiariesWidgetState();
}

class _SimulatorBeneficiariesWidgetState
    extends State<SimulatorBeneficiariesWidget>
    with SingleTickerProviderStateMixin {
  SimulatorStore get simulatorStore => widget.simulatorStore;
  SimulatorScreenAnimationStore get simulatorScreenAnimationStore =>
      widget.simulatorScreenAnimationStore;
  bool get isLoading => widget.isLoading;
  List<Beneficiary> get beneficiaries =>
      widget.beneficiaryResponseModel?.beneficiaries ?? [];

  _onSelectBeneficiary(Beneficiary beneficiary) {
    simulatorStore.setBeneficiary(beneficiary);
    simulatorScreenAnimationStore.handleExpanded();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Observer(
          builder: (_) {
            return AnimatedCrossFade(
              crossFadeState: simulatorScreenAnimationStore.isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              duration: simulatorScreenAnimationStore.duration,
              alignment: Alignment.topLeft,
              firstChild: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: isLoading
                    ? () {}
                    : () {
                        FocusScope.of(context).unfocus();
                        TrackEvents.log(
                            TrackEvents.SIMULATOR_BENEFICIARY_DROPDOWN_CLICK);
                        simulatorScreenAnimationStore.handleExpanded(
                            disableScroll: true);
                      },
                child: _buildHeader(),
              ),
              secondChild: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Escolha um beneficiário',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: StyleColors.BRAND_PRIMARY_20,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * .9,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 16,
                              ),
                              ...beneficiaries
                                      .map(
                                        (beneficiary) =>
                                            BeneficiaryListItemWidget(
                                          beneficiary: beneficiary,
                                          onTap: () =>
                                              _onSelectBeneficiary(beneficiary),
                                        ),
                                      )
                                      .toList() ??
                                  [Container()],
                              NewBeneficiaryListItemWidget(
                                newBeneficiaryUrl: widget
                                        ?.beneficiaryResponseModel
                                        ?.defaultUrl ??
                                    '',
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .26,
                              ),
                            ],
                          ),
                        ),
                      ),
                      IgnorePointer(
                        child: AnimatedContainer(
                          duration: simulatorScreenAnimationStore.duration,
                          color: StyleColors.BRAND_PRIMARY_60.withOpacity(
                            simulatorScreenAnimationStore
                                    .draggableScrollablePosition -
                                .1,
                          ),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  final _beneficiaryNameTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: StyleColors.SUPPORT_NEUTRAL_10,
  );

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, top: 2),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Envio para ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StyleColors.BRAND_PRIMARY_20,
                  ),
                ),
                TextSpan(
                  text: StringHelper
                      .handleLimiterWithEllipsisFromTextWidthAndStyle(
                    simulatorStore?.beneficiary?.beneficiaryName ?? '',
                    280,
                    _beneficiaryNameTextStyle,
                  ),
                  style: _beneficiaryNameTextStyle,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            RemessaIcons.arrow_down,
            size: 6,
          ),
        ],
      ),
    );
  }
}
