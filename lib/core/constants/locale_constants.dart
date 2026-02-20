import 'dart:ui';

/// 支持的语言列表
const supportedLocales = [
  Locale('en', 'US'), // 英语
  Locale('zh', 'CN'), // 简体中文
];

/// 默认语言
const defaultLocale = Locale('en', 'US');

/// Locale 扩展方法
extension LocaleExtension on Locale {
  /// 是否为中文
  bool get isChinese => languageCode == 'zh';

  /// 是否为英文
  bool get isEnglish => languageCode == 'en';
}
