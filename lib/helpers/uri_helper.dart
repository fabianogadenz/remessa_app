class UriHelper {
  static String addQueryParams(
      String uriStr, Map<String, dynamic> queryParams) {
    if (queryParams == null) return uriStr;

    final uri = Uri.parse(uriStr);
    final mergedQueryParams = {};

    mergedQueryParams..addAll(uri.queryParameters)..addAll(queryParams);

    return uri
        .replace(queryParameters: Map<String, dynamic>.from(mergedQueryParams))
        .toString();
  }
}
