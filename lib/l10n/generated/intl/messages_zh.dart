// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(message) => "规则执行失败：${message}";

  static String m1(message) => "规则解析失败：${message}";

  static String m2(selector) => "选择器匹配失败：${selector}";

  static String m3(code) => "服务器内部错误 (${code})";

  static String m4(username) => "用户名 \"${username}\" 已存在";

  static String m5(count) => "密码长度不能少于 ${count} 位";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "appName": MessageLookupByLibrary.simpleMessage("Spectra"),
    "appearanceSettings": MessageLookupByLibrary.simpleMessage("外观"),
    "back": MessageLookupByLibrary.simpleMessage("返回"),
    "cancel": MessageLookupByLibrary.simpleMessage("取消"),
    "cancelSelection": MessageLookupByLibrary.simpleMessage("取消选择"),
    "copiedToClipboard": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
    "copy": MessageLookupByLibrary.simpleMessage("复制"),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("当前语言"),
    "currentTheme": MessageLookupByLibrary.simpleMessage("当前主题"),
    "developerTools": MessageLookupByLibrary.simpleMessage("开发者工具"),
    "enterUrl": MessageLookupByLibrary.simpleMessage("输入网址"),
    "enterUrlToPreview": MessageLookupByLibrary.simpleMessage("输入网址以预览页面"),
    "errorBadRequest": MessageLookupByLibrary.simpleMessage("请求参数有误，请检查后重试"),
    "errorCacheError": MessageLookupByLibrary.simpleMessage("缓存操作失败，请稍后重试"),
    "errorConnectionTimeout": MessageLookupByLibrary.simpleMessage(
      "连接超时，请稍后重试",
    ),
    "errorDatabaseError": MessageLookupByLibrary.simpleMessage("数据库操作失败，请稍后重试"),
    "errorForbidden": MessageLookupByLibrary.simpleMessage("您没有权限执行此操作"),
    "errorNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "网络不可达，请检查您的网络连接",
    ),
    "errorNotFound": MessageLookupByLibrary.simpleMessage("请求的资源不存在"),
    "errorParseError": MessageLookupByLibrary.simpleMessage("数据解析失败，请稍后重试"),
    "errorRuleExecutionError": m0,
    "errorRuleParseError": m1,
    "errorSelectorError": m2,
    "errorServerError": m3,
    "errorTitleAuth": MessageLookupByLibrary.simpleMessage("身份验证失败"),
    "errorTitleDefault": MessageLookupByLibrary.simpleMessage("提示"),
    "errorTitleNetwork": MessageLookupByLibrary.simpleMessage("网络错误"),
    "errorTitlePermission": MessageLookupByLibrary.simpleMessage("权限不足"),
    "errorTitleRule": MessageLookupByLibrary.simpleMessage("规则错误"),
    "errorTitleUnknown": MessageLookupByLibrary.simpleMessage("未知错误"),
    "errorUnauthorized": MessageLookupByLibrary.simpleMessage("登录已过期，请重新登录"),
    "errorUnknown": MessageLookupByLibrary.simpleMessage("发生未知错误，请稍后重试"),
    "errorUsernameExists": m4,
    "errorWeakPassword": m5,
    "featureComic": MessageLookupByLibrary.simpleMessage("漫画采集"),
    "featureImage": MessageLookupByLibrary.simpleMessage("图片采集"),
    "featureMusic": MessageLookupByLibrary.simpleMessage("音乐采集"),
    "featureNovel": MessageLookupByLibrary.simpleMessage("小说采集"),
    "featureVideo": MessageLookupByLibrary.simpleMessage("视频采集"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("通用"),
    "go": MessageLookupByLibrary.simpleMessage("前往"),
    "goHome": MessageLookupByLibrary.simpleMessage("返回首页"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage("一款现代化的多媒体数据采集应用"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("欢迎使用 Spectra"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("中文"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("英文"),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("在浏览器中打开"),
    "pageNotFound": MessageLookupByLibrary.simpleMessage("404 - 页面未找到"),
    "previewPage": MessageLookupByLibrary.simpleMessage("页面预览"),
    "refresh": MessageLookupByLibrary.simpleMessage("刷新"),
    "retry": MessageLookupByLibrary.simpleMessage("重试"),
    "ruleEditor": MessageLookupByLibrary.simpleMessage("规则编辑器"),
    "ruleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "打开网页端爬虫规则编辑器",
    ),
    "selectElement": MessageLookupByLibrary.simpleMessage("选择元素"),
    "selectedElement": MessageLookupByLibrary.simpleMessage("已选元素"),
    "sendToEditor": MessageLookupByLibrary.simpleMessage("发送到编辑器"),
    "serverRunning": MessageLookupByLibrary.simpleMessage("运行中"),
    "serverStart": MessageLookupByLibrary.simpleMessage("启动服务器"),
    "serverStartError": MessageLookupByLibrary.simpleMessage("服务器启动失败"),
    "serverStatus": MessageLookupByLibrary.simpleMessage("服务器状态"),
    "serverStop": MessageLookupByLibrary.simpleMessage("停止服务器"),
    "serverStopped": MessageLookupByLibrary.simpleMessage("已停止"),
    "serverUrl": MessageLookupByLibrary.simpleMessage("服务器地址"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("设置"),
    "tapToSelectElement": MessageLookupByLibrary.simpleMessage("点击页面以选择元素"),
    "textContent": MessageLookupByLibrary.simpleMessage("文本内容"),
    "themeMode": MessageLookupByLibrary.simpleMessage("主题模式"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("深色"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("浅色"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("跟随系统"),
    "version": MessageLookupByLibrary.simpleMessage("版本"),
    "webViewPlaceholder": MessageLookupByLibrary.simpleMessage("WebView 将在此显示"),
  };
}
