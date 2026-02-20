import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;

import 'package:spectra/core/crawler/models/extract_config.dart';
import 'package:spectra/core/crawler/models/field_mapping.dart';
import 'package:spectra/core/crawler/selector/selector_engine.dart';

/// 带字段值的提取项。
class ExtractedItem {
  /// 创建提取项。
  const ExtractedItem({
    required this.fields,
    this.url,
    this.rawHtml,
  });

  /// 按字段名索引的字段值。
  final Map<String, String> fields;

  /// 此项的来源 URL。
  final String? url;

  /// 容器元素的原始 HTML。
  final String? rawHtml;

  /// 按名称获取字段值。
  String? operator [](String fieldName) => fields[fieldName];

  /// 返回带有额外字段的副本。
  ExtractedItem copyWith({
    Map<String, String>? fields,
    String? url,
    String? rawHtml,
  }) {
    return ExtractedItem(
      fields: fields ?? this.fields,
      url: url ?? this.url,
      rawHtml: rawHtml ?? this.rawHtml,
    );
  }
}

/// 列表提取结果。
class ListExtractionResult {
  /// 创建列表提取结果。
  const ListExtractionResult({
    required this.items,
    this.nextPageUrl,
    this.hasMore = false,
    this.errors = const [],
  });

  /// 提取的项目。
  final List<ExtractedItem> items;

  /// 下一页的 URL（如果是基于 URL 的分页）。
  final String? nextPageUrl;

  /// 是否还有更多页面。
  final bool hasMore;

  /// 提取过程中遇到的错误。
  final List<String> errors;
}

/// 详情提取结果。
class DetailExtractionResult {
  /// 创建详情提取结果。
  const DetailExtractionResult({
    required this.fields,
    this.chapters = const [],
    this.errors = const [],
  });

  /// 提取的字段值。
  final Map<String, String> fields;

  /// 提取的章节（如果有）。
  final List<ExtractedItem> chapters;

  /// 遇到的错误。
  final List<String> errors;
}

/// 内容提取结果。
class ContentExtractionResult {
  /// 创建内容提取结果。
  const ContentExtractionResult({
    this.videoUrl,
    this.qualities = const [],
    this.images = const [],
    this.content,
    this.audioUrl,
    this.lyrics,
    this.errors = const [],
  });

  /// 视频 URL（视频内容）。
  final String? videoUrl;

  /// 可用的质量选项。
  final List<String> qualities;

  /// 图片 URL（漫画内容）。
  final List<String> images;

  /// 文本内容（小说内容）。
  final String? content;

  /// 音频 URL（音乐内容）。
  final String? audioUrl;

  /// 歌词（音乐内容）。
  final String? lyrics;

  /// 遇到的错误。
  final List<String> errors;

  /// 提取是否成功。
  bool get isSuccess => errors.isEmpty && hasContent;

  /// 是否提取了任何内容。
  bool get hasContent =>
      videoUrl != null ||
      images.isNotEmpty ||
      content != null ||
      audioUrl != null;
}

/// 列表页提取器。
class ListExtractor {
  /// 创建列表提取器。
  ListExtractor({
    SelectorEngine? selectorEngine,
  }) : _selectorEngine = selectorEngine ?? SelectorEngine();

  final SelectorEngine _selectorEngine;

