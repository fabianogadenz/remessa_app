import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/models/responses/login_response_model.dart';
import 'package:remessa_app/setup.dart';

class AuthService {
  final Box _box;
  final _amplitude = GetIt.I<AmplitudeFlutter>();

  Dio _dio;

  AuthService(this._box) : assert(_box != null) {
    _dio = GetIt.I<Dio>();
  }

  static Future<AuthService> init() async {
    Hive.registerAdapter(CustomerAdapter());

    final _box = await Hive.openBox('auth');

    return AuthService(_box);
  }

  String get token {
    final token = _box.get('token');
    return token;
  }

  Customer get customer => _box.get('customer');

  void saveUser(String token, Customer customer) {
    _box.put('token', token);
    _box.put('customer', customer);
  }

  Future<void> logout() async {
    _box.clear();
    _amplitude.setUserId(null);
    await OneSignal.shared.removeExternalUserId();
  }

  bool get isLoggedIn => (token != null);

  login(String cpf, String password) async {
    try {
      Response response = await _dio.post(
        '/customer/login/',
        data: {
          'username': cpf,
          'password': password,
        },
      );

      final loginResponse = LoginResponseModel.fromJson(response.data);

      saveUser(loginResponse.token, loginResponse.customer);
      _amplitude.setUserId(customer.id);
      setUxCamUserIdentity();
      await SetUp.startOneSignal();
      await OneSignal.shared.setExternalUserId(customer.id.toString());
    } on DioError catch (e) {
      logout();
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      logout();
      throw e;
    }
  }

  Future<void> setUxCamUserIdentity() async {
    if (!await FlutterUxcam.isRecording()) return;
    FlutterUxcam.setUserIdentity(customer.id.toString());
    FlutterUxcam.setUserProperty('name', customer.name);
    FlutterUxcam.setUserProperty('email', customer.email);
  }
}
