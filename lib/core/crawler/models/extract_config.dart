import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:spectra/core/crawler/models/field_mapping.dart';
import 'package:spectra/core/crawler/models/pagination_config.dart';
import 'package:spectra/core/crawler/models/selector.dart';

part 'extract_config.freezed.dart';
part 'extract_config.g.dart';

/// 列表页提取配置。
@freezed
sealed class ListExtract with _$ListExtract {
  const factory ListExtract({
    /// 列表项容器的选择器。
    required Selector container,

    /// 每个列表项的字段映射。
    required List<FieldMapping> items,

    /// 分页配置。
    PaginationConfig? pagination,

    /// 列表页 URL（可选，如果未指定则使用规则模式）。
    String? url,
  }) = _ListExtract;

  factory ListExtract.fromJson(Map<String, dynamic> json) =>
      _$ListExtractFromJson(json);
}

/// 详情页提取配置。
@freezed
sealed class DetailExtract with _$DetailExtract {
  const factory DetailExtract({
    /// 详情页的字段映射。
    required List<FieldMapping> items,

    /// 从列表项获取详情 URL 的选择器。
    Selector? urlFromList,

    /// 章节/剧集提取（用于漫画、小说、视频）。
    ChapterExtract? chapters,
  }) = _DetailExtract;

  factory DetailExtract.fromJson(Map<String, dynamic> json) =>
      _$DetailExtractFromJson(json);
}

/// 章节提取配置。
@freezed
sealed class ChapterExtract with _$ChapterExtract {
  const factory ChapterExtract({
    /// 章节列表容器的选择器。
    required Selector container,

    /// 每个章节的字段映射。
    required List<FieldMapping> items,

    /// 章节是否为逆序（最新在前）。
    @Default(false) bool reverseOrder,
  }) = _ChapterExtract;

  factory ChapterExtract.fromJson(Map<String, dynamic> json) =>
      _$ChapterExtractFromJson(json);
}

/// 内容提取配置（视频、漫画、小说内容）。
@freezed
sealed class ContentExtract with _$ContentExtract {
  const factory ContentExtract({
    /// 视频提取配置。
    VideoExtract? video,

    /// 漫画提取配置。
    ComicExtract? comic,

    /// 小说提取配置。
    NovelExtract? novel,

    /// 音乐提取配置。
    MusicExtract? music,
  }) = _ContentExtract;

  factory ContentExtract.fromJson(Map<String, dynamic> json) =>
      _$ContentExtractFromJson(json);
}

/// 视频内容提取。
@freezed
sealed class VideoExtract with _$VideoExtract {
  const factory VideoExtract({
    /// 视频 URL 的选择器。
    Selector? playUrl,

    /// 质量选项的选择器。
    Selector? qualities,

    /// 提取视频信息的 JavaScript。
    String? jsExtract,
  }) = _VideoExtract;

  factory VideoExtract.fromJson(Map<String, dynamic> json) =>
      _$VideoExtractFromJson(json);
}

/// 漫画内容提取。
@freezed
sealed class ComicExtract with _$ComicExtract {
  const factory ComicExtract({
    /// 图片 URL 的选择器。
    required Selector images,

    /// 提取图片的 JavaScript。
    String? jsExtract,
  }) = _ComicExtract;

  factory ComicExtract.fromJson(Map<String, dynamic> json) =>
      _$ComicExtractFromJson(json);
}

/// 小说内容提取。
@freezed
sealed class NovelExtract with _$NovelExtract {
  const factory NovelExtract({
    /// 章节内容的选择器。
    required Selector content,

    /// 提取内容的 JavaScript。
    String? jsExtract,
  }) = _NovelExtract;

  factory NovelExtract.fromJson(Map<String, dynamic> json) =>
      _$NovelExtractFromJson(json);
}

/// 音乐内容提取。
@freezed
sealed class MusicExtract with _$MusicExtract {
  const factory MusicExtract({
    /// 音频 URL 的选择器。
    Selector? audioUrl,

    /// 歌词的选择器。
    Selector? lyrics,

    /// 提取音频信息的 JavaScript。
    String? jsExtract,
  }) = _MusicExtract;

  factory MusicExtract.fromJson(Map<String, dynamic> json) =>
      _$MusicExtractFromJson(json);
}

/// 完整的提取配置。
@freezed
sealed class ExtractConfig with _$ExtractConfig {
  const factory ExtractConfig({
    /// 列表页提取。
    ListExtract? list,

    /// 详情页提取。
    DetailExtract? detail,

    /// 内容提取。
    ContentExtract? content,
  }) = _ExtractConfig;

  factory ExtractConfig.fromJson(Map<String, dynamic> json) =>
      _$ExtractConfigFromJson(json);
}
