import 'package:spectra/core/crawler/executor/pipeline_executor.dart';
import 'package:spectra/core/crawler/models/crawler_rule.dart';
import 'package:spectra/core/crawler/models/lifecycle/content_config.dart';
import 'package:spectra/core/crawler/models/pipeline_node.dart';

/// 列表项数据。
class ListItem {
  /// 创建列表项。
  const ListItem({
    required this.fields,
    this.url,
  });

  /// 字段数据。
  final Map<String, String> fields;

  /// 关联的 URL。
  final String? url;
}

/// 详情数据。
class DetailData {
  /// 创建详情数据。
  const DetailData({
    required this.fields,
    this.errors = const [],
  });

  /// 字段数据。
  final Map<String, String> fields;

  /// 错误信息列表。
  final List<String> errors;
}

/// 章节数据。
class Chapter {
  /// 创建章节数据。
  const Chapter({
    required this.fields,
    this.url,
  });

  /// 字段数据。
  final Map<String, String> fields;

  /// 章节链接。
  final String? url;
}

/// 内容数据。
class ContentData {
  /// 创建内容数据。
  const ContentData({
    this.videoUrl,
    this.images = const [],
    this.text,
    this.audioUrl,
    this.errors = const [],
  });

  /// 视频链接。
  final String? videoUrl;

  /// 图片列表。
  final List<String> images;

  /// 文本内容。
  final String? text;

  /// 音频链接。
  final String? audioUrl;

  /// 错误信息列表。
  final List<String> errors;

  /// 是否为空。
  bool get isEmpty =>
      videoUrl == null && images.isEmpty && text == null && audioUrl == null;
}

/// 发现页/分类浏览执行器。
class ExploreExecutor {
  /// 创建发现页执行器。
  ExploreExecutor() : _pipelineExecutor = PipelineExecutor();

  final PipelineExecutor _pipelineExecutor;

  /// 执行发现页/分类浏览。
  ///
  /// [rule] - 爬虫规则。
  /// [html] - 页面 HTML 内容。
  /// [category] - 分类键 (可选)。
  /// [page] - 页码 (可选)。
  ///
  /// 返回提取的列表项。
  List<ListItem> execute(
    CrawlerRule rule,
    String html, {
    String? category,
    int page = 1,
  }) {
    final config = rule.explore;
    if (config == null) {
      return [];
    }

    // 构建上下文
    final context = PipelineContext(
      variables: {
        'host': extractHost(rule.baseUrl) ?? '',
        'category': category ?? '',
        'page': page.toString(),
      },
      baseUrl: rule.baseUrl,
    );

    // 构建 URL
    final url = interpolateUrl(config.url, context);

    return _extractListItems(html, config.list, context, url);
  }

  /// 提取列表项。
  List<ListItem> _extractListItems(
    String html,
    Map<String, Pipeline> listPipeline,
    PipelineContext context,
    String pageUrl,
  ) {
    final items = <ListItem>[];

    // 找到列表容器
    final containerSelector = listPipeline['container'];
    if (containerSelector == null) {
      return items;
    }

    // 执行容器选择器
    final containerResult = _pipelineExecutor.execute(
      html,
      containerSelector.nodes,
      context: context,
    );

    if (!containerResult.isSuccess) {
      return items;
    }

    // 解析每个容器元素
    for (final containerHtml in containerResult.values) {
      final fields = <String, String>{};
      String? url;

      // 执行每个字段的 Pipeline
      for (final entry in listPipeline.entries) {
        if (entry.key == 'container') continue;

        final result = _pipelineExecutor.execute(
          containerHtml,
          entry.value.nodes,
          context: context,
        );

        if (result.isSuccess) {
          fields[entry.key] = result.first ?? '';
        }

        // 提取 URL (常见字段名)
        if (entry.key == 'url' || entry.key == 'link' || entry.key == 'href') {
          url = result.first;
        }
      }

      if (fields.isNotEmpty) {
        items.add(ListItem(fields: fields, url: url));
      }
    }

    return items;
  }

  /// 释放资源。
  void dispose() {
    _pipelineExecutor.dispose();
  }
}

/// 搜索执行器。
class SearchExecutor {
  /// 创建搜索执行器。
  SearchExecutor() : _pipelineExecutor = PipelineExecutor();

  final PipelineExecutor _pipelineExecutor;

  /// 执行搜索。
  ///
  /// [rule] - 爬虫规则。
  /// [html] - 搜索结果页面 HTML 内容。
  /// [keyword] - 搜索关键词。
  /// [page] - 页码 (可选)。
  ///
  /// 返回提取的列表项。
  List<ListItem> execute(
    CrawlerRule rule,
    String html, {
    required String keyword,
    int page = 1,
  }) {
    final config = rule.search;
    if (config == null) {
      return [];
    }

    // 构建上下文
    final context = PipelineContext(
      variables: {
        'host': extractHost(rule.baseUrl) ?? '',
        'key': keyword,
        'page': page.toString(),
        'keyword': keyword,
      },
      baseUrl: rule.baseUrl,
    );

    return _extractListItems(html, config.list, context);
  }

