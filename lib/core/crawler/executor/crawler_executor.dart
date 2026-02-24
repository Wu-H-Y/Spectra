/// 爬虫执行器
///
/// 管理 Worker Pool 并提供爬虫任务的高级 API
library;

import 'dart:async';

import 'package:fpdart/fpdart.dart';
import 'package:spectra/core/crawler/executor/workers/crawler_service.dart';
import 'package:spectra/core/crawler/executor/workers/similarity_service.dart';
import 'package:squadron/squadron.dart';
import 'package:talker/talker.dart';

/// 爬虫执行器配置
///
/// 用于配置 Worker Pool 的大小和并行度
class CrawlerExecutorConfig {
  /// 创建爬虫执行器配置实例。
  const CrawlerExecutorConfig({
    this.minWorkers = 1,
    this.maxWorkers = 4,
    this.maxParallel = 2,
    this.similarityMinWorkers = 1,
    this.similarityMaxWorkers = 2,
  });

  /// 爬虫服务最小 Worker 数
  final int minWorkers;

  /// 爬虫服务最大 Worker 数
  final int maxWorkers;

  /// 每个 Worker 最大并行任务数
  final int maxParallel;

  /// 相似度服务最小 Worker 数
  final int similarityMinWorkers;

  /// 相似度服务最大 Worker 数
  final int similarityMaxWorkers;
}

/// 爬虫执行器
///
/// 管理爬虫 Worker Pool 和相似度计算 Worker Pool
///
/// 使用示例：
/// ```dart
/// final executor = CrawlerExecutor(
///   talker: talker,
///   config: const CrawlerExecutorConfig(
///     minWorkers: 2,
///     maxWorkers: 4,
///   ),
/// );
/// await executor.start();
/// ```
///
/// 管理爬虫 Worker Pool 和相似度计算 Worker Pool
class CrawlerExecutor {
  /// 创建爬虫执行器实例。
  CrawlerExecutor({
    required Talker talker,
    CrawlerExecutorConfig config = const CrawlerExecutorConfig(),
  }) : _talker = talker,
       _config = config;

  final Talker _talker;
  final CrawlerExecutorConfig _config;

  CrawlerServiceWorkerPool? _crawlerPool;
  SimilarityServiceWorkerPool? _similarityPool;

  bool _isStarted = false;

  /// 启动执行器
  Future<void> start() async {
    if (_isStarted) {
      _talker.warning('CrawlerExecutor 已经启动');
      return;
    }

    _talker.info('启动 CrawlerExecutor...');

    // 创建爬虫 Worker Pool
    _crawlerPool = CrawlerServiceWorkerPool(
      concurrencySettings: ConcurrencySettings(
        minWorkers: _config.minWorkers,
        maxWorkers: _config.maxWorkers,
        maxParallel: _config.maxParallel,
      ),
    );

    // 创建相似度计算 Worker Pool
    _similarityPool = SimilarityServiceWorkerPool(
      concurrencySettings: ConcurrencySettings(
        minWorkers: _config.similarityMinWorkers,
        maxWorkers: _config.similarityMaxWorkers,
        maxParallel: 4, // 相似度计算可以并行更多
      ),
    );

    await _crawlerPool!.start();
    await _similarityPool!.start();

    _isStarted = true;
    _talker.info('CrawlerExecutor 启动完成');
  }

  /// 停止执行器
  Future<void> stop() async {
    if (!_isStarted) return;

    _talker.info('停止 CrawlerExecutor...');

    _crawlerPool?.stop();
    _similarityPool?.stop();

    _crawlerPool = null;
    _similarityPool = null;
    _isStarted = false;

    _talker.info('CrawlerExecutor 已停止');
  }

  /// 执行搜索
  Future<Either<CrawlerError, List<Map<String, dynamic>>>> search(
    String ruleId,
    String query, {
    int? page,
  }) async {
    if (!_isStarted) {
      return left(CrawlerError('执行器未启动'));
    }

    try {
      final results = await _crawlerPool!.search(ruleId, query, page);
      return right(results);
    } on Exception catch (e, st) {
      _talker.error('搜索失败', e, st);
      return left(CrawlerError('搜索失败: $e'));
    }
  }

  /// 批量搜索 (流式返回)
  Stream<SearchProgress> batchSearch(
    List<String> ruleIds,
    String query,
  ) {
    if (!_isStarted) {
      return Stream.value(
        const SearchProgress(
          ruleId: '',
          status: SearchStatus.failed,
          error: '执行器未启动',
        ),
      );
    }

    return _crawlerPool!.batchSearch(ruleIds, query);
  }

