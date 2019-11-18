import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/responses/login_response_model.dart';

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

  void saveToken(String token) => _box.put('token', token);

  void removeToken() => _box.delete('token');

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

      saveToken(loginResponse.token);
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }
  }
}
