/// 爬虫执行 Worker Service
///
/// 使用 Squadron 在独立 Isolate 中执行爬虫任务，
/// 避免阻塞 UI 线程
library;

import 'dart:async';

import 'package:spectra/core/crawler/executor/workers/crawler_service.activator.g.dart';
import 'package:squadron/squadron.dart';

part 'crawler_service.worker.g.dart';

/// 爬虫执行服务
///
/// 在独立线程中执行爬虫任务，支持：
/// - 搜索
/// - 获取详情
/// - 获取目录
/// - 获取内容
@SquadronService(
  baseUrl: '~/workers',
)
base class CrawlerService {
  /// 执行搜索
  ///
  /// [ruleId] 规则 ID
  /// [query] 搜索关键词
  /// [page] 页码 (可选)
  ///
  /// 返回搜索结果列表
  @SquadronMethod()
  FutureOr<List<Map<String, dynamic>>> search(
    String ruleId,
    String query, [
    int? page,
  ]) {
    return _executeSearch(ruleId, query, page);
  }

  /// 获取详情
  ///
  /// [ruleId] 规则 ID
  /// [url] 详情页 URL
  ///
  /// 返回详情数据
  @SquadronMethod()
  FutureOr<Map<String, dynamic>?> getDetail(String ruleId, String url) {
    return _executeGetDetail(ruleId, url);
  }

  /// 获取目录
  ///
  /// [ruleId] 规则 ID
  /// [url] 详情页 URL
  /// [page] 页码 (可选)
  ///
  /// 返回章节列表
  @SquadronMethod()
  FutureOr<List<Map<String, dynamic>>> getToc(
    String ruleId,
    String url, [
    int? page,
  ]) {
    return _executeGetToc(ruleId, url, page);
  }

  /// 获取内容
  ///
  /// [ruleId] 规则 ID
  /// [url] 章节页 URL
  ///
  /// 返回内容数据
  @SquadronMethod()
  FutureOr<Map<String, dynamic>?> getContent(String ruleId, String url) {
    return _executeGetContent(ruleId, url);
  }

  /// 执行探索 (发现页)
  ///
  /// [ruleId] 规则 ID
  /// [categoryId] 分类 ID (可选)
  /// [page] 页码 (可选)
  ///
  /// 返回探索结果列表
  @SquadronMethod()
  FutureOr<List<Map<String, dynamic>>> explore(
    String ruleId, [
    String? categoryId,
    int? page,
  ]) {
    return _executeExplore(ruleId, categoryId, page);
  }

  /// 批量搜索 (流式返回进度)
  ///
  /// [ruleIds] 规则 ID 列表
  /// [query] 搜索关键词
  ///
  /// 流式返回搜索结果，每个结果包含源 ID
  @SquadronMethod()
  Stream<SearchProgress> batchSearch(
    List<String> ruleIds,
    String query,
  ) async* {
    for (final ruleId in ruleIds) {
      try {
        final results = await _executeSearch(ruleId, query, null);
        yield SearchProgress(
          ruleId: ruleId,
          status: SearchStatus.completed,
          results: results,
        );
      } on Exception catch (e) {
        yield SearchProgress(
          ruleId: ruleId,
          status: SearchStatus.failed,
          error: e.toString(),
        );
      }
    }
  }

  // ============ 内部实现 ============

  Future<List<Map<String, dynamic>>> _executeSearch(
    String ruleId,
    String query,
    int? page,
  ) async {
    // TODO(username): 实现实际的搜索逻辑
    // 1. 从数据库加载规则
    // 2. 解析规则配置
    // 3. 构建 HTTP 请求
    // 4. 执行请求
    // 5. 解析响应
    // 6. 返回结果

    // 临时实现：返回空列表
    return [];
  }

  Future<Map<String, dynamic>?> _executeGetDetail(
    String ruleId,
    String url,
  ) async {
    // TODO(username): 实现实际的详情获取逻辑
    return null;
  }

  Future<List<Map<String, dynamic>>> _executeGetToc(
    String ruleId,
    String url,
    int? page,
  ) async {
    // TODO(username): 实现实际的目录获取逻辑
    return [];
  }

  Future<Map<String, dynamic>?> _executeGetContent(
    String ruleId,
    String url,
  ) async {
    // TODO(username): 实现实际的内容获取逻辑
    return null;
  }

  Future<List<Map<String, dynamic>>> _executeExplore(
    String ruleId,
    String? categoryId,
    int? page,
  ) async {
    // TODO(username): 实现实际的探索逻辑
    return [];
  }
}

/// 搜索进度
///
/// 用于表示单个搜索请求的执行结果
class SearchProgress {
  /// 创建 SearchProgress 实例。
  const SearchProgress({
    required this.ruleId,
    required this.status,
    this.results,
    this.error,
  });

  /// 规则 ID
  final String ruleId;

  /// 搜索状态
  final SearchStatus status;

  /// 搜索结果 (status == completed 时有效)
  final List<Map<String, dynamic>>? results;

  /// 错误信息 (status == failed 时有效)
  final String? error;
}

/// 搜索状态
enum SearchStatus {
  /// 进行中
  pending,

  /// 已完成
  completed,

  /// 已失败
  failed,
}
