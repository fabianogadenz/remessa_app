import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter.dart';
import 'package:remessa_app/v2/core/adapters/http/http_adapter_dio.dart';
import 'package:remessa_app/v2/core/factory/factory.dart';

class HttpAdapterFactory implements Factory<HttpAdapter> {
  @override
  HttpAdapter call() => HttpAdapterDio(GetIt.I<Dio>());
}
