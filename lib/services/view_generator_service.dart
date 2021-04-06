import 'package:dio/dio.dart';
import 'package:remessa_app/models/view_model.dart';

class ViewGeneratorService {
  static Future<ViewGenerator> getViewGenerator(String url) async {
    try {
      Response response = await Dio().get(url);

      return ViewModel.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
