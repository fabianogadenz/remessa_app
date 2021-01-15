import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'http_adapter.dart';

class HttpAdapterDio implements HttpAdapter {
  Future<Map<String, dynamic>> post(String path, {dynamic data}) async {
    final response =
        await GetIt.I<Dio>().post<Map<String, dynamic>>(path, data: data);

    return response.data;
  }
}
