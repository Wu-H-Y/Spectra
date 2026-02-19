import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/selector.dart';

part 'pagination_config.freezed.dart';
part 'pagination_config.g.dart';

/// Pagination type.
@JsonEnum()
enum PaginationType {
  /// URL-based pagination (page=1, page=2, etc.).
  url,

  /// Click-based pagination ("Load more" button).
  click,

  /// Infinite scroll pagination.
  infiniteScroll,
}

/// Pagination configuration.
@freezed
sealed class PaginationConfig with _$PaginationConfig {
  const factory PaginationConfig({
    /// Pagination type.
    required PaginationType type,

    /// Selector for next page link (for URL type).
    Selector? nextSelector,

    /// URL template with page placeholder (for URL type).
    /// Use {page} as placeholder, e.g., "list?page={page}"
    String? urlTemplate,

    /// Selector for "Load more" button (for click type).
    Selector? clickSelector,

    /// Scroll container selector (for infiniteScroll type).
    Selector? scrollContainer,

    /// Maximum pages to crawl (0 = unlimited).
    @Default(0) int maxPages,

    /// Delay between page requests in milliseconds.
    @Default(1000) int delayMs,

    /// Wait for content to load after pagination.
    @Default(2000) int waitAfterLoadMs,
  }) = _PaginationConfig;

  factory PaginationConfig.fromJson(Map<String, dynamic> json) =>
      _$PaginationConfigFromJson(json);
}
