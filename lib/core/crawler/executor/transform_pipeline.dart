import 'package:intl/intl.dart';

import 'package:spectra/core/crawler/models/transform.dart';

/// 数据转换管道。
class TransformPipeline {
  /// 对值应用一系列转换。
  ///
  /// [value] - 输入值。
  /// [transforms] - 要应用的转换列表。
  ///
  /// 返回转换后的值。
  String apply(String value, List<Transform>? transforms) {
    if (transforms == null || transforms.isEmpty) {
      return value;
    }

    var result = value;
    for (final transform in transforms) {
      result = _applyTransform(result, transform);
    }
    return result;
  }

  String _applyTransform(String value, Transform transform) {
    switch (transform.type) {
      case TransformType.trim:
        return value.trim();

      case TransformType.number:
        return _parseNumber(value);

      case TransformType.date:
        return _parseDate(value, transform.params);

      case TransformType.url:
        return _normalizeUrl(value, transform.params);

      case TransformType.regex:
        return _applyRegex(value, transform.params);

      case TransformType.replace:
        return _applyReplace(value, transform.params);

      case TransformType.lowercase:
        return value.toLowerCase();

      case TransformType.uppercase:
        return value.toUpperCase();

      case TransformType.substring:
        return _applySubstring(value, transform.params);

      case TransformType.split:
        return _applySplit(value, transform.params);

      case TransformType.join:
        // 这是用于数组的，对于字符串原样返回
        return value;

      case TransformType.map:
        return _applyMap(value, transform.params);

      case TransformType.parseJson:
        return _parseJson(value);

      case TransformType.formatNumber:
        return _formatNumber(value);
    }
  }

  String _parseNumber(String value) {
    // 移除非数字字符（小数点和负号除外）
    final cleaned = value.replaceAll(RegExp(r'[^\d.\-]'), '');
    final number = double.tryParse(cleaned);
    if (number == null) return value;

    // 如果没有小数部分则返回整数
    if (number == number.toInt()) {
      return number.toInt().toString();
    }
    return number.toString();
  }

  String _parseDate(String value, dynamic params) {
    final format = params is String ? params : null;

    if (format != null) {
      try {
        final dateFormat = DateFormat(format);
        final dateTime = dateFormat.parseStrict(value);
        return dateTime.toIso8601String();
      } on Exception {
        // 尝试解析为 ISO 8601
      }
    }

    // 尝试常见日期格式
    final formats = [
      'yyyy-MM-dd',
      'yyyy-MM-dd HH:mm:ss',
      'yyyy/MM/dd',
      'yyyy/MM/dd HH:mm:ss',
      'MM/dd/yyyy',
      'dd/MM/yyyy',
      'yyyy年MM月dd日',
    ];

    for (final fmt in formats) {
      try {
        final dateFormat = DateFormat(fmt);
        final dateTime = dateFormat.parseStrict(value);
        return dateTime.toIso8601String();
      } on Exception {
        continue;
      }
    }

    // 尝试 DateTime.parse 作为最后手段
    try {
      final dateTime = DateTime.parse(value);
      return dateTime.toIso8601String();
    } on Exception {
      return value;
    }
  }

  String _normalizeUrl(String value, dynamic params) {
    var url = value.trim();

    // 如果缺少协议则添加
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      if (url.startsWith('//')) {
        url = 'https:$url';
      } else {
        url = 'https://$url';
      }
    }

    // 如果提供了 baseUrl 则解析相对 URL
    final baseUrl = params is String ? params : null;
    if (baseUrl != null && !url.startsWith('http')) {
      // 简单的相对 URL 解析
      if (url.startsWith('/')) {
        final uri = Uri.parse(baseUrl);
        url = '${uri.scheme}://${uri.host}$url';
      } else {
        final lastSlash = baseUrl.lastIndexOf('/');
        if (lastSlash > 8) {
          // 在 http:// 或 https:// 之后
          url = '${baseUrl.substring(0, lastSlash + 1)}$url';
        } else {
          url = '$baseUrl/$url';
        }
      }
    }

    return url;
  }

  String _applyRegex(String value, dynamic params) {
    if (params is String) {
      // 简单模式 - 提取第一个匹配
      try {
        final regex = RegExp(params);
        final match = regex.firstMatch(value);
        if (match != null) {
          return match.group(1) ?? match.group(0) ?? value;
        }
      } on Exception {
        return value;
      }
    } else if (params is Map) {
      // 带替换的模式
      final pattern = params['pattern'] as String?;
      final replacement = params['replacement'] as String?;
      if (pattern != null) {
        try {
          final regex = RegExp(pattern);
          return value.replaceAll(regex, replacement ?? '');
        } on Exception {
          return value;
        }
      }
    }
    return value;
  }

  String _applyReplace(String value, dynamic params) {
    if (params is Map) {
      final find = params['find'] as String?;
      final replace = params['replace'] as String?;
      if (find != null) {
        return value.replaceAll(find, replace ?? '');
      }
    }
    return value;
  }

  String _applySubstring(String value, dynamic params) {
    int? start;
    int? end;

    if (params is int) {
      start = params;
    } else if (params is Map) {
      start = params['start'] as int?;
      end = params['end'] as int?;
    }

    if (start == null) return value;

    if (end != null) {
      if (start < 0) start = value.length + start;
      if (end < 0) end = value.length + end;
      return value.substring(
        start.clamp(0, value.length),
        end.clamp(0, value.length),
      );
    } else {
      if (start < 0) start = value.length + start;
      return value.substring(start.clamp(0, value.length));
    }
  }

  String _applySplit(String value, dynamic params) {
    final delimiter = params is String ? params : ',';
    final parts = value.split(delimiter);
    // 返回第一个非空部分
    return parts
        .map((p) => p.trim())
        .firstWhere(
          (p) => p.isNotEmpty,
          orElse: () => value,
        );
  }

  String _applyMap(String value, dynamic params) {
    if (params is Map) {
      final mapped = params[value];
      if (mapped != null) {
        return mapped.toString();
      }
      // 检查默认值
      final default_ = params['_default'];
      if (default_ != null) {
        return default_.toString();
      }
    }
    return value;
  }

  String _parseJson(String value) {
    // 尝试从 JSON 字符串中提取值
    try {
      final trimmed = value.trim();
      if (trimmed.startsWith('{') || trimmed.startsWith('[')) {
        // 这是有效的 JSON 格式，原样返回
        return trimmed;
      }
    } on Exception {
      // 不是 JSON，返回原始值
    }
    return value;
  }

  String _formatNumber(String value) {
    final number = double.tryParse(value);
    if (number == null) return value;

    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toInt().toString();
  }
}