  List<ListItem> _extractListItems(
    String html,
    Map<String, Pipeline> listPipeline,
    PipelineContext context,
  ) {
    final items = <ListItem>[];

    final containerSelector = listPipeline['container'];
    if (containerSelector == null) {
      return items;
    }

    final containerResult = _pipelineExecutor.execute(
      html,
      containerSelector.nodes,
      context: context,
    );

    if (!containerResult.isSuccess) {
      return items;
    }

    for (final containerHtml in containerResult.values) {
      final fields = <String, String>{};
      String? url;

      for (final entry in listPipeline.entries) {
        if (entry.key == 'container') continue;

        final result = _pipelineExecutor.execute(
          containerHtml,
          entry.value.nodes,
          context: context,
        );

        if (result.isSuccess) {
          fields[entry.key] = result.first ?? '';
        }

        if (entry.key == 'url' || entry.key == 'link' || entry.key == 'href') {
          url = result.first;
        }
      }

      if (fields.isNotEmpty) {
        items.add(ListItem(fields: fields, url: url));
      }
    }

    return items;
  }

  /// 释放资源。
  void dispose() {
    _pipelineExecutor.dispose();
  }
}

/// 详情页执行器。
class DetailExecutor {
  /// 创建详情页执行器。
  DetailExecutor() : _pipelineExecutor = PipelineExecutor();

  final PipelineExecutor _pipelineExecutor;

  /// 执行详情页提取。
  ///
  /// [rule] - 爬虫规则。
  /// [html] - 详情页 HTML 内容。
  /// [id] - 资源 ID (可选)。
  ///
  /// 返回提取的详情数据。
  DetailData execute(
    CrawlerRule rule,
    String html, {
    String? id,
  }) {
    final config = rule.detail;
    if (config == null) {
      return const DetailData(fields: {}, errors: ['未配置详情页提取']);
    }

    // 构建上下文
    final context = PipelineContext(
      variables: {
        'host': extractHost(rule.baseUrl) ?? '',
        'id': id ?? '',
      },
      baseUrl: rule.baseUrl,
    );

    final fields = <String, String>{};
    final errors = <String>[];

    // 执行每个字段的 Pipeline
    for (final entry in config.fields.entries) {
      final result = _pipelineExecutor.execute(
        html,
        entry.value.nodes,
        context: context,
      );

      if (result.isSuccess) {
        fields[entry.key] = result.first ?? '';
      } else {
        errors.add('字段 ${entry.key} 提取失败');
      }
    }

    return DetailData(fields: fields, errors: errors);
  }

  /// 释放资源。
  void dispose() {
    _pipelineExecutor.dispose();
  }
}

/// 目录/章节执行器。
class TocExecutor {
  /// 创建目录执行器。
  TocExecutor() : _pipelineExecutor = PipelineExecutor();

  final PipelineExecutor _pipelineExecutor;

  /// 执行目录页提取。
  ///
  /// [rule] - 爬虫规则。
  /// [html] - 目录页 HTML 内容。
  /// [id] - 资源 ID (可选)。
  /// [reverseOrder] - 是否逆序 (可选，覆盖配置)。
  ///
  /// 返回提取的章节列表。
  List<Chapter> execute(
    CrawlerRule rule,
    String html, {
    String? id,
    bool? reverseOrder,
  }) {
    final config = rule.toc;
    if (config == null) {
      return [];
    }

    // 构建上下文
    final context = PipelineContext(
      variables: {
        'host': extractHost(rule.baseUrl) ?? '',
        'id': id ?? '',
      },
      baseUrl: rule.baseUrl,
    );

    // 找到章节容器
    final containerResult = _pipelineExecutor.execute(
      html,
      Pipeline.fromStringList([config.container]).nodes,
      context: context,
    );

    if (!containerResult.isSuccess) {
      return [];
    }

    final chapters = <Chapter>[];

    // 解析每个章节元素
    for (final containerHtml in containerResult.values) {
      final fields = <String, String>{};
      String? url;

      for (final entry in config.fields.entries) {
        final result = _pipelineExecutor.execute(
          containerHtml,
          entry.value.nodes,
          context: context,
        );

        if (result.isSuccess) {
          fields[entry.key] = result.first ?? '';
        }

        if (entry.key == 'url' || entry.key == 'link' || entry.key == 'href') {
          url = result.first;
        }
      }

      if (fields.isNotEmpty) {
        chapters.add(Chapter(fields: fields, url: url));
      }
    }

    // 处理逆序
    final shouldReverse = reverseOrder ?? config.reverseOrder;
    if (shouldReverse) {
      return chapters.reversed.toList();
    }

    return chapters;
  }

