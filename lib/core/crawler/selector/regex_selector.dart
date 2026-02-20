import 'package:spectra/core/crawler/models/selector.dart';
import 'package:spectra/core/crawler/models/selector_type.dart';

/// 正则提取结果。
class RegexSelectorResult {
  /// 创建正则选择器结果。
  const RegexSelectorResult({
    required this.matches,
    required this.groups,
    required this.fullMatches,
  });

  /// 所有正则匹配。
  final List<RegExpMatch> matches;

  /// 从匹配中提取的分组。
  final List<String> groups;

  /// 完整匹配字符串。
  final List<String> fullMatches;
}

/// 文本内容的正则提取器。
///
/// 使用 Dart 内置的 RegExp 通过正则表达式提取数据。
class RegexSelectorEvaluator {
  /// 使用正则模式从文本中提取数据。
  ///
  /// [text] - 要搜索的文本内容。
  /// [selector] - 选择器配置（expression 是正则模式）。
  ///
  /// 返回包含匹配和提取分组的 [RegexSelectorResult]。
  RegexSelectorResult evaluate(String text, Selector selector) {
    final regex = RegExp(selector.expression);
    final matches = regex.allMatches(text).toList();

    if (selector.firstOnly && matches.isNotEmpty) {
      return _extractFromMatches([matches.first], selector.attribute);
    }

    return _extractFromMatches(matches, selector.attribute);
  }

  RegexSelectorResult _extractFromMatches(
    List<RegExpMatch> matches,
    String? group,
  ) {
    final groups = <String>[];
    final fullMatches = <String>[];

    // 如果 group 指定为数字，则提取该分组
    int? groupIndex;
    if (group != null && group.isNotEmpty) {
      groupIndex = int.tryParse(group);
    }

    for (final match in matches) {
      // 始终捕获完整匹配
      fullMatches.add(match.group(0) ?? '');

      // 提取分组
      if (groupIndex != null) {
        // 提取特定分组
        final groupValue = match.group(groupIndex);
        if (groupValue != null) {
          groups.add(groupValue);
        }
      } else {
        // 如果没有指定特定分组，如果存在分组1则提取，
        // 否则使用完整匹配
        if (match.groupCount >= 1) {
          final groupValue = match.group(1);
          if (groupValue != null) {
            groups.add(groupValue);
          }
        } else {
          groups.add(match.group(0) ?? '');
        }
      }
    }

    return RegexSelectorResult(
      matches: matches,
      groups: groups,
      fullMatches: fullMatches,
    );
  }

  /// 使用正则表达式从文本中提取第一个匹配。
  ///
  /// 返回第一个匹配的分组，如果没有匹配则返回 null。
  String? extractFirst(String text, String pattern, {String? group}) {
    final result = evaluate(
      text,
      Selector(
        type: SelectorType.regex,
        expression: pattern,
        attribute: group,
        firstOnly: true,
      ),
    );

    return result.groups.firstOrNull;
  }

  /// 使用正则表达式从文本中提取所有匹配。
  ///
  /// 返回匹配分组的列表。
  List<String> extractAll(String text, String pattern, {String? group}) {
    final result = evaluate(
      text,
      Selector(
        type: SelectorType.regex,
        expression: pattern,
        attribute: group,
      ),
    );

    return result.groups;
  }

  /// 测试模式是否匹配文本。
  bool hasMatch(String text, String pattern) {
    final regex = RegExp(pattern);
    return regex.hasMatch(text);
  }

  /// 用替换字符串替换文本中的匹配。
  String replaceAll(String text, String pattern, String replacement) {
    final regex = RegExp(pattern);
    return text.replaceAll(regex, replacement);
  }

  /// 按正则模式分割文本。
  List<String> split(String text, String pattern) {
    final regex = RegExp(pattern);
    return text.split(regex);
  }
}
