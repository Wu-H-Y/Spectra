/// 相似度计算 Rust FFI 集成测试
///
/// 测试 Rust FFI 暴露的相似度计算 API
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:spectra/core/rust/api/similarity.dart';
import 'package:spectra/core/rust/frb_generated.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Rust FFI Similarity API', () {
    setUpAll(() async {
      await RustLib.init();
    });

    // ============ Jaccard 相似度测试 ============

    group('jaccard', () {
      testWidgets('相同字符串返回 1.0', (tester) async {
        final result = await jaccard(a: '你好世界', b: '你好世界');
        expect(result, equals(1.0));
      });

      testWidgets('两个空字符串返回 1.0', (tester) async {
        final result = await jaccard(a: '', b: '');
        expect(result, equals(1.0));
      });

      testWidgets('一个空字符串返回 0.0', (tester) async {
        final result1 = await jaccard(a: '你好', b: '');
        expect(result1, equals(0.0));

        final result2 = await jaccard(a: '', b: '你好');
        expect(result2, equals(0.0));
      });

      testWidgets('部分重叠返回中间值', (tester) async {
        final result = await jaccard(a: '你好世界', b: '你好中国');
        expect(result, greaterThan(0.0));
        expect(result, lessThan(1.0));
      });

      testWidgets('完全不同的字符串', (tester) async {
        final result = await jaccard(a: '苹果', b: '香蕉');
        expect(result, greaterThanOrEqualTo(0.0));
        expect(result, lessThan(0.5));
      });

      testWidgets('中文分词效果', (tester) async {
        // jieba 会将 "斗罗大陆" 分词为 ["斗罗", "大陆"]
        // 将 "斗罗大陆第一部" 分词为 ["斗罗", "大陆", "第一部"]
        final result = await jaccard(
          a: '斗罗大陆',
          b: '斗罗大陆第一部',
        );
        // 共享 "斗罗" 和 "大陆"，应该有较高相似度
        expect(result, greaterThan(0.3));
      });
    });

    // ============ Levenshtein 相似度测试 ============

    group('levenshtein', () {
      testWidgets('相同字符串返回 1.0', (tester) async {
        final result = await levenshtein(a: 'hello', b: 'hello');
        expect(result, equals(1.0));
      });

      testWidgets('两个空字符串返回 1.0', (tester) async {
        final result = await levenshtein(a: '', b: '');
        expect(result, equals(1.0));
      });

      testWidgets('一个空字符串返回 0.0', (tester) async {
        final result = await levenshtein(a: 'hello', b: '');
        expect(result, equals(0.0));
      });

      testWidgets('一个字符差异', (tester) async {
        final result = await levenshtein(a: 'hello', b: 'hallo');
        // 1/5 的差异，相似度应该是 0.8
        expect(result, closeTo(0.8, 0.01));
      });

      testWidgets('插入一个字符', (tester) async {
        final result = await levenshtein(a: 'hello', b: 'helloo');
        expect(result, greaterThan(0.8));
      });

      testWidgets('删除一个字符', (tester) async {
        final result = await levenshtein(a: 'hello', b: 'helo');
        expect(result, closeTo(0.8, 0.01));
      });

      testWidgets('中文字符', (tester) async {
        final result = await levenshtein(a: '你好世界', b: '你好世借');
        // 1/4 的差异
        expect(result, closeTo(0.75, 0.01));
      });

      testWidgets('完全不同的字符串', (tester) async {
        final result = await levenshtein(a: 'abc', b: 'xyz');
        expect(result, equals(0.0));
      });
    });

    // ============ 标题标准化测试 ============

    group('normalizeTitle', () {
      testWidgets('简单标题保持不变', (tester) async {
        final result = await normalizeTitle(title: '你好世界');
        expect(result, equals('你好世界'));
      });

      testWidgets('转小写', (tester) async {
        final result = await normalizeTitle(title: 'Hello World');
        expect(result, equals('hello world'));
      });

      testWidgets('去除括号内容', (tester) async {
        final result = await normalizeTitle(title: '标题(2024)');
        expect(result, equals('标题'));
      });

      testWidgets('去除方括号内容', (tester) async {
        final result = await normalizeTitle(title: '标题[完本]');
        expect(result, equals('标题'));
      });

      testWidgets('去除中文方括号内容', (tester) async {
        final result = await normalizeTitle(title: '标题【推荐】');
        expect(result, equals('标题'));
      });

      testWidgets('去除章节号 - 中文', (tester) async {
        final result = await normalizeTitle(title: '第123章 标题');
        expect(result, equals('标题'));
      });

      testWidgets('去除章节号 - 英文', (tester) async {
        final result = await normalizeTitle(title: 'Chapter 123 Title');
        expect(result, equals('title'));
      });

      testWidgets('合并多个空白', (tester) async {
        final result = await normalizeTitle(title: '标题   副标题');
        expect(result, equals('标题 副标题'));
      });

      testWidgets('去除首尾空白', (tester) async {
        final result = await normalizeTitle(title: '  标题  ');
        expect(result, equals('标题'));
      });

      testWidgets('复杂标题', (tester) async {
        final result = await normalizeTitle(title: '斗罗大陆(2024)【完结】[精品]');
        expect(result, equals('斗罗大陆'));
      });

      testWidgets('繁体转简体', (tester) async {
        final result = await normalizeTitle(title: '繁體字');
        expect(result, equals('繁体字'));
      });
    });

    // ============ 模糊搜索评分测试 ============

    group('fuzzySearchScore', () {
      testWidgets('相同标题返回 1.0', (tester) async {
        final result = await fuzzySearchScore(
          query: '斗罗大陆',
          target: '斗罗大陆',
        );
        expect(result, equals(1.0));
      });

      testWidgets('相似标题', (tester) async {
        final result = await fuzzySearchScore(
          query: '斗罗大陆',
          target: '斗罗大陆1',
        );
        // 应该有较高相似度
        expect(result, greaterThan(0.5));
      });

      testWidgets('完全不同的标题', (tester) async {
        final result = await fuzzySearchScore(
          query: '苹果',
          target: '香蕉',
        );
        expect(result, lessThan(0.5));
      });

      testWidgets('带元数据的标题', (tester) async {
        final result = await fuzzySearchScore(
          query: '斗罗大陆',
          target: '斗罗大陆(2024)',
        );
        // 去除元数据后应该完全匹配
        expect(result, greaterThan(0.95));
      });

      testWidgets('Legado 阈值测试 - 通过', (tester) async {
        // Legado 使用 0.96 阈值
        final result = await fuzzySearchScore(
          query: '斗罗大陆',
          target: '斗罗大陆',
        );
        expect(result, greaterThanOrEqualTo(0.96));
      });

      testWidgets('Legado 阈值测试 - 不通过', (tester) async {
        final result = await fuzzySearchScore(
          query: '斗罗大陆第一部',
          target: '斗罗大陆第二部',
        );
        // 应该低于 0.96 阈值
        expect(result, lessThan(0.96));
      });

      testWidgets('搜索词验证场景', (tester) async {
        // 模拟搜索词验证 (最小 2 字)
        const shortQuery = '你';
        const normalQuery = '你好';

        // 短搜索词
        final result1 = await fuzzySearchScore(
          query: shortQuery,
          target: '你好世界',
        );

        // 正常搜索词
        final result2 = await fuzzySearchScore(
          query: normalQuery,
          target: '你好世界',
        );

        // 正常搜索词应该有更高的匹配度
        expect(result2, greaterThan(result1));
      });
    });

    // ============ 性能测试 ============

    group('性能测试', () {
      testWidgets('批量计算 Jaccard 相似度', (tester) async {
        final targets = [
          '斗罗大陆',
          '斗破苍穹',
          '完美世界',
          '遮天',
          '神墓',
        ];

        final stopwatch = Stopwatch()..start();

        for (final target in targets) {
          await jaccard(a: '斗罗大陆', b: target);
        }

        stopwatch.stop();

        // 5 次调用应该在 1 秒内完成
        expect(stopwatch.elapsedMilliseconds, lessThan(1000));
      });

      testWidgets('批量模糊搜索评分', (tester) async {
        final targets = List.generate(
          10,
          (i) => '斗罗大陆第${i + 1}部',
        );

        final stopwatch = Stopwatch()..start();

        for (final target in targets) {
          await fuzzySearchScore(query: '斗罗大陆', target: target);
        }

        stopwatch.stop();

        // 10 次调用应该在 2 秒内完成
        expect(stopwatch.elapsedMilliseconds, lessThan(2000));
      });
    });
  });
}
