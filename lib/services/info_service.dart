import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/models/responses/info_response_model.dart';
import 'package:remessa_app/models/view_model.dart';
import 'package:remessa_app/services/view_generator_service.dart';

class InfoService {
  static Future<ViewGenerator> check() async {
    Response response;

    try {
      response = await GetIt.I<Dio>().get('/info');

      return ViewModel.fromJson(response?.data);
    } catch (_) {
      if (response?.data != null) {
        return tryURLPattern(response);
      }

      return null;
    }
  }

  static Future<ViewGenerator> tryURLPattern(Response response) async {
    try {
      final info = InfoResponseModel.fromJson(response.data);

      return await ViewGeneratorService.getViewGenerator(info.url);
    } catch (_) {
      return null;
    }
  }
}
