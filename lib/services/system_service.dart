import 'package:hive/hive.dart';

class SystemService {
  final Box _box;

  SystemService(this._box) : assert(_box != null);

  static Future<SystemService> init() async {
    final _box = await Hive.openBox('system');

    return SystemService(_box);
  }

  bool get showStepper => _box.get('showStepper') ?? true;

  void setShowStepper(bool showStepper) => _box.put('showStepper', showStepper);
}
