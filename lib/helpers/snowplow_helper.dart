import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';

class SnowplowHelper {
  final bool verbose;

  int _userId;

  SnowplowHelper({this.verbose = false});

  // categories
  static const BENEFICIARY_CATEGORY = 'beneficiary';
  static const OUTBOUND_CATEGORY = 'outbound_operation';

  // actions
  static const CLICK_ACTION = 'click';

  // label
  static const SEND_OPERATION = 'send_operation';
  static const ADD_DISCOUNT = 'add_discount';
  static const ADD_NEW_BENEFICIARY = 'add_new_beneficiary';

  void setUserId(int userId) => _userId = userId;

  Future<Response> track({
    @required String category,
    @required String action,
    @required String label,
    String property,
    double value,
  }) async {
    if (verbose) assert(category != null && action != null && label != null);

    return GetIt.I<Dio>().post(
      '/snowplow',
      data: {
        'userId': _userId ?? GetIt.I<AuthService>()?.customer?.id,
        'category': category,
        'action': action,
        'label': label,
        'property': property,
        'value': value,
      },
    );
  }
}
