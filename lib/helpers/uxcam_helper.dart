import 'package:flutter/material.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';

class UxCamHelper {
  static const SPLASH = 'Splash';
  static const STEPPER = 'Stepper';
  static const LOGIN = 'Login';
  static const DASHBOARD = 'Dashboard';
  static const REDIRECT = 'Redirect';
  static const OPERATION = 'Operation';
  static const BENEFICIARY = 'Beneficiary';
  static const SIMULATOR = 'Simulator';
  static const SIMULATOR_TAXES = 'Simulator taxes';
  static const INFO_STEPPER = 'Info Stepper';

  static void protectField(FocusNode focusNode) async =>
      await FlutterUxcam.isRecording()
          ? focusNode.addListener(
              () => focusNode.hasFocus
                  ? FlutterUxcam.pauseScreenRecording()
                  : FlutterUxcam.resumeScreenRecording(),
            )
          : null;
}
