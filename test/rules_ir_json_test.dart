import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Rules IR v1 JSON 反序列化', () {
    for (final fixturePath in [
      'fixtures/ir_v1_min.json',
      'fixtures/ir_v1_html_story_bundle.json',
      'fixtures/ir_v1_json_api_bundle.json',
    ]) {
      test('$fixturePath 可被 Dart 解析', () {
        final jsonText = File(fixturePath).readAsStringSync();
        final decoded = jsonDecode(jsonText);

        expect(decoded, isA<Map<String, dynamic>>());
        final map = decoded as Map<String, dynamic>;

        expect(map['irVersion'], '1.0.0');
        expect(map['metadata'], isA<Map<String, dynamic>>());
        expect(map['graph'], isA<Map<String, dynamic>>());

        final metadata = map['metadata'] as Map<String, dynamic>;
        expect(metadata['ruleId'], isNotEmpty);
        expect(metadata['name'], isNotEmpty);

        final graph = map['graph'] as Map<String, dynamic>;
        expect(graph['nodes'], isA<List<dynamic>>());
        expect(graph['edges'], isA<List<dynamic>>());
        expect(graph['phaseEntrypoints'], isA<Map<String, dynamic>>());
      });
    }
  });
}
