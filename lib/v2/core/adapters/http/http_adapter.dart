abstract class HttpAdapter {
  Future<Map<String, dynamic>> post(String path, {dynamic data});
  Future<Map<String, dynamic>> put(String path, {dynamic data});
}
