import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:get_it/get_it.dart';

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
  static const LOGIN_USE_TERMS_CLICK = 'mobile_app.click.terms_of_use_link';
  static const LOGIN_REGISTER_CLICK =
      'mobile_app.click.new_registration_button';

  // Dashboard
  static const DASHBOARD_HELP_TAB_CLICK = 'mobile_app.click.help_button_menu';
  static const DASHBOARD_OPEN_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_ongoing_card_widget';
  static const DASHBOARD_HISTORY_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_history_card_widget';
  static const DASHBOARD_LOGOUT_CLICK = 'mobile_app.click.logout_button';

  // Transaction Details
  static const TRANSACTION_FAVORED_INFO_CLICK =
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

  // Actions
  static log(String name, [Map<String, dynamic> properties]) {
    final amplitude = GetIt.I<AmplitudeFlutter>();

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
      log:
      default:
        amplitude.logEvent(name: name, properties: properties);
    }
  }
}
