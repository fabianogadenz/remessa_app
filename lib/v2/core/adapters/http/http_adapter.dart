abstract class HttpAdapter {
  Future<T> get<T>(String path, {Map<String, dynamic> params});
  Future<T> post<T>(String path, {dynamic data});
  Future<T> put<T>(String path, {dynamic data});
}
