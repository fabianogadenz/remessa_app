import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/models/responses/info_response_model.dart';

class InfoService {
  static Future<InfoResponseModel> check() async {
    try {
      Response response = await GetIt.I<Dio>().get('/info');

      return InfoResponseModel.fromJson(response.data);
    } catch (_) {
      return null;
    }
  }
}
