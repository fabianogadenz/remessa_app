import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_i18n/easy_i18n.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/track_events.dart';
import 'package:remessa_app/router.dart';
import 'package:remessa_app/screens/initial_stepper/widgets/initial_stepper_footer_widget.dart';
import 'package:remessa_app/screens/initial_stepper/widgets/initial_stepper_widget.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:screens/screens.dart';

class InitialStepperModel {
  final String imagePath;
  final String title;
  final String description;

  InitialStepperModel(this.imagePath, this.title, this.description);
}

class InitialStepperScreen extends StatefulWidget {
  @override
  _InitialStepperScreenState createState() => _InitialStepperScreenState();
}

class _InitialStepperScreenState extends State<InitialStepperScreen> {
  final i18n = GetIt.I<I18n>();
  final navigator = GetIt.I<NavigatorHelper>();

  List<InitialStepperModel> steppers;
  CarouselSlider carousel;
  int _currentIndex = 0;
  int _currentLogIndex = 1;

  @override
  void initState() {
    steppers = [
      InitialStepperModel(
        'images/step1.png',
        i18n.trans('stepper1', ['title']),
        i18n.trans('stepper1', ['description']),
      ),
      InitialStepperModel(
        'images/step2.png',
        i18n.trans('stepper2', ['title']),
        i18n.trans('stepper2', ['description']),
      ),
      InitialStepperModel(
        'images/step3.png',
        i18n.trans('stepper3', ['title']),
        i18n.trans('stepper3', ['description']),
      ),
    ];

    carousel = CarouselSlider(
      enableInfiniteScroll: false,
      height: double.infinity,
      viewportFraction: 1.0,
      onPageChanged: (int index) {
        setState(() {
          _currentIndex = index;
          _currentLogIndex = _currentIndex + 1;
        });

        TrackEvents.log(
          TrackEvents.INITIAL_STEPPER_VIEW_STEPPER,
          {'tutorial_step': _currentLogIndex},
        );
      },
      items: steppers
          .map(
            (InitialStepperModel step) => InitialStepperWidget(
              imagePath: step.imagePath,
              title: step.title,
              description: step.description,
            ),
          )
          .toList(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetIt.I<Screens>().widget(
      isStatic: true,
      child: Container(
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            carousel,
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 15,
              ),
              margin: EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                child: Text(
                  i18n.trans('skip'),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                  ),
                ),
                onTap: () {
                  TrackEvents.log(
                    TrackEvents.INITIAL_STEPPER_SKIP_STEPPER_CLICK,
                    {'tutorial_step': _currentLogIndex},
                  );

                  navigator.pushReplacementNamed(AppRouter.LOGIN_ROUTE);
                },
              ),
            ),
            InitialStepperFooterWidget(
              length: steppers.length,
              index: _currentIndex,
              highlightedButton: _currentIndex == steppers.length - 1,
              onTap: () {
                if (_currentIndex == steppers.length - 1) {
                  TrackEvents.log(
                      TrackEvents.INITIAL_STEPPER_FINISH_BUTTON_CLICK);

                  navigator.pushReplacementNamed(AppRouter.LOGIN_ROUTE);
                  return;
                }

                TrackEvents.log(
                  TrackEvents.INITIAL_STEPPER_NEXT_STEP_CLICK,
                  {'tutorial_step': _currentLogIndex},
                );

                carousel.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
