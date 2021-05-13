import 'package:amplitude_flutter/amplitude.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/app/app_store.dart';
import 'package:remessa_app/helpers/environment_model.dart';

class TrackingEvents {
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
  static const DASHBOARD_OPEN_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_ongoing_card_widget';
  static const DASHBOARD_HISTORY_TRANSACTION_CARD_CLICK =
      'mobile_app.click.operation_history_card_widget';
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
  static const SIMULATOR_VALIDATE_COUPON_CLICK =
      'mobile_app.click.simulate_validate_coupon';

  static const BENEFICIARY_ADD_ADDRESS_CLICK =
      'mobile_app.click.operation_beneficiary_add_adress';

  // Beneficiary Widget (Simulator Screen)
  static const BENEFICIARY_NEW_TRANSACTION_CLICK =
      'mobile_app.click.beneficiary_add_new_remittance';
  static const BENEFICIARY_SELECT_CLICK = 'mobile_app.click.beneficiary_select';
  static const BENEFICIARY_DISABLED_CLICK =
      'mobile_app.click.beneficiary_status';

  // NavigationBar
  static const NAVBAR_SEND_CLICK = 'mobile_app.click.menu_sendings';
  static const NAVBAR_SIMULATOR_CLICK = 'mobile_app.click.menu_simulate';
  static const NAVBAR_PROFILE_CLICK =
      'mobile_app.click.menu_personal_information';

  // Splash Screen
  static const SPLASH_VIEW = 'mobile_app.view.splash_screen';

  // Checkout
  static const CHECKOUT_EXPAND_TAXES_CLICK =
      'mobile_app.click.checkout_expand_taxes';
  static const CHECKOUT_VIEW_BENEFICIARY_DETAILS_CLICK =
      'mobile_app.click.checkout_view_beneficiary_details';
  static const CHECKOUT_VIEW_PAYMENT_RULES_CLICK =
      'mobile_app.click.checkout_view_payment_rules';
  static const CHECKOUT_CONFIRM_OPERATION_CLICK =
      'mobile_app.click.checkout_confirm_operation_button';
  static const CHECKOUT_ACCEPT_PAYMENT_RULES_CLICK =
      'mobile_app.click.checkout_accept_payment_rules_button';
  static const CHECKOUT_PROVE_ACCOUNT_CLICK =
      'mobile_app.click.checkout_prove_account_ownership';
  static const CHECKOUT_VIEW_TRANSFER_RULES_CLICK =
      'mobile_app.click.checkout_view_transfer_rules';
  static const CHECKOUT_ALREADY_PAID_CLICK =
      'mobile_app.click.checkout_already_paid_button';
  static const CHECKOUT_WILL_PAY_LATER_CLICK =
      'mobile_app.click.checkout_will_pay_later_button';
  static const CHECKOUT_INVITE_FRIENDS_CLICK =
      'mobile_app.click.checkout_invite_friends';
  static const CHECKOUT_GO_TO_REMITTANCES_CLICK =
      'mobile_app.click.checkout_go_to_remittances_page_button';
  static const CHECKOUT_OK_GO_TO_REMITTANCES_CLICK =
      'mobile_app.click.checkout_ok_go_to_remittances_page_button';
  static const CHECKOUT_QUOTE_EXPIRED_VIEW =
      'mobile_app.view.checkout_quote_expired_popup';
  static const CHECKOUT_QUOTE_EXPIRED_CLICK =
      'mobile_app.click.checkout_quote_expired_button';
  static const CHECKOUT_CALCULATION_INFO_CLICK =
      'mobile_app.click.checkout_calculation_rate_details_button';
  static const CHECKOUT_GO_BACK_CLICK = 'mobile_app.click.checkout_go_back';

  // Profile
  static const PROFILE_LOGOUT_CLICK = 'mobile_app.click.logout_button';
  static const PROFILE_HELP_CLICK = 'mobile_app.click.help_button_menu';

  // Actions
  static logEvent(String name, [Map<String, dynamic> properties]) {
    final amplitude = GetIt.I<Amplitude>();

    amplitude.logEvent(
      name,
      eventProperties: {
        'event_properties': properties,
      },
    );
  }

  static log(String name, [Map<String, dynamic> properties]) {
    final appStore = GetIt.I<AppStore>();

    if (appStore?.configs?.environment == Environment.PROD) {
      logEvent(name, properties);
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
      case CHECKOUT_CALCULATION_INFO_CLICK:
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
      case SIMULATOR_VALIDATE_COUPON_CLICK:
        assert(properties['is_valid'] != null);
        continue log;
      log:
      default:
        logEvent(name, properties);
    }
  }
}
