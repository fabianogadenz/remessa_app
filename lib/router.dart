import 'package:flutter/widgets.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/navigator.dart';
import 'package:remessa_app/helpers/uxcam_helper.dart';
import 'package:remessa_app/models/utm_model.dart';
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/screens/home/home_screen.dart';
import 'package:remessa_app/screens/initial_stepper/initial_stepper_screen.dart';
import 'package:remessa_app/screens/login/login_screen.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen.dart';
import 'package:remessa_app/screens/redirect/website_redirect_screen_args.dart';
import 'package:remessa_app/screens/simulator/simulator_screen.dart';
import 'package:remessa_app/screens/simulator/simulator_screen_args.dart';
import 'package:remessa_app/screens/splash/splash_screen.dart';
import 'package:remessa_app/screens/transaction_details/beneficiary_data_screen.dart';
import 'package:remessa_app/screens/transaction_details/how_to_pay_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_calculation_screen.dart';
import 'package:remessa_app/screens/transaction_details/transaction_details_screen.dart';
import 'package:remessa_app/services/system_service.dart';
import 'package:remessa_app/stores/auth_store.dart';
import 'package:remessa_app/v2/modules/settings/infra/factories/notification_preferences_presenter_factory.dart';
import 'package:remessa_app/v2/modules/transaction/infra/factories/transaction_presenter_factory.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_beneficiary_data/checkout_beneficiary_data_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_beneficiary_data/checkout_beneficiary_data_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_confirmation/checkout_confirmation_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_data/checkout_payment_data_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_rules/checkout_payment_rules_screen_args.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_success/checkout_success_screen.dart';
import 'package:remessa_app/v2/modules/transaction/view/screens/checkout_payment_rules/checkout_payment_rules_screen.dart';

class AppRouter {
  static const SPLASH_ROUTE = 'splash';
  static const CHECK_LOGIN_ROUTE = 'check_login';
  static const WEBSITE_REDIRECT_ROUTE = 'website_redirect';
  static const INITIAL_ROUTE = 'initial';
  static const STEPPER_ROUTE = 'stepper';
  static const LOGIN_ROUTE = 'login';
  static const DASHBOARD_ROUTE = 'dashboard';
  static const SIMULATOR_ROUTE = 'simulator';
  static const TRANSACTION_DETAILS_ROUTE = 'transaction_details';
  static const GENERATED_VIEW_ROUTE = 'generated_view';
  static const TD_HOW_TO_PAY_ROUTE = 'transaction_details/how_to_pay';
  static const TD_CALCULATION_ROUTE = 'transaction_details/calculation';
  static const TD_BENEFICIARY_ROUTE = 'transaction_details/beneficiary_data';
  static const SIMULATOR_CALCULATION_ROUTE = 'simulator/calculation';
  static const CHECKOUT_CONFIRMATION = 'checkout/confirmation';
  static const CHECKOUT_PAYMENT_RULES = 'checkout/payment_rules';
  static const CHECKOUT_PAYMENT_DATA = 'checkout/payment_data';
  static const CHECKOUT_SUCCESS = 'checkout/success';
  static const CHECKOUT_BENEFICIARY_DATA = 'checkout/beneficiary_data';

  static Widget _handleDashboardRoute() {
    FlutterUxcam.tagScreenName(UxCamHelper.DASHBOARD);
    return HomeScreen(
      notificationPreferencesPresenter:
          NotificationPreferencesPresenterFactory().call(),
    );
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

  static Map<String, Widget Function(BuildContext)> routes() {
    final _authStore = GetIt.I<AuthStore>();
    _authStore.refreshUserIdentity();

    return {
      SPLASH_ROUTE: (context) {
        FlutterUxcam.tagScreenName(UxCamHelper.SPLASH);
        return SplashScreen();
      },
      CHECK_LOGIN_ROUTE: (context) {
        if (_authStore.isLoggedIn) {
          _authStore.refreshUserIdentity();
          return _handleDashboardRoute();
        }

        return _handleInitialRoute();
      },
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
      SIMULATOR_CALCULATION_ROUTE: (context) {
        FlutterUxcam.tagScreenName(UxCamHelper.SIMULATOR_TAXES);
        return TransactionCalculationScreen();
      },
      GENERATED_VIEW_ROUTE: (context) {
        final viewGenerator = NavigatorHelper.getArgs<ViewGenerator>(context);

        return viewGenerator.generate();
      },
      CHECKOUT_CONFIRMATION: (context) {
        FlutterUxcam.tagScreenName(UxCamHelper.CHECKOUT);
        return CheckoutConfirmationScreen();
      },
      CHECKOUT_PAYMENT_RULES: (context) {
        final args =
            NavigatorHelper.getArgs<CheckoutPaymentRulesScreenArgs>(context);

        return CheckoutPaymentRulesScreen(
          isProgressive: args?.isProgressive ?? false,
        );
      },
      CHECKOUT_PAYMENT_DATA: (context) {
        return CheckoutPaymentDataScreen();
      },
      CHECKOUT_SUCCESS: (context) {
        return CheckoutSuccessScreen();
      },
      CHECKOUT_BENEFICIARY_DATA: (context) {
        final args =
            NavigatorHelper.getArgs<CheckoutBeneficiaryDataScreenArgs>(context);

        return CheckoutBeneficiaryDataScreen(
          beneficiary: args?.beneficiary,
        );
      }
    };
  }

  static Route<dynamic> Function(RouteSettings) onGenerateRoute() =>
      (RouteSettings settings) {
        switch (settings.name) {
          case AppRouter.SIMULATOR_ROUTE:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) {
                FlutterUxcam.tagScreenName(UxCamHelper.SIMULATOR);
                final SimulatorScreenArgs args = settings?.arguments;

                return SimulatorScreen(
                  preSelectedBeneficiaryId: args?.beneficiaryId,
                  transactionPresenter: TransactionPresenterFactory().call(),
                );
              },
              transitionsBuilder: _slideUpTB(),
            );
            break;
          default:
            return PageRouteBuilder(
              pageBuilder: (_, __, ___) => Container(), // TODO: 404 page
            );
        }
      };

  static _slideUpTB() => (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      };

  static websiteRedirect(String url, {String description, Note note, UTM utm}) {
    GetIt.I<NavigatorHelper>().pushNamed(
      AppRouter.WEBSITE_REDIRECT_ROUTE,
      arguments: WebsiteRedirectScreenArgs(
        url: url,
        description: description,
        note: note,
        utm: utm,
      ),
    );
  }
}
