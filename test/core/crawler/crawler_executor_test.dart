import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/crawler/executor/crawler_executor.dart';
import 'package:spectra/core/crawler/executor/workers/crawler_service.dart';
import 'package:talker/talker.dart';

void main() {
  group('CrawlerExecutor', () {
    late CrawlerExecutor executor;
    late Talker talker;

    setUp(() {
      talker = Talker();
      executor = CrawlerExecutor(
        talker: talker,
        config: const CrawlerExecutorConfig(
          maxWorkers: 2,
          maxParallel: 1,
          similarityMaxWorkers: 1,
        ),
      );
    });

    tearDown(() async {
      if (executor.isStarted) {
        await executor.stop();
      }
    });

    group('Worker 生命周期', () {
      test('启动前 isStarted 应为 false', () {
        expect(executor.isStarted, false);
      });

      test('启动后 isStarted 应为 true', () async {
        await executor.start();
        expect(executor.isStarted, true);
      });

      test('启动后 Pool 状态应正确初始化', () async {
        await executor.start();
        
        final crawlerStats = executor.crawlerPoolStats;
        expect(crawlerStats, isNotNull);
        expect(crawlerStats!.size, greaterThanOrEqualTo(1));
        
        final similarityStats = executor.similarityPoolStats;
        expect(similarityStats, isNotNull);
        expect(similarityStats!.size, greaterThanOrEqualTo(1));
      });

      test('重复启动应发出警告但不抛出异常', () async {
        await executor.start();
        
        // 再次启动不应抛出异常
        await executor.start();
        
        expect(executor.isStarted, true);
      });

      test('停止后 isStarted 应为 false', () async {
        await executor.start();
        expect(executor.isStarted, true);
        
        await executor.stop();
        
        expect(executor.isStarted, false);
      });

      test('重复停止应安全处理', () async {
        await executor.start();
        
        // 首次停止
        await executor.stop();
        expect(executor.isStarted, false);
        
        // 再次停止不应抛出异常
        await executor.stop();
        expect(executor.isStarted, false);
      });

      test('停止后 Pool 状态应为 null', () async {
        await executor.start();
        expect(executor.crawlerPoolStats, isNotNull);
        expect(executor.similarityPoolStats, isNotNull);
        
        await executor.stop();
        
        expect(executor.crawlerPoolStats, isNull);
        expect(executor.similarityPoolStats, isNull);
      });
    });

    group('错误处理', () {
      test('未启动时搜索应返回错误', () async {
        final result = await executor.search('rule-id', 'test query');
        
        expect(result.isLeft(), true);
      });

      test('未启动时获取详情应返回错误', () async {
        final result = await executor.getDetail('rule-id', 'https://example.com');
        
        expect(result.isLeft(), true);
      });

      test('未启动时获取目录应返回错误', () async {
        final result = await executor.getToc('rule-id', 'https://example.com');
        
        expect(result.isLeft(), true);
      });

      test('未启动时获取内容应返回错误', () async {
        final result = await executor.getContent('rule-id', 'https://example.com');
        
        expect(result.isLeft(), true);
      });

      test('未启动时探索应返回错误', () async {
        final result = await executor.explore('rule-id');
        
        expect(result.isLeft(), true);
      });

      test('未启动时相似度计算应返回默认值', () async {
        final jaccard = await executor.jaccard('a', 'b');
        final levenshtein = await executor.levenshtein('a', 'b');
        final fuzzyScore = await executor.fuzzySearchScore('a', 'b');
        
        expect(jaccard, 0.0);
        expect(levenshtein, 0.0);
        expect(fuzzyScore, 0.0);
      });

      test('未启动时批量相似度计算应返回零列表', () async {
        final results = await executor.batchJaccard('query', ['a', 'b', 'c']);
        
        expect(results, [0.0, 0.0, 0.0]);
      });
    });

    group('配置', () {
      test('自定义配置应正确应用', () async {
        final customExecutor = CrawlerExecutor(
          talker: talker,
          config: const CrawlerExecutorConfig(
            minWorkers: 2,
            maxParallel: 3,
            similarityMaxWorkers: 3,
          ),
        );

        await customExecutor.start();
        
        final crawlerStats = customExecutor.crawlerPoolStats;
        expect(crawlerStats!.size, greaterThanOrEqualTo(2));
        
        await customExecutor.stop();
      });
    });

    group('搜索进度流', () {
      test('未启动时批量搜索应返回失败状态', () async {
        final stream = executor.batchSearch(['rule-1', 'rule-2'], 'test query');
        
        final results = await stream.first;
        
        expect(results.status, SearchStatus.failed);
      });

      test('批量搜索应返回多个源的进度', () async {
        await executor.start();
        
        final stream = executor.batchSearch(['rule-1', 'rule-2'], 'test query');
        
        // 流应该可以正常迭代
        await expectLater(
          stream.take(2).toList(),
          completes,
        );
      });
    });
  });
}
