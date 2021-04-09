import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/helpers/error.dart';

import 'http_adapter.dart';

class HttpAdapterDio implements HttpAdapter {
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await GetIt.I<Dio>().post(path, data: data);

      return response.data;
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }

  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await GetIt.I<Dio>().put(path, data: data);

      return response.data;
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }
}
