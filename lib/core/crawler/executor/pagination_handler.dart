import 'package:spectra/core/crawler/models/pagination_config.dart';
import 'package:spectra/core/crawler/selector/selector_engine.dart';

/// 分页结果，包含下一页信息。
class PaginationResult {
  /// 创建分页结果。
  const PaginationResult({
    this.nextUrl,
    this.hasMore = false,
    this.needsClick = false,
    this.needsScroll = false,
    this.error,
  });

  /// 下一页的 URL（基于 URL 的分页）。
  final String? nextUrl;

  /// 是否还有更多页面。
  final bool hasMore;

  /// 是否需要点击（基于点击的分页）。
  final bool needsClick;

  /// 是否需要滚动（无限滚动分页）。
  final bool needsScroll;

  /// 分页失败时的错误信息。
  final String? error;
}

/// 处理不同分页类型的处理器。
class PaginationHandler {
  /// 创建分页处理器。
  PaginationHandler({
    SelectorEngine? selectorEngine,
  }) : _selectorEngine = selectorEngine ?? SelectorEngine();

  final SelectorEngine _selectorEngine;

  /// 从 HTML 内容获取下一页信息。
  ///
  /// [html] - HTML 内容。
  /// [config] - 分页配置。
  /// [currentPage] - 当前页码。
  ///
  /// 返回包含下一页信息的 [PaginationResult]。
  PaginationResult getNextPage(
    String html,
    PaginationConfig config,
    int currentPage,
  ) {
    // 检查最大页数限制
    if (config.maxPages > 0 && currentPage >= config.maxPages) {
      return const PaginationResult();
    }

    switch (config.type) {
      case PaginationType.url:
        return _handleUrlPagination(html, config, currentPage);
      case PaginationType.click:
        return _handleClickPagination(html, config);
      case PaginationType.infiniteScroll:
        return _handleInfiniteScrollPagination(html, config);
    }
  }

  PaginationResult _handleUrlPagination(
    String html,
    PaginationConfig config,
    int currentPage,
  ) {
    // 如果提供了 URL 模板，生成下一页 URL
    if (config.urlTemplate != null) {
      final nextUrl = config.urlTemplate!.replaceAll(
        '{page}',
        (currentPage + 1).toString(),
      );
      return PaginationResult(nextUrl: nextUrl, hasMore: true);
    }

    // 否则，尝试查找下一页链接
    if (config.nextSelector != null) {
      final result = _selectorEngine.evaluate(html, config.nextSelector!);
      if (result.success && result.values.isNotEmpty) {
        return PaginationResult(nextUrl: result.first, hasMore: true);
      }
    }

    return const PaginationResult();
  }

  PaginationResult _handleClickPagination(
    String html,
    PaginationConfig config,
  ) {
    if (config.clickSelector == null) {
      return const PaginationResult(
        error: '未配置点击选择器',
      );
    }

    // 检查"加载更多"按钮是否存在
    final result = _selectorEngine.evaluate(html, config.clickSelector!);
    if (result.success && result.values.isNotEmpty) {
      return const PaginationResult(
        hasMore: true,
        needsClick: true,
      );
    }

    return const PaginationResult();
  }

  PaginationResult _handleInfiniteScrollPagination(
    String html,
    PaginationConfig config,
  ) {
    // 对于无限滚动，我们假设总是有更多内容
    // 除非设置了最大页数限制
    return const PaginationResult(
      hasMore: true,
      needsScroll: true,
    );
  }

  /// 从模板生成 URL。
  ///
  /// [template] - 带有 {page} 占位符的 URL 模板。
  /// [pageNumber] - 要插入的页码。
  ///
  /// 返回生成的 URL。
  String generatePageUrl(String template, int pageNumber) {
    return template.replaceAll('{page}', pageNumber.toString());
  }

  /// 计算分页延迟。
  ///
  /// [config] - 分页配置。
  ///
  /// 返回延迟时间（毫秒）。
  int getDelay(PaginationConfig config) {
    return config.delayMs;
  }

  /// 计算页面加载后的等待时间。
  ///
  /// [config] - 分页配置。
  ///
  /// 返回等待时间（毫秒）。
  int getWaitTime(PaginationConfig config) {
    return config.waitAfterLoadMs;
  }
}

/// 用于遍历分页内容的页面迭代器。
class PageIterator {
  /// 创建页面迭代器。
  PageIterator({
    required this.config,
    required this.fetchPage,
    PaginationHandler? handler,
  }) : _handler = handler ?? PaginationHandler();

  /// 分页配置。
  final PaginationConfig config;

  /// 通过 URL 获取页面的函数。
  final Future<String?> Function(String url) fetchPage;

  final PaginationHandler _handler;

  int _currentPage = 1;
  String? _nextUrl;
  bool _hasMore = true;

  /// 当前页码。
  int get currentPage => _currentPage;

  /// 是否还有更多页面。
  bool get hasMore => _hasMore;

  /// 下一页 URL（如果已知）。
  String? get nextUrl => _nextUrl;

  /// 重置迭代器。
  void reset() {
    _currentPage = 1;
    _nextUrl = null;
    _hasMore = true;
  }

  /// 获取下一页 HTML。
  ///
  /// 如果没有更多页面则返回 null。
  Future<String?> next() async {
    if (!_hasMore) return null;

    // 检查最大页数
    if (config.maxPages > 0 && _currentPage > config.maxPages) {
      _hasMore = false;
      return null;
    }

    // 获取页面内容
    String? html;
    if (_nextUrl != null) {
      html = await fetchPage(_nextUrl!);
    } else if (_currentPage == 1 && config.urlTemplate != null) {
      final url = _handler.generatePageUrl(config.urlTemplate!, _currentPage);
      html = await fetchPage(url);
    }

    if (html == null) {
      _hasMore = false;
      return null;
    }

    // 获取下一页信息
    final result = _handler.getNextPage(html, config, _currentPage);

    _hasMore = result.hasMore;
    _nextUrl = result.nextUrl;
    _currentPage++;

    return html;
  }
}
