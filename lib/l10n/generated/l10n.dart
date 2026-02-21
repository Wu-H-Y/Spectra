// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Spectra`
  String get appName {
    return Intl.message('Spectra', name: 'appName', desc: '', args: []);
  }

  /// `欢迎使用 Spectra`
  String get homeTitle {
    return Intl.message('欢迎使用 Spectra', name: 'homeTitle', desc: '', args: []);
  }

  /// `一款现代化的多媒体数据采集应用`
  String get homeSubtitle {
    return Intl.message(
      '一款现代化的多媒体数据采集应用',
      name: 'homeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get settingsTitle {
    return Intl.message('设置', name: 'settingsTitle', desc: '', args: []);
  }

  /// `主题模式`
  String get themeMode {
    return Intl.message('主题模式', name: 'themeMode', desc: '', args: []);
  }

  /// `深色`
  String get themeModeDark {
    return Intl.message('深色', name: 'themeModeDark', desc: '', args: []);
  }

  /// `浅色`
  String get themeModeLight {
    return Intl.message('浅色', name: 'themeModeLight', desc: '', args: []);
  }

  /// `跟随系统`
  String get themeModeSystem {
    return Intl.message('跟随系统', name: 'themeModeSystem', desc: '', args: []);
  }

  /// `语言`
  String get language {
    return Intl.message('语言', name: 'language', desc: '', args: []);
  }

  /// `英文`
  String get languageEnglish {
    return Intl.message('英文', name: 'languageEnglish', desc: '', args: []);
  }

  /// `中文`
  String get languageChinese {
    return Intl.message('中文', name: 'languageChinese', desc: '', args: []);
  }

  /// `视频采集`
  String get featureVideo {
    return Intl.message('视频采集', name: 'featureVideo', desc: '', args: []);
  }

  /// `音乐采集`
  String get featureMusic {
    return Intl.message('音乐采集', name: 'featureMusic', desc: '', args: []);
  }

  /// `小说采集`
  String get featureNovel {
    return Intl.message('小说采集', name: 'featureNovel', desc: '', args: []);
  }

  /// `漫画采集`
  String get featureComic {
    return Intl.message('漫画采集', name: 'featureComic', desc: '', args: []);
  }

  /// `图片采集`
  String get featureImage {
    return Intl.message('图片采集', name: 'featureImage', desc: '', args: []);
  }

  /// `返回首页`
  String get goHome {
    return Intl.message('返回首页', name: 'goHome', desc: '', args: []);
  }

  /// `404 - 页面未找到`
  String get pageNotFound {
    return Intl.message(
      '404 - 页面未找到',
      name: 'pageNotFound',
      desc: '',
      args: [],
    );
  }

  /// `外观`
  String get appearanceSettings {
    return Intl.message('外观', name: 'appearanceSettings', desc: '', args: []);
  }

  /// `通用`
  String get generalSettings {
    return Intl.message('通用', name: 'generalSettings', desc: '', args: []);
  }

  /// `当前主题`
  String get currentTheme {
    return Intl.message('当前主题', name: 'currentTheme', desc: '', args: []);
  }

  /// `当前语言`
  String get currentLanguage {
    return Intl.message('当前语言', name: 'currentLanguage', desc: '', args: []);
  }

  /// `关于`
  String get about {
    return Intl.message('关于', name: 'about', desc: '', args: []);
  }

  /// `版本`
  String get version {
    return Intl.message('版本', name: 'version', desc: '', args: []);
  }

  /// `返回`
  String get back {
    return Intl.message('返回', name: 'back', desc: '', args: []);
  }

  /// `开发者工具`
  String get developerTools {
    return Intl.message('开发者工具', name: 'developerTools', desc: '', args: []);
  }

  /// `规则编辑器`
  String get ruleEditor {
    return Intl.message('规则编辑器', name: 'ruleEditor', desc: '', args: []);
  }

  /// `打开网页端爬虫规则编辑器`
  String get ruleEditorDescription {
    return Intl.message(
      '打开网页端爬虫规则编辑器',
      name: 'ruleEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `服务器状态`
  String get serverStatus {
    return Intl.message('服务器状态', name: 'serverStatus', desc: '', args: []);
  }

  /// `运行中`
  String get serverRunning {
    return Intl.message('运行中', name: 'serverRunning', desc: '', args: []);
  }

  /// `已停止`
  String get serverStopped {
    return Intl.message('已停止', name: 'serverStopped', desc: '', args: []);
  }

  /// `启动服务器`
  String get serverStart {
    return Intl.message('启动服务器', name: 'serverStart', desc: '', args: []);
  }

  /// `停止服务器`
  String get serverStop {
    return Intl.message('停止服务器', name: 'serverStop', desc: '', args: []);
  }

  /// `服务器地址`
  String get serverUrl {
    return Intl.message('服务器地址', name: 'serverUrl', desc: '', args: []);
  }

  /// `在浏览器中打开`
  String get openInBrowser {
    return Intl.message('在浏览器中打开', name: 'openInBrowser', desc: '', args: []);
  }

  /// `服务器启动失败`
  String get serverStartError {
    return Intl.message(
      '服务器启动失败',
      name: 'serverStartError',
      desc: '',
      args: [],
    );
  }

  /// `提示`
  String get errorTitleDefault {
    return Intl.message('提示', name: 'errorTitleDefault', desc: '', args: []);
  }

  /// `网络错误`
  String get errorTitleNetwork {
    return Intl.message('网络错误', name: 'errorTitleNetwork', desc: '', args: []);
  }

  /// `身份验证失败`
  String get errorTitleAuth {
    return Intl.message('身份验证失败', name: 'errorTitleAuth', desc: '', args: []);
  }

  /// `权限不足`
  String get errorTitlePermission {
    return Intl.message(
      '权限不足',
      name: 'errorTitlePermission',
      desc: '',
      args: [],
    );
  }

  /// `规则错误`
  String get errorTitleRule {
    return Intl.message('规则错误', name: 'errorTitleRule', desc: '', args: []);
  }

  /// `未知错误`
  String get errorTitleUnknown {
    return Intl.message('未知错误', name: 'errorTitleUnknown', desc: '', args: []);
  }

  /// `网络不可达，请检查您的网络连接`
  String get errorNetworkUnreachable {
    return Intl.message(
      '网络不可达，请检查您的网络连接',
      name: 'errorNetworkUnreachable',
      desc: '',
      args: [],
    );
  }

  /// `连接超时，请稍后重试`
  String get errorConnectionTimeout {
    return Intl.message(
      '连接超时，请稍后重试',
      name: 'errorConnectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `服务器内部错误 ({code})`
  String errorServerError(Object code) {
    return Intl.message(
      '服务器内部错误 ($code)',
      name: 'errorServerError',
      desc: '',
      args: [code],
    );
  }

  /// `登录已过期，请重新登录`
  String get errorUnauthorized {
    return Intl.message(
      '登录已过期，请重新登录',
      name: 'errorUnauthorized',
      desc: '',
      args: [],
    );
  }

  /// `您没有权限执行此操作`
  String get errorForbidden {
    return Intl.message(
      '您没有权限执行此操作',
      name: 'errorForbidden',
      desc: '',
      args: [],
    );
  }

  /// `请求的资源不存在`
  String get errorNotFound {
    return Intl.message('请求的资源不存在', name: 'errorNotFound', desc: '', args: []);
  }

  /// `请求参数有误，请检查后重试`
  String get errorBadRequest {
    return Intl.message(
      '请求参数有误，请检查后重试',
      name: 'errorBadRequest',
      desc: '',
      args: [],
    );
  }

  /// `数据解析失败，请稍后重试`
  String get errorParseError {
    return Intl.message(
      '数据解析失败，请稍后重试',
      name: 'errorParseError',
      desc: '',
      args: [],
    );
  }

  /// `规则解析失败：{message}`
  String errorRuleParseError(Object message) {
    return Intl.message(
      '规则解析失败：$message',
      name: 'errorRuleParseError',
      desc: '',
      args: [message],
    );
  }

  /// `规则执行失败：{message}`
  String errorRuleExecutionError(Object message) {
    return Intl.message(
      '规则执行失败：$message',
      name: 'errorRuleExecutionError',
      desc: '',
      args: [message],
    );
  }

  /// `选择器匹配失败：{selector}`
  String errorSelectorError(Object selector) {
    return Intl.message(
      '选择器匹配失败：$selector',
      name: 'errorSelectorError',
      desc: '',
      args: [selector],
    );
  }

  /// `密码长度不能少于 {count} 位`
  String errorWeakPassword(Object count) {
    return Intl.message(
      '密码长度不能少于 $count 位',
      name: 'errorWeakPassword',
      desc: '',
      args: [count],
    );
  }

  /// `用户名 "{username}" 已存在`
  String errorUsernameExists(Object username) {
    return Intl.message(
      '用户名 "$username" 已存在',
      name: 'errorUsernameExists',
      desc: '',
      args: [username],
    );
  }

  /// `数据库操作失败，请稍后重试`
  String get errorDatabaseError {
    return Intl.message(
      '数据库操作失败，请稍后重试',
      name: 'errorDatabaseError',
      desc: '',
      args: [],
    );
  }

  /// `缓存操作失败，请稍后重试`
  String get errorCacheError {
    return Intl.message(
      '缓存操作失败，请稍后重试',
      name: 'errorCacheError',
      desc: '',
      args: [],
    );
  }

  /// `发生未知错误，请稍后重试`
  String get errorUnknown {
    return Intl.message(
      '发生未知错误，请稍后重试',
      name: 'errorUnknown',
      desc: '',
      args: [],
    );
  }

  /// `重试`
  String get retry {
    return Intl.message('重试', name: 'retry', desc: '', args: []);
  }

  /// `页面预览`
  String get previewPage {
    return Intl.message('页面预览', name: 'previewPage', desc: '', args: []);
  }

  /// `输入网址`
  String get enterUrl {
    return Intl.message('输入网址', name: 'enterUrl', desc: '', args: []);
  }

  /// `输入网址以预览页面`
  String get enterUrlToPreview {
    return Intl.message(
      '输入网址以预览页面',
      name: 'enterUrlToPreview',
      desc: '',
      args: [],
    );
  }

  /// `前往`
  String get go {
    return Intl.message('前往', name: 'go', desc: '', args: []);
  }

  /// `刷新`
  String get refresh {
    return Intl.message('刷新', name: 'refresh', desc: '', args: []);
  }

  /// `选择元素`
  String get selectElement {
    return Intl.message('选择元素', name: 'selectElement', desc: '', args: []);
  }

  /// `取消选择`
  String get cancelSelection {
    return Intl.message('取消选择', name: 'cancelSelection', desc: '', args: []);
  }

  /// `点击页面以选择元素`
  String get tapToSelectElement {
    return Intl.message(
      '点击页面以选择元素',
      name: 'tapToSelectElement',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get cancel {
    return Intl.message('取消', name: 'cancel', desc: '', args: []);
  }

  /// `复制`
  String get copy {
    return Intl.message('复制', name: 'copy', desc: '', args: []);
  }

  /// `已复制到剪贴板`
  String get copiedToClipboard {
    return Intl.message(
      '已复制到剪贴板',
      name: 'copiedToClipboard',
      desc: '',
      args: [],
    );
  }

  /// `已选元素`
  String get selectedElement {
    return Intl.message('已选元素', name: 'selectedElement', desc: '', args: []);
  }

  /// `文本内容`
  String get textContent {
    return Intl.message('文本内容', name: 'textContent', desc: '', args: []);
  }

  /// `发送到编辑器`
  String get sendToEditor {
    return Intl.message('发送到编辑器', name: 'sendToEditor', desc: '', args: []);
  }

  /// `WebView 将在此显示`
  String get webViewPlaceholder {
    return Intl.message(
      'WebView 将在此显示',
      name: 'webViewPlaceholder',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
