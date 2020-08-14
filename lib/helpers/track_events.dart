import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/environment_model.dart';

class TrackEvents {
  // Stepper
  static const INITIAL_STEPPER_VIEW_STEPPER = 'mobile_app.view.tutorial_widget';
  static const INITIAL_STEPPER_NEXT_STEP_CLICK =
      'mobile_app.click.tutorial_next';
  static const INITIAL_STEPPER_SKIP_STEPPER_CLICK =
      'mobile_app.click.tutorial_skip';
  static const INITIAL_STEPPER_FINISH_BUTTON_CLICK =
      'mobile_app.click.tutorial_finish_button';

  // Login
  static const LOGIN_VIEW = 'mobile_app.view.login_page';
  static const LOGIN_BACK_TO_STEPPER_CLICK =
      'mobile_app.click.back_to_tutorial_button';
  static const LOGIN_FORGOT_PASSWORD_CLICK =
      'mobile_app.click.forgot_password_button';
  static const LOGIN_SUBMIT_LOGIN_INVALID =
      'mobile_app.alert.invalid_login_error';
  static const LOGIN_PRIVACY_POLICY_CLICK = 'mobile_app.click.privacy_policy';
  static const LOGIN_SUBMIT_LOGIN_VALID = 'mobile_app.submit.login_form';
  static const LOGIN_TERMS_OF_SERVICE_CLICK =
      'mobile_app.click.terms_of_use_link';
  static const LOGIN_REGISTER_CLICK =
      'mobile_app.click.new_registration_button';

  // Push Notification
  static const PUSH_NOTIFICATION_OPENED =
      'mobile_app.open.mobile_push_notification';

  // Dashboard
  static const DASHBOARD_HELP_TAB_CLICK = 'mobile_app.click.help_button_menu';
  static const DASHBOARD_OPEN_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_ongoing_card_widget';
  static const DASHBOARD_HISTORY_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_history_card_widget';
  static const DASHBOARD_LOGOUT_CLICK = 'mobile_app.click.logout_button';
  static const DASHBOARD_NEW_TRANSACTION_CLICK =
      'mobile_app.click.new_remittance_site';
  static const DASHBOARD_HOME_LOGO_CLICK =
      'mobile_app.click.remessa_online_logo';

  // Transaction Details
  static const TRANSACTION_BENEFICIARY_INFO_CLICK =
      'mobile_app.click.operation_beneficiary_information_click';
  static const TRANSACTION_CALCULATION_CLICK =
      'mobile_app.click.operation_calculation_information_button';
  static const TRANSACTION_CALCULATION_INFO_CLICK =
      'mobile_app.click.operation_calculation_rate_details_button';
  static const TRANSACTION_HELP_BANNER_CLICK =
      'mobile_app.click.help_button_footer';
  static const TRANSACTION_HELP_CTA_CLICK =
      'mobile_app.click.help_button_pending_operation';
  static const TRANSACTION_HOW_TO_PAY_CLICK =
      'mobile_app.click.operation_how_to_make_payment_link';
  static const TRANSACTION_COPY_LOCAL_BANCK_INFO =
      'mobile_app.click.operation_copy_local_bank_info';
  static const TRANSACTION_RECEIPT_SHARE_CLICK =
      'mobile_app.click.remittance_receipt_share';
  static const TRANSACTION_TOOLTIP_CLICK = 'mobile_app.click.operation_tooltip';
  static const TRANSACTION_REPEAT_CLICK =
      'mobile_app.click.operation_repeat_remittance';

  // Website Redirect Screen
  static const WEBSITE_REDIRECT_CLICK =
      'mobile_app.click.redirect_go_to_website';
  static const WEBSITE_GO_BACK_CLICK = 'mobile_app.click.redirect_go_back';

  // Simulator Screen
  static const SIMULATOR_SIMULATE_CLICK =
      'mobile_app.click.simulate_send_remittance';
  static const SIMULATOR_BENEFICIARY_DROPDOWN_CLICK =
      'mobile_app.click.simulate_beneficiary_list';
  static const SIMULATOR_SELECT_CURRENCY_CLICK =
      'mobile_app.click.simulate_beneficiary_currency_select';
  static const SIMULATOR_TAXES_CLICK = 'mobile_app.click.simulate_expand_taxes';
  static const SIMULATOR_FOLLOW_UP_CLICK =
      'mobile_app.click.simulate_follow_up_exchange_rate';
  static const SIMULATOR_ADD_COUPON_CLICK =
      'mobile_app.click.simulate_add_discount_coupon';
  static const SIMULATOR_SELECT_BRL_TEXT_FIELD =
      'mobile_app.onfocus.simulate_BRL_currency';
  static const SIMULATOR_SELECT_FOREIGN_TEXT_FIELD =
      'mobile_app.onfocus.simulate_foreign_currency';

  // Beneficiary Widget (Simulator Screen)
  static const BENEFICIARY_NEW_TRANSACTION_CLICK =
      'mobile_app.click.beneficiary_add_new_remittance';
  static const BENEFICIARY_SELECT_CLICK = 'mobile_app.click.beneficiary_select';
  static const BENEFICIARY_DISABLED_CLICK =
      'mobile_app.click.beneficiary_status';

  // NavigationBar
  static const NAVBAR_SEND_CLICK = 'mobile_app.click_menu_sendings';
  static const NAVBAR_SIMULATOR_CLICK = 'mobile_app.click_menu_simulate';

  // Splash Screen
  static const SPLASH_VIEW = 'mobile_app.view.splash_screen';

  // Actions
  static log(String name, [Map<String, dynamic> properties]) {
    final amplitude = GetIt.I<AmplitudeFlutter>();
    final appStore = GetIt.I<AppStore>();

    if (appStore?.configs?.environment == Environment.PROD) {
      amplitude.logEvent(
        name: name,
        properties: {
          'event_properties': properties,
        },
      );
      return;
    }

    switch (name) {
      case INITIAL_STEPPER_VIEW_STEPPER:
      case INITIAL_STEPPER_NEXT_STEP_CLICK:
      case INITIAL_STEPPER_SKIP_STEPPER_CLICK:
        assert(properties['tutorial_step'] != null);
        continue log;
      case DASHBOARD_OPEN_TRANSACTION_CARD_CLICK:
      case DASHBOARD_HISTORY_TRANSACTION_CARD_CLICK:
      case TRANSACTION_CALCULATION_CLICK:
      case TRANSACTION_HELP_BANNER_CLICK:
      case TRANSACTION_HELP_CTA_CLICK:
        assert(properties['operation_id'] != null &&
            properties['operation_status_group'] != null &&
            properties['operation_status_name'] != null);
        continue log;
      case TRANSACTION_CALCULATION_INFO_CLICK:
      case TRANSACTION_COPY_LOCAL_BANCK_INFO:
        assert(properties['label'] != null);
        continue log;
      case TRANSACTION_TOOLTIP_CLICK:
        assert(properties['origin'] != null);
        continue log;
      case BENEFICIARY_DISABLED_CLICK:
        assert(properties['beneficiary_status'] != null);
        continue log;
      case SIMULATOR_SELECT_CURRENCY_CLICK:
      case SIMULATOR_SELECT_FOREIGN_TEXT_FIELD:
        assert(properties['currency'] != null);
        continue log;
      log:
      default:
        amplitude.logEvent(
          name: name,
          properties: {
            'event_properties': properties,
          },
        );
    }
  }
}
