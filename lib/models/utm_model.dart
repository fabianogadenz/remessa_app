class UTM {
  final String source;
  final String campaign;
  final String medium;

  static const PRE_SIGNUP_CAMPAIGN = 'pre_signup';
  static const FORGOT_PASSWORD_CAMPAIGN = 'forgot_password';
  static const ADD_NEW_BENEFICIARY_CAMPAIGN = 'add_new_beneficiary';
  static const SEND_OPERATION_CAMPAIGN = 'send_operation';
  static const ADD_DISCOUNT_CAMPAIGN = 'add_discount';
  static const FOLLOW_UP_EXCHANGE_RATE_CAMPAIGN = 'follow_up_exchange_rate';
  static const PRIVACY_POLICY_TERMS_CAMPAIGN = 'privacy_policy_terms';
  static const TERMS_OF_SERVICE_CAMPAIGN = 'terms_of_service';

  const UTM({
    this.source = 'app',
    this.campaign,
    this.medium = 'android/ios/outros',
  });

  Map<String, String> toMap() => {
        'utm_source': source,
        'utm_campaign': campaign,
        'utm_medium': medium,
      };
}
