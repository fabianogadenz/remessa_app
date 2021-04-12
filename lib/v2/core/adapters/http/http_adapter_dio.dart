import 'package:dio/dio.dart';
import 'package:remessa_app/helpers/error.dart';

import 'http_adapter.dart';

class HttpAdapterDio implements HttpAdapter {
  final Dio _dio;

  HttpAdapterDio(this._dio);

  Future<T> get<T>(String path, {Map<String, dynamic> params}) async {
    try {
      final response = await _dio.get<T>(path, queryParameters: params);

      return response?.data;
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }

  Future<T> post<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.post<T>(path, data: data);

      return response?.data;
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }

  Future<T> put<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.put<T>(path, data: data);

      return response?.data;
    } on DioError catch (e) {
      ErrorHelper.throwFormattedErrorResponse(e);
    } catch (e) {
      throw e;
    }

    return null;
  }
}
