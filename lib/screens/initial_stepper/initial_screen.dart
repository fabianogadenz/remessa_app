import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/screens/initial_stepper/initial_stepper_screen.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/services/system_service.dart';

class InitialScreen extends StatelessWidget {
  final showStepper = GetIt.I<SystemService>().showStepper;

  @override
  Widget build(BuildContext context) {
    return showStepper ? InitialStepperScreen() : LoginScreen();
  }
}
