import 'package:flutter/widgets.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/screens/initial_stepper/initial_stepper_screen.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen.dart';
import 'package:remessa_app/screens/splash/splash_screen.dart';
import 'package:remessa_app/screens/transaction_details/beneficiary_data_screen.dart';
import 'package:remessa_app/screens/transaction_details/how_to_pay_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen.dart';
import 'package:remessa_app/services/system_service.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/widgets/tab_controller/tab_controller_widget.dart';

class Router {
  static const SPLASH_ROUTE = '/';
  static const CHECK_LOGIN_ROUTE = '/check_login';
  static const WEBSITE_REDIRECT_ROUTE = '/website_redirect';
  static const INITIAL_ROUTE = '/initial';
  static const STEPPER_ROUTE = '/stepper';
  static const LOGIN_ROUTE = '/login';
  static const DASHBOARD_ROUTE = '/dashboard';
  static const TRANSACTION_DETAILS_ROUTE = '/transaction_details';
  static const TD_HOW_TO_PAY_ROUTE = '/transaction_details/how_to_pay';
  static const TD_CALCULATION_ROUTE = '/transaction_details/calculation';
  static const TD_BENEFICIARY_ROUTE = '/transaction_details/beneficiary_data';

  static Widget _handleDashboardRoute() {
    FlutterUxcam.tagScreenName(UxCamHelper.DASHBOARD);
    return TabControllerWidget();
  }

  static Widget _handleLoginRoute() {
    FlutterUxcam.tagScreenName(UxCamHelper.LOGIN);
    return LoginScreen();
  }

  static Widget _handleStepperRoute() {
    FlutterUxcam.tagScreenName(UxCamHelper.STEPPER);
    return InitialStepperScreen();
  }

  static Widget _handleInitialRoute() => GetIt.I<SystemService>().showStepper
      ? _handleStepperRoute()
      : _handleLoginRoute();

  static Map<String, Widget Function(BuildContext)> routes() => {
        SPLASH_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.SPLASH);
          return SplashScreen();
        },
        CHECK_LOGIN_ROUTE: (context) => GetIt.I<AuthStore>().isLoggedIn
            ? _handleDashboardRoute()
            : _handleInitialRoute(),
        WEBSITE_REDIRECT_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.REDIRECT);
          return WebsiteRedirectScreen();
        },
        INITIAL_ROUTE: (context) => _handleInitialRoute(),
        STEPPER_ROUTE: (context) => _handleStepperRoute(),
        LOGIN_ROUTE: (context) => _handleLoginRoute(),
        DASHBOARD_ROUTE: (context) => _handleDashboardRoute(),
        TRANSACTION_DETAILS_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.OPERATION);
          return TransactionDetailsScreen();
        },
        TD_HOW_TO_PAY_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.OPERATION);
          return HowToPayScreen();
        },
        TD_CALCULATION_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.OPERATION);
          return TransactionCalculationScreen();
        },
        TD_BENEFICIARY_ROUTE: (context) {
          FlutterUxcam.tagScreenName(UxCamHelper.OPERATION);
          return BeneficiaryDataScreen();
        },
      };
}
