import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/router/app_router.dart';

void main() {
  group('normalizeRulesImportDeepLink', () {
    test('应将深链 URL 规范化为 rules route', () {
      final uri = Uri.parse(
        'spectra://rules/import?url=https%3A%2F%2Fexample.com%2Frule.json',
      );

      final location = normalizeRulesImportDeepLink(uri);

      expect(location, '/rules?url=https%3A%2F%2Fexample.com%2Frule.json');
    });

    test('缺少 url 参数时应回到规则页', () {
      final uri = Uri.parse('spectra://rules/import');

      final location = normalizeRulesImportDeepLink(uri);

      expect(location, '/rules');
    });

    test('非 spectra scheme 应忽略', () {
      final uri = Uri.parse('https://example.com/rules/import');

      final location = normalizeRulesImportDeepLink(uri);

      expect(location, isNull);
    });
  });
}