  /// 释放资源。
  void dispose() {
    _pipelineExecutor.dispose();
  }
}

/// 内容执行器。
class ContentExecutor {
  /// 创建内容执行器。
  ContentExecutor() : _pipelineExecutor = PipelineExecutor();

  final PipelineExecutor _pipelineExecutor;

  /// 执行内容页提取。
  ///
  /// [rule] - 爬虫规则。
  /// [html] - 内容页 HTML 内容。
  /// [id] - 资源 ID (可选)。
  /// [chapterId] - 章节 ID (可选)。
  ///
  /// 返回提取的内容数据。
  ContentData execute(
    CrawlerRule rule,
    String html, {
    String? id,
    String? chapterId,
  }) {
    final config = rule.content;
    if (config == null) {
      return const ContentData(errors: ['未配置内容提取']);
    }

    // 构建上下文
    final context = PipelineContext(
      variables: {
        'host': extractHost(rule.baseUrl) ?? '',
        'id': id ?? '',
        'chapterId': chapterId ?? '',
      },
      baseUrl: rule.baseUrl,
    );

    switch (config.strategy) {
      case ContentStrategy.parse:
        return _executeParse(config, html, context);
      case ContentStrategy.sniff:
        return _executeSniff(config, html, context);
    }
  }

  /// 执行解析策略。
  ContentData _executeParse(
    ContentConfig config,
    String html,
    PipelineContext context,
  ) {
    final fields = config.fields;
    if (fields == null || fields.isEmpty) {
      return const ContentData(errors: ['未配置解析字段']);
    }

    final fieldValues = <String, String>{};

    for (final entry in fields.entries) {
      final result = _pipelineExecutor.execute(
        html,
        entry.value.nodes,
        context: context,
      );

      if (result.isSuccess) {
        fieldValues[entry.key] = result.first ?? '';
      }
    }

    // 根据内容类型构建结果
    switch (config.type) {
      case MediaContentType.video:
        return ContentData(
          videoUrl: fieldValues['url'] ?? fieldValues['videoUrl'],
        );
      case MediaContentType.comic:
        // 漫画可能是多图，需要特殊处理
        final images = fieldValues['images']?.split(',') ?? [];
        return ContentData(
          images: images.where((s) => s.isNotEmpty).toList(),
        );
      case MediaContentType.novel:
        return ContentData(text: fieldValues['content'] ?? fieldValues['text']);
      case MediaContentType.music:
        return ContentData(
          audioUrl: fieldValues['url'] ?? fieldValues['audioUrl'],
        );
    }
  }

  /// 执行嗅探策略。
  ContentData _executeSniff(
    ContentConfig config,
    String html,
    PipelineContext context,
  ) {
    final sniff = config.sniff;
    if (sniff == null) {
      return const ContentData(errors: ['未配置嗅探规则']);
    }

    final errors = <String>[];
    String? videoUrl;
    final images = <String>[];
    String? text;
    String? audioUrl;

    // 尝试匹配每个正则
    for (final regex in sniff.matchRegex) {
      final match = RegExp(regex).firstMatch(html);
      if (match != null && match.groupCount >= 1) {
        final url = match.group(1);
        if (url != null && url.isNotEmpty) {
          // 根据内容类型判断
          switch (config.type) {
            case MediaContentType.video:
              videoUrl = url;
            case MediaContentType.comic:
              images.add(url);
            case MediaContentType.novel:
              text = url;
            case MediaContentType.music:
              audioUrl = url;
          }
        }
      }
    }

    // 检查排除规则
    if (sniff.excludeRegex != null) {
      for (final regex in sniff.excludeRegex!) {
        if (videoUrl != null && RegExp(regex).hasMatch(videoUrl)) {
          videoUrl = null;
        }
        images.removeWhere((url) => RegExp(regex).hasMatch(url));
        if (text != null && RegExp(regex).hasMatch(text)) {
          text = null;
        }
        if (audioUrl != null && RegExp(regex).hasMatch(audioUrl)) {
          audioUrl = null;
        }
      }
    }

    if (videoUrl == null &&
        images.isEmpty &&
        text == null &&
        audioUrl == null) {
      errors.add('未匹配到内容');
    }

    return ContentData(
      videoUrl: videoUrl,
      images: images,
      text: text,
      audioUrl: audioUrl,
      errors: errors,
    );
  }

  /// 释放资源。
  void dispose() {
    _pipelineExecutor.dispose();
  }
}