  /// 从列表页提取项目。
  ///
  /// [html] - HTML 内容。
  /// [config] - 列表提取配置。
  /// [baseUrl] - 用于解析相对 URL 的基础 URL。
  ///
  /// 返回包含提取项目的 [ListExtractionResult]。
  ListExtractionResult extract(
    String html,
    ListExtract config, {
    String? baseUrl,
  }) {
    final errors = <String>[];
    final items = <ExtractedItem>[];
    String? nextPageUrl;
    var hasMore = false;

    try {
      final document = html_parser.parse(html);

      // 查找所有容器元素
      final containerSelector = config.container;
      final containerResult = _selectorEngine.evaluate(html, containerSelector);

      if (!containerResult.success) {
        errors.add('未找到容器: ${containerResult.error}');
        return ListExtractionResult(items: [], errors: errors);
      }

      // 再次解析 HTML 以获取实际元素
      final containerElements = document.querySelectorAll(
        containerSelector.expression,
      );

      for (final container in containerElements) {
        final item = _extractItem(container, config.items, baseUrl);
        if (item != null) {
          items.add(item);
        }
      }

      // 处理分页
      if (config.pagination != null) {
        final pagination = config.pagination!;
        if (pagination.nextSelector != null) {
          final nextResult = _selectorEngine.evaluate(
            html,
            pagination.nextSelector!,
          );
          if (nextResult.success && nextResult.values.isNotEmpty) {
            nextPageUrl = nextResult.first;
            hasMore = true;
          }
        }
      }
    } on Exception catch (e) {
      errors.add('提取错误: $e');
    }

    return ListExtractionResult(
      items: items,
      nextPageUrl: nextPageUrl,
      hasMore: hasMore,
      errors: errors,
    );
  }

  ExtractedItem? _extractItem(
    dom.Element container,
    List<FieldMapping> fieldMappings,
    String? baseUrl,
  ) {
    final fields = <String, String>{};
    final containerHtml = container.outerHtml;

    for (final mapping in fieldMappings) {
      final result = _selectorEngine.evaluate(containerHtml, mapping.selector);

      String? value;
      if (result.success && result.values.isNotEmpty) {
        value = result.first;
      } else if (mapping.defaultValue != null) {
        value = mapping.defaultValue;
      } else if (mapping.required) {
        return null; // 必需字段缺失
      }

      if (value != null) {
        fields[mapping.field] = value;
      }
    }

    return ExtractedItem(
      fields: fields,
      rawHtml: containerHtml,
    );
  }
}

/// 详情页提取器。
class DetailExtractor {
  /// 创建详情提取器。
  DetailExtractor({
    SelectorEngine? selectorEngine,
  }) : _selectorEngine = selectorEngine ?? SelectorEngine();

  final SelectorEngine _selectorEngine;

  /// 从详情页提取数据。
  ///
  /// [html] - HTML 内容。
  /// [config] - 详情提取配置。
  /// [baseUrl] - 用于解析相对 URL 的基础 URL。
  ///
  /// 返回包含提取数据的 [DetailExtractionResult]。
  DetailExtractionResult extract(
    String html,
    DetailExtract config, {
    String? baseUrl,
  }) {
    final errors = <String>[];
    final fields = <String, String>{};
    final chapters = <ExtractedItem>[];

    try {
      // 提取字段
      for (final mapping in config.items) {
        final result = _selectorEngine.evaluate(html, mapping.selector);

        String? value;
        if (result.success && result.values.isNotEmpty) {
          value = result.first;
        } else if (mapping.defaultValue != null) {
          value = mapping.defaultValue;
        }

        if (value != null) {
          fields[mapping.field] = value;
        }
      }

      // 如果配置了章节则提取
      if (config.chapters != null) {
        final chapterConfig = config.chapters!;
        final document = html_parser.parse(html);
        final chapterElements = document.querySelectorAll(
          chapterConfig.container.expression,
        );

        for (final chapter in chapterElements) {
          final chapterItem = _extractChapterItem(
            chapter,
            chapterConfig.items,
          );
          if (chapterItem != null) {
            chapters.add(chapterItem);
          }
        }

        // 如果需要则反转（最新在前）
        if (chapterConfig.reverseOrder) {
          chapters.addAll(chapters.reversed);
        }
      }
    } on Exception catch (e) {
      errors.add('提取错误: $e');
    }

    return DetailExtractionResult(
      fields: fields,
      chapters: chapters,
      errors: errors,
    );
  }

