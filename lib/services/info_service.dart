import 'package:dio/dio.dart';
import 'package:remessa_app/helpers/error.dart';
import 'package:remessa_app/models/responses/info_response_model.dart';

class InfoService {
  static Future<InfoResponseModel> check() async {
    try {
      // TODO: Remove mock
      // Response response = await GetIt.I<Dio>().get('/info');

      // return InfoResponseModel.fromJson(response.data);
      return InfoResponseModel.fromJson({'url': 'www.google.com'});
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }
}
