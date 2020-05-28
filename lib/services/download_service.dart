import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:remessa_app/services/auth_service.dart';

class DownloadService {
  final String baseUrl;

  DownloadService({this.baseUrl = ''});

  Future<FileInfo> downloadFile(String path) =>
      DefaultCacheManager().downloadFile('$baseUrl$path', authHeaders: {
        'Authorization': 'Bearer ${GetIt.I<AuthService>().token}',
      });
}