  ExtractedItem? _extractChapterItem(
    dom.Element container,
    List<FieldMapping> fieldMappings,
  ) {
    final fields = <String, String>{};
    final containerHtml = container.outerHtml;

    for (final mapping in fieldMappings) {
      final result = _selectorEngine.evaluate(containerHtml, mapping.selector);

      String? value;
      if (result.success && result.values.isNotEmpty) {
        value = result.first;
      } else if (mapping.defaultValue != null) {
        value = mapping.defaultValue;
      } else if (mapping.required) {
        return null;
      }

      if (value != null) {
        fields[mapping.field] = value;
      }
    }

    return ExtractedItem(fields: fields, rawHtml: containerHtml);
  }
}

/// 媒体内容提取器。
class ContentExtractor {
  /// 创建内容提取器。
  ContentExtractor({
    SelectorEngine? selectorEngine,
  }) : _selectorEngine = selectorEngine ?? SelectorEngine();

  final SelectorEngine _selectorEngine;

  /// 从内容页提取内容。
  ///
  /// [html] - HTML 内容。
  /// [config] - 内容提取配置。
  ///
  /// 返回包含提取内容的 [ContentExtractionResult]。
  ContentExtractionResult extract(String html, ContentExtract config) {
    final errors = <String>[];

    // 提取视频内容
    if (config.video != null) {
      return _extractVideo(html, config.video!, errors);
    }

    // 提取漫画内容
    if (config.comic != null) {
      return _extractComic(html, config.comic!, errors);
    }

    // 提取小说内容
    if (config.novel != null) {
      return _extractNovel(html, config.novel!, errors);
    }

    // 提取音乐内容
    if (config.music != null) {
      return _extractMusic(html, config.music!, errors);
    }

    errors.add('未提供内容提取配置');
    return ContentExtractionResult(errors: errors);
  }

  ContentExtractionResult _extractVideo(
    String html,
    VideoExtract config,
    List<String> errors,
  ) {
    String? videoUrl;
    final qualities = <String>[];

    if (config.playUrl != null) {
      final result = _selectorEngine.evaluate(html, config.playUrl!);
      if (result.success) {
        videoUrl = result.first;
      }
    }

    if (config.qualities != null) {
      final result = _selectorEngine.evaluate(html, config.qualities!);
      if (result.success) {
        qualities.addAll(result.values);
      }
    }

    return ContentExtractionResult(
      videoUrl: videoUrl,
      qualities: qualities,
      errors: videoUrl == null ? ['未找到视频 URL'] : [],
    );
  }

  ContentExtractionResult _extractComic(
    String html,
    ComicExtract config,
    List<String> errors,
  ) {
    final images = <String>[];

    final result = _selectorEngine.evaluate(html, config.images);
    if (result.success) {
      images.addAll(result.values);
    }

    return ContentExtractionResult(
      images: images,
      errors: images.isEmpty ? ['未找到图片'] : [],
    );
  }

  ContentExtractionResult _extractNovel(
    String html,
    NovelExtract config,
    List<String> errors,
  ) {
    String? content;

    final result = _selectorEngine.evaluate(html, config.content);
    if (result.success) {
      content = result.first;
    }

    return ContentExtractionResult(
      content: content,
      errors: content == null ? ['未找到内容'] : [],
    );
  }

  ContentExtractionResult _extractMusic(
    String html,
    MusicExtract config,
    List<String> errors,
  ) {
    String? audioUrl;
    String? lyrics;

    if (config.audioUrl != null) {
      final result = _selectorEngine.evaluate(html, config.audioUrl!);
      if (result.success) {
        audioUrl = result.first;
      }
    }

    if (config.lyrics != null) {
      final result = _selectorEngine.evaluate(html, config.lyrics!);
      if (result.success) {
        lyrics = result.first;
      }
    }

    return ContentExtractionResult(
      audioUrl: audioUrl,
      lyrics: lyrics,
      errors: audioUrl == null ? ['未找到音频 URL'] : [],
    );
  }
}
