import 'package:amplitude_flutter/amplitude.dart';
import 'package:dio/dio.dart';
import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/helpers/snowplow_helper.dart';
import 'package:remessa_app/models/hive/customer_model.dart';
import 'package:remessa_app/models/responses/login_response_model.dart';
import 'package:remessa_app/setup.dart';

class AuthService {
  final _amplitude = GetIt.I<Amplitude>();
  final _snowplow = GetIt.I<SnowplowHelper>();

  Future<Box> get _box async => await Hive.openBox('auth');
  Dio _dio;

  AuthService() {
    Hive.registerAdapter(CustomerAdapter());
    _dio = GetIt.I<Dio>();
  }

  Future<String> get token async {
    final box = await _box;
    final token = box.get('token');

    return token;
  }

  Future<Customer> get customer async {
    final box = await _box;

    return box.get('customer');
  }

  Future<Customer> saveUser(String token, Customer customer) async {
    final box = await _box;

    await box.put('token', token);
    await updateCustomer(customer);

    return customer;
  }

  Future<Customer> updateCustomer(Customer customer) async {
    final box = await _box;

    await box.put('customer', customer);

    return customer;
  }

  Future<void> logout() async {
    final box = await _box;

    await box.deleteFromDisk();

    removeUserIdentity();
  }

  Future<bool> get isLoggedIn async {
    final _customer = await customer;
    final _token = await token;

    print(_customer?.id);
    return (_token != null);
  }

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
      final _customer = await saveUser(
        loginResponse.token,
        loginResponse.customer,
      );

      setUserIdentity(_customer);
      await SetUp.startOneSignal();
      await OneSignal.shared.setExternalUserId(_customer.id.toString());
    } on DioError catch (e) {
      logout();
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      logout();
      throw e;
    }
  }

  Future<void> setUxCamUserIdentity(Customer customer) async {
    if (!await FlutterUxcam.isRecording()) return;
    FlutterUxcam.setUserIdentity(customer.id.toString());
    FlutterUxcam.setUserProperty('name', customer.name);
    FlutterUxcam.setUserProperty('email', customer.email);
  }

  setUserIdentity(Customer customer) {
    _amplitude.setUserId(customer.id.toString());
    _snowplow.setUserId(customer.id);
    setUxCamUserIdentity(customer);
  }

  removeUserIdentity() {
    _amplitude.setUserId(null);
    _snowplow.setUserId(null);
    OneSignal.shared.removeExternalUserId();
  }
}
