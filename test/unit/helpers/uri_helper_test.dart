import 'package:flutter_test/flutter_test.dart';
import 'package:remessa_app/helpers/environment_model.dart';
import 'package:remessa_app/helpers/uri_helper.dart';
import 'package:remessa_app/models/config_model.dart';
import 'package:remessa_app/setup.dart';

void main() async {
  final remoteConfigs = ConfigModel(environment: Environment.TEST);

  await SetUp(remoteConfigs).init();

  group('UriHelper', () {
    group('addQueryParams', () {
      test(
        'should return same url if no query params are passed',
        () async {
          final url = 'https://www.remessaonline.com.br/';

          expect(UriHelper.addQueryParams(url, null), url);
        },
      );

      test(
        'should return url with query params',
        () async {
          final url = 'https://www.remessaonline.com.br/';

          expect(
            UriHelper.addQueryParams(url, {
              'foo': 'foo',
              'bar': 'bar',
            }),
            '$url?foo=foo&bar=bar',
          );
        },
      );

      test(
        'should return url with original query params and add new query params',
        () async {
          final url = 'https://www.remessaonline.com.br/?test=test&test2=test2';

          expect(
            UriHelper.addQueryParams(url, {
              'foo': 'foo',
              'bar': 'bar',
            }),
            '$url&foo=foo&bar=bar',
          );
        },
      );
    });
  });
}
