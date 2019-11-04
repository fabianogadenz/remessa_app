import 'package:hive/hive.dart';

class AuthService {
  final Box _box;

  AuthService(this._box) : assert(_box != null);

  static Future<AuthService> init() async {
    final _box = await Hive.openBox('auth');

    return AuthService(_box);
  }

  String get token => _box.get('token');

  void saveToken(String token) => _box.put('token', token);

  bool get isLoggedIn => (token != null);
}
