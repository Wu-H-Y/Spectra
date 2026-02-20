import 'dart:convert';

import 'package:spectra/core/crawler/models/action.dart';
import 'package:spectra/core/crawler/models/crawler_rule.dart';
import 'package:spectra/core/crawler/models/extract_config.dart';
import 'package:spectra/core/crawler/models/field_mapping.dart';
import 'package:spectra/core/crawler/models/match_config.dart';
import 'package:spectra/core/crawler/models/media_type.dart';

/// 规则解析结果。
class RuleParseResult {
  /// 创建规则解析结果。
  const RuleParseResult({
    this.rule,
    this.errors = const [],
  });

  /// 创建成功的结果。
  const RuleParseResult.success(CrawlerRule rule) : this(rule: rule);

  /// 创建失败的结果。
  const RuleParseResult.failure(List<String> errors) : this(errors: errors);

  /// 解析的规则（如果解析失败则为 null）。
  final CrawlerRule? rule;

  /// 验证错误。
  final List<String> errors;

  /// 解析是否成功。
  bool get isSuccess => rule != null && errors.isEmpty;

  /// 是否有错误。
  bool get hasErrors => errors.isNotEmpty;
}

/// 将 JSON 规则定义转换为 CrawlerRule 模型的解析器。
class RuleParser {
  /// 将 JSON 字符串解析为 CrawlerRule。
  ///
  /// [jsonString] - 要解析的 JSON 字符串。
  ///
  /// 返回包含解析的规则或错误的 [RuleParseResult]。
  RuleParseResult parseString(String jsonString) {
    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return parseJson(json);
    } on FormatException catch (e) {
      return RuleParseResult.failure(['无效的 JSON: ${e.message}']);
    } on Exception catch (e) {
      return RuleParseResult.failure(['解析 JSON 失败: $e']);
    }
  }

  /// 将 JSON map 解析为 CrawlerRule。
  ///
  /// [json] - 要解析的 JSON map。
  ///
  /// 返回包含解析的规则或错误的 [RuleParseResult]。
  RuleParseResult parseJson(Map<String, dynamic> json) {
    final errors = <String>[];

    // 验证必需字段
    _validateRequiredFields(json, errors);

    // 如果有验证错误，提前返回
    if (errors.isNotEmpty) {
      return RuleParseResult.failure(errors);
    }

    try {
      final rule = CrawlerRule.fromJson(json);
      return RuleParseResult.success(rule);
    } on Exception catch (e) {
      return RuleParseResult.failure(['创建规则失败: $e']);
    }
  }

  void _validateRequiredFields(Map<String, dynamic> json, List<String> errors) {
    // 检查必需的顶级字段
    final id = json['id'];
    if (id == null || (id is String && id.isEmpty)) {
      errors.add('缺少必需字段: id');
    }

    final name = json['name'];
    if (name == null || (name is String && name.isEmpty)) {
      errors.add('缺少必需字段: name');
    }

    final mediaType = json['mediaType'];
    if (mediaType == null || (mediaType is String && mediaType.isEmpty)) {
      errors.add('缺少必需字段: mediaType');
    }

    if (!json.containsKey('match')) {
      errors.add('缺少必需字段: match');
    }

    if (!json.containsKey('extract')) {
      errors.add('缺少必需字段: extract');
    }
  }

  /// 验证规则并返回任何验证错误。
  ///
  /// [rule] - 要验证的规则。
  ///
  /// 返回验证错误列表（如果有效则为空）。
  List<String> validate(CrawlerRule rule) {
    final errors = <String>[];

    // 验证 ID
    if (rule.id.isEmpty) {
      errors.add('规则 ID 不能为空');
    }

    // 验证名称
    if (rule.name.isEmpty) {
      errors.add('规则名称不能为空');
    }

    // 验证匹配配置
    _validateMatchConfig(rule, errors);

    // 验证提取配置
    _validateExtractConfig(rule, errors);

    // 验证前置动作
    if (rule.beforeActions != null) {
      for (var i = 0; i < rule.beforeActions!.length; i++) {
        _validateAction(rule.beforeActions![i], 'beforeActions[$i]', errors);
      }
    }

    // 验证后置动作
    if (rule.afterActions != null) {
      for (var i = 0; i < rule.afterActions!.length; i++) {
        _validateAction(rule.afterActions![i], 'afterActions[$i]', errors);
      }
    }

    return errors;
  }

  void _validateMatchConfig(CrawlerRule rule, List<String> errors) {
    final match = rule.match;

    // 必须指定模式
    if (match.pattern.isEmpty) {
      errors.add('match.pattern: URL 模式是必需的');
    }

    // 如果类型是 regex 则验证正则表达式模式
    if (match.type == MatchPatternType.regex) {
      try {
        RegExp(match.pattern);
      } on Exception catch (e) {
        errors.add('match.pattern: 无效的正则表达式模式: $e');
      }
    }

    // 验证包含模式
    if (match.includePatterns != null) {
      for (var i = 0; i < match.includePatterns!.length; i++) {
        if (match.includePatterns![i].isEmpty) {
          errors.add('match.includePatterns[$i]: 模式不能为空');
        }
      }
    }

    // 验证排除模式
    if (match.excludePatterns != null) {
      for (var i = 0; i < match.excludePatterns!.length; i++) {
        if (match.excludePatterns![i].isEmpty) {
          errors.add('match.excludePatterns[$i]: 模式不能为空');
        }
      }
    }
  }

  void _validateExtractConfig(CrawlerRule rule, List<String> errors) {
    final extract = rule.extract;

    // 至少应该有一个提取配置
    if (extract.list == null &&
        extract.detail == null &&
        extract.content == null) {
      errors.add(
        'extract: list、detail 或 content 提取中至少需要一个',
      );
    }

    // 验证列表提取
    if (extract.list != null) {
      _validateListExtract(extract.list!, errors);
    }

    // 验证详情提取
    if (extract.detail != null) {
      _validateDetailExtract(extract.detail!, errors);
    }

    // 验证内容提取
    if (extract.content != null) {
      _validateContentExtract(extract.content!, rule.mediaType, errors);
    }
  }

  void _validateListExtract(ListExtract list, List<String> errors) {
    if (list.container.expression.isEmpty) {
      errors.add('extract.list.container: 选择器表达式是必需的');
    }

    if (list.items.isEmpty) {
      errors.add('extract.list.items: 至少需要一个字段映射');
    } else {
      for (var i = 0; i < list.items.length; i++) {
        _validateFieldMapping(list.items[i], 'extract.list.items[$i]', errors);
      }
    }
  }

  void _validateDetailExtract(DetailExtract detail, List<String> errors) {
    if (detail.items.isEmpty) {
      errors.add('extract.detail.items: 至少需要一个字段映射');
    } else {
      for (var i = 0; i < detail.items.length; i++) {
        _validateFieldMapping(
          detail.items[i],
          'extract.detail.items[$i]',
          errors,
        );
      }
    }

    // 如果存在章节则验证
    if (detail.chapters != null) {
      if (detail.chapters!.container.expression.isEmpty) {
        errors.add('extract.detail.chapters.container: 选择器表达式是必需的');
      }
      if (detail.chapters!.items.isEmpty) {
        errors.add('extract.detail.chapters.items: 至少需要一个字段映射');
      }
    }
  }

  void _validateContentExtract(
    ContentExtract content,
    MediaType mediaType,
    List<String> errors,
  ) {
    switch (mediaType) {
      case MediaType.video:
        if (content.video == null) {
          errors.add('extract.content.video: 视频媒体类型需要视频提取配置');
        }
      case MediaType.comic:
        if (content.comic == null) {
          errors.add('extract.content.comic: 漫画媒体类型需要漫画提取配置');
        }
      case MediaType.novel:
        if (content.novel == null) {
          errors.add('extract.content.novel: 小说媒体类型需要小说提取配置');
        }
      case MediaType.music:
        if (content.music == null) {
          errors.add('extract.content.music: 音乐媒体类型需要音乐提取配置');
        }
      case MediaType.image:
      case MediaType.audio:
      case MediaType.rss:
      case MediaType.generic:
        // 这些类型没有特定的验证
        break;
    }
  }

  void _validateFieldMapping(
    FieldMapping mapping,
    String path,
    List<String> errors,
  ) {
    if (mapping.field.isEmpty) {
      errors.add('$path.field: 字段名是必需的');
    }

    if (mapping.selector.expression.isEmpty) {
      errors.add('$path.selector: 选择器表达式是必需的');
    }
  }

  void _validateAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    // 根据动作类型验证
    switch (action.type) {
      case ActionType.wait:
        _validateWaitAction(action, path, errors);
      case ActionType.click:
        _validateClickAction(action, path, errors);
      case ActionType.scroll:
        _validateScrollAction(action, path, errors);
      case ActionType.fill:
        _validateFillAction(action, path, errors);
      case ActionType.script:
        _validateScriptAction(action, path, errors);
      case ActionType.condition:
        _validateConditionAction(action, path, errors);
      case ActionType.loop:
        _validateLoopAction(action, path, errors);
    }
  }

  void _validateWaitAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final timeout = params['timeout'];
    if (timeout != null && timeout is! int) {
      errors.add('$path.params.timeout: 必须是整数');
    }
  }

  void _validateClickAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final selector = params['selector'];
    if (selector == null || (selector is String && selector.isEmpty)) {
      errors.add('$path.params.selector: 点击动作需要选择器');
    }
  }

  void _validateScrollAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final distance = params['distance'];
    if (distance != null && distance is! int) {
      errors.add('$path.params.distance: 必须是整数');
    }
  }

  void _validateFillAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final selector = params['selector'];
    final value = params['value'];
    if (selector == null || (selector is String && selector.isEmpty)) {
      errors.add('$path.params.selector: 填充动作需要选择器');
    }
    if (value == null || (value is String && value.isEmpty)) {
      errors.add('$path.params.value: 填充动作需要值');
    }
  }

  void _validateScriptAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final code = params['code'];
    if (code == null || (code is String && code.isEmpty)) {
      errors.add('$path.params.code: 脚本动作需要代码');
    }
  }

  void _validateConditionAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final check = params['check'];
    final thenActions = params['then'];

    if (check == null || (check is String && check.isEmpty)) {
      errors.add('$path.params.check: 需要条件检查');
    }
    if (thenActions == null || thenActions is! List) {
      errors.add('$path.params.then: 需要 then 动作');
    }
  }

  void _validateLoopAction(
    CrawlerAction action,
    String path,
    List<String> errors,
  ) {
    final params = action.params;
    final count = params['count'];
    final actions = params['actions'];

    if (count == null || count is! int || count <= 0) {
      errors.add('$path.params.count: 需要正整数计数');
    }
    if (actions == null || actions is! List) {
      errors.add('$path.params.actions: 需要动作列表');
    }
  }

  /// 从 JSON 字符串解析并验证规则。
  ///
  /// 这是一个结合解析和验证的便捷方法。
  ///
  /// [jsonString] - 要解析的 JSON 字符串。
  ///
  /// 返回包含验证的规则或错误的 [RuleParseResult]。
  RuleParseResult parseAndValidate(String jsonString) {
    final parseResult = parseString(jsonString);
    if (!parseResult.isSuccess) {
      return parseResult;
    }

    final validationErrors = validate(parseResult.rule!);
    if (validationErrors.isNotEmpty) {
      return RuleParseResult.failure(validationErrors);
    }

    return parseResult;
  }

  /// 将 CrawlerRule 序列化为 JSON 字符串。
  ///
  /// [rule] - 要序列化的规则。
  ///
  /// 返回 JSON 字符串表示。
  String toJsonString(CrawlerRule rule) {
    return const JsonEncoder.withIndent('  ').convert(rule.toJson());
  }

  /// 将 CrawlerRule 序列化为 JSON map。
  ///
  /// [rule] - 要序列化的规则。
  ///
  /// 返回 JSON map 表示。
  Map<String, dynamic> toJson(CrawlerRule rule) {
    return rule.toJson();
  }
}
