import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/actions/action.dart' as ac;
import 'package:remessa_app/models/view_generators/info_stepper_model.dart';
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/screens/info_stepper/widgets/info_stepper_actions_widget.dart';
import 'package:remessa_app/screens/info_stepper/widgets/info_stepper_content_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/app_bar_widget.dart';
import 'package:remessa_app/widgets/dot_indicator_widget.dart';
import 'package:screens/screens.dart';

class InfoStepperScreen extends StatefulWidget
    implements View<InfoStepperModel> {
  @override
  final InfoStepperModel model;

  const InfoStepperScreen({
    Key key,
    @required this.model,
  })  : assert(model != null),
        super(key: key);

  @override
  _InfoStepperScreenState createState() => _InfoStepperScreenState();
}

class _InfoStepperScreenState extends State<InfoStepperScreen> {
  int _currentIndex = 0;
  CarouselSlider carousel;

  get steppers => widget.model?.steppers;
  get hasSteppers => (steppers != null && steppers.length > 1);

  @override
  void initState() {
    carousel = CarouselSlider(
      enableInfiniteScroll: false,
      height: double.infinity,
      viewportFraction: 1.0,
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
      items: steppers
          .map<Widget>(
            (InfoStepper step) => InfoStepperContentWidget(
              header: step.header,
              title: step.title,
              content: step.content,
              imageURL: step.imageURL,
            ),
          )
          .toList(),
    );

    super.initState();
  }

  _handleDotIndicators() => hasSteppers
      ? Center(
          child: DotIndicatorsWidget(
            length: steppers.length,
            currentIndex: _currentIndex,
            selectedColor: StyleColors.BRAND_PRIMARY_40,
            defaultColor: StyleColors.BRAND_SECONDARY_20,
          ),
        )
      : Container();

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      showAppBar: widget.model.showAppBar ?? false,
      appBarWidget: AppBarWidget(
        elevation: 0,
      ),
      isStatic: true,
      isAccent: true,
      statusBarBrightness: Brightness.light,
      child: Column(
        children: [
          Expanded(
            child: carousel,
          ),
          _handleDotIndicators(),
          SizedBox(
            height: hasSteppers ? 155 : null,
            child: InfoStepperActionsWidget(
              action: steppers[_currentIndex]?.action ??
                  ac.Action(
                    name: 'Próximo',
                    actionFunction: () => carousel.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    ),
                  ),
              linkAction: steppers[_currentIndex]?.linkAction,
            ),
          ),
        ],
      ),
    );
  }
}
