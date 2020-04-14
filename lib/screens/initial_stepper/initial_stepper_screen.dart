import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/screens/initial_stepper/widgets/initial_stepper_footer_widget.dart';
import 'package:remessa_app/screens/initial_stepper/widgets/initial_stepper_widget.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/style/colors.dart';
import 'package:remessa_app/widgets/widgets.dart';

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
  final navigator = GetIt.I<NavigatorHelper>();
  final steppers = [
    InitialStepperModel(
      'images/step1.png',
      'Envie no site e acompanhe por aqui',
      'Confira o status dos seus envios em andamento, veja seu histórico de remessas e tire dúvidas pelo chat.',
    ),
    InitialStepperModel(
      'images/step2.png',
      'Receba atualizações em tempo real',
      'Ative as notificações e acompanhe o andamento de seus envios de onde estiver.',
    ),
    InitialStepperModel(
      'images/step3.png',
      'Acompanhe as novidades do app',
      'Estamos aprimorando o app. Em breve, você poderá fazer suas remessas por aqui. Aguarde!',
    ),
  ];

  CarouselSlider carousel;

  int _currentIndex = 0;

  @override
  void didChangeDependencies() {
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
          .map(
            (InitialStepperModel step) => InitialStepperWidget(
              imagePath: step.imagePath,
              title: step.title,
              description: step.description,
            ),
          )
          .toList(),
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
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
                  'Pular',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: StyleColors.SUPPORT_NEUTRAL_10,
                  ),
                ),
                onTap: () => navigator.pushReplacement(
                  LoginScreen(),
                ),
              ),
            ),
            InitialStepperFooterWidget(
              length: steppers.length,
              index: _currentIndex,
              highlightedButton: _currentIndex == steppers.length - 1,
              onTap: () => _currentIndex == steppers.length - 1
                  ? navigator.pushReplacement(
                      LoginScreen(),
                    )
                  : carousel.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
