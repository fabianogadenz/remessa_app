import 'package:amplitude_flutter/amplitude_flutter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/responses/login_response_model.dart';
import 'package:remessa_app/setup.dart';

class AuthService {
  final Box _box;

  Dio _dio;

  AuthService(this._box) : assert(_box != null) {
    _dio = GetIt.I<Dio>();
  }

  static Future<AuthService> init() async {
    final _box = await Hive.openBox('auth');

    return AuthService(_box);
  }

  String get token => _box.get('token');
  int get userId => _box.get('userId');

  void saveUser(String token, int userId) {
    _box.put('token', token);
    _box.put('userId', userId);
  }

  void logout() async {
    _box.clear();
    GetIt.I<AmplitudeFlutter>().setUserId(null);
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

      saveUser(loginResponse.token, loginResponse.customerId);
      GetIt.I<AmplitudeFlutter>().setUserId(userId);
      await SetUp.startOneSignal();
      await OneSignal.shared.setExternalUserId(userId.toString());
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }
}