  /// 获取详情
  Future<Either<CrawlerError, Map<String, dynamic>?>> getDetail(
    String ruleId,
    String url,
  ) async {
    if (!_isStarted) {
      return left(CrawlerError('执行器未启动'));
    }

    try {
      final result = await _crawlerPool!.getDetail(ruleId, url);
      return right(result);
    } on Exception catch (e, st) {
      _talker.error('获取详情失败', e, st);
      return left(CrawlerError('获取详情失败: $e'));
    }
  }

  /// 获取目录
  Future<Either<CrawlerError, List<Map<String, dynamic>>>> getToc(
    String ruleId,
    String url, {
    int? page,
  }) async {
    if (!_isStarted) {
      return left(CrawlerError('执行器未启动'));
    }

    try {
      final results = await _crawlerPool!.getToc(ruleId, url, page);
      return right(results);
    } on Exception catch (e, st) {
      _talker.error('获取目录失败', e, st);
      return left(CrawlerError('获取目录失败: $e'));
    }
  }

  /// 获取内容
  Future<Either<CrawlerError, Map<String, dynamic>?>> getContent(
    String ruleId,
    String url,
  ) async {
    if (!_isStarted) {
      return left(CrawlerError('执行器未启动'));
    }

    try {
      final result = await _crawlerPool!.getContent(ruleId, url);
      return right(result);
    } on Exception catch (e, st) {
      _talker.error('获取内容失败', e, st);
      return left(CrawlerError('获取内容失败: $e'));
    }
  }

  /// 执行探索
  Future<Either<CrawlerError, List<Map<String, dynamic>>>> explore(
    String ruleId, {
    String? categoryId,
    int? page,
  }) async {
    if (!_isStarted) {
      return left(CrawlerError('执行器未启动'));
    }

    try {
      final results = await _crawlerPool!.explore(ruleId, categoryId, page);
      return right(results);
    } on Exception catch (e, st) {
      _talker.error('探索失败', e, st);
      return left(CrawlerError('探索失败: $e'));
    }
  }

  // ============ 相似度计算 API ============

  /// 计算 Jaccard 相似度
  Future<double> jaccard(String a, String b) async {
    if (!_isStarted) return 0.0;
    return _similarityPool!.jaccard(a, b);
  }

  /// 计算 Levenshtein 相似度
  Future<double> levenshtein(String a, String b) async {
    if (!_isStarted) return 0.0;
    return _similarityPool!.levenshtein(a, b);
  }

  /// 标准化标题
  Future<String> normalizeTitle(String title) async {
    if (!_isStarted) return title;
    return _similarityPool!.normalizeTitle(title);
  }

  /// 模糊搜索评分
  Future<double> fuzzySearchScore(String query, String target) async {
    if (!_isStarted) return 0.0;
    return _similarityPool!.fuzzySearchScore(query, target);
  }

  /// 批量计算 Jaccard 相似度
  Future<List<double>> batchJaccard(String query, List<String> targets) async {
    if (!_isStarted) return List.filled(targets.length, 0);
    return _similarityPool!.batchJaccard(query, targets);
  }

  // ============ 状态监控 ============

  /// 获取爬虫 Pool 状态
  PoolStats? get crawlerPoolStats {
    if (_crawlerPool == null) return null;
    return PoolStats(
      size: _crawlerPool!.size,
      pendingWorkload: _crawlerPool!.pendingWorkload,
    );
  }

  /// 获取相似度 Pool 状态
  PoolStats? get similarityPoolStats {
    if (_similarityPool == null) return null;
    return PoolStats(
      size: _similarityPool!.size,
      pendingWorkload: _similarityPool!.pendingWorkload,
    );
  }

  /// 是否已启动
  bool get isStarted => _isStarted;
}

/// Worker Pool 状态
///
/// 包含 Worker Pool 的当前状态信息
class PoolStats {
  /// 创建 PoolStats 实例。
  const PoolStats({
    required this.size,
    required this.pendingWorkload,
  });

  /// 当前 Worker 数量
  final int size;

  /// 等待执行的任务数量
  final int pendingWorkload;
}

/// 爬虫错误
///
/// 表示爬虫执行过程中的错误信息
class CrawlerError {
  /// 创建 CrawlerError 实例。
  CrawlerError(this.message);

  /// 错误消息
  final String message;

  @override
  String toString() => message;
}
