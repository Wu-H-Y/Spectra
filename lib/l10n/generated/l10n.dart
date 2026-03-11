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

  /// `运行时工作区`
  String get rulesExecutePageTitle {
    return Intl.message(
      '运行时工作区',
      name: 'rulesExecutePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。`
  String get rulesExecutePageDescription {
    return Intl.message(
      '在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。',
      name: 'rulesExecutePageDescription',
      desc: '',
      args: [],
    );
  }

  /// `工作区上下文`
  String get rulesExecuteWorkspaceSection {
    return Intl.message(
      '工作区上下文',
      name: 'rulesExecuteWorkspaceSection',
      desc: '',
      args: [],
    );
  }

  /// `当前 Session`
  String get rulesExecuteSessionLabel {
    return Intl.message(
      '当前 Session',
      name: 'rulesExecuteSessionLabel',
      desc: '',
      args: [],
    );
  }

  /// `执行规则`
  String get rulesExecuteRuleLabel {
    return Intl.message(
      '执行规则',
      name: 'rulesExecuteRuleLabel',
      desc: '',
      args: [],
    );
  }

  /// `当前没有可执行规则，请先通过现有规则接口创建规则。`
  String get rulesExecuteNoRules {
    return Intl.message(
      '当前没有可执行规则，请先通过现有规则接口创建规则。',
      name: 'rulesExecuteNoRules',
      desc: '',
      args: [],
    );
  }

  /// `执行规则`
  String get rulesExecuteRunButton {
    return Intl.message(
      '执行规则',
      name: 'rulesExecuteRunButton',
      desc: '',
      args: [],
    );
  }

  /// `执行响应 JSON`
  String get rulesExecuteResponseSection {
    return Intl.message(
      '执行响应 JSON',
      name: 'rulesExecuteResponseSection',
      desc: '',
      args: [],
    );
  }

  /// `运行注册表`
  String get rulesExecuteRunsSection {
    return Intl.message(
      '运行注册表',
      name: 'rulesExecuteRunsSection',
      desc: '',
      args: [],
    );
  }

  /// `当前 session 还没有运行记录`
  String get rulesExecuteNoRuns {
    return Intl.message(
      '当前 session 还没有运行记录',
      name: 'rulesExecuteNoRuns',
      desc: '',
      args: [],
    );
  }

  /// `活跃预览`
  String get rulesExecuteActivePreviewLabel {
    return Intl.message(
      '活跃预览',
      name: 'rulesExecuteActivePreviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `当前没有活跃预览`
  String get rulesExecuteNoActivePreview {
    return Intl.message(
      '当前没有活跃预览',
      name: 'rulesExecuteNoActivePreview',
      desc: '',
      args: [],
    );
  }

  /// `调试地址`
  String get rulesExecuteDebugUrlLabel {
    return Intl.message(
      '调试地址',
      name: 'rulesExecuteDebugUrlLabel',
      desc: '',
      args: [],
    );
  }

  /// `节点事件时间线`
  String get rulesExecuteTimelineSection {
    return Intl.message(
      '节点事件时间线',
      name: 'rulesExecuteTimelineSection',
      desc: '',
      args: [],
    );
  }

  /// `当前 session 还没有时间线事件`
  String get rulesExecuteTimelineEmpty {
    return Intl.message(
      '当前 session 还没有时间线事件',
      name: 'rulesExecuteTimelineEmpty',
      desc: '',
      args: [],
    );
  }

  /// `时间线已连接`
  String get rulesExecuteTimelineConnected {
    return Intl.message(
      '时间线已连接',
      name: 'rulesExecuteTimelineConnected',
      desc: '',
      args: [],
    );
  }

  /// `时间线未连接`
  String get rulesExecuteTimelineDisconnected {
    return Intl.message(
      '时间线未连接',
      name: 'rulesExecuteTimelineDisconnected',
      desc: '',
      args: [],
    );
  }

  /// `已受理`
  String get rulesExecuteRunStatusAccepted {
    return Intl.message(
      '已受理',
      name: 'rulesExecuteRunStatusAccepted',
      desc: '',
      args: [],
    );
  }

  /// `执行中`
  String get rulesExecuteRunStatusRunning {
    return Intl.message(
      '执行中',
      name: 'rulesExecuteRunStatusRunning',
      desc: '',
      args: [],
    );
  }

  /// `已完成`
  String get rulesExecuteRunStatusFinished {
    return Intl.message(
      '已完成',
      name: 'rulesExecuteRunStatusFinished',
      desc: '',
      args: [],
    );
  }

  /// `规范化结果 JSON`
  String get rulesExecuteNormalizedSection {
    return Intl.message(
      '规范化结果 JSON',
      name: 'rulesExecuteNormalizedSection',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get rulesExecuteSearchSection {
    return Intl.message(
      'Search',
      name: 'rulesExecuteSearchSection',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get rulesExecuteDetailSection {
    return Intl.message(
      'Detail',
      name: 'rulesExecuteDetailSection',
      desc: '',
      args: [],
    );
  }

  /// `Toc`
  String get rulesExecuteTocSection {
    return Intl.message(
      'Toc',
      name: 'rulesExecuteTocSection',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get rulesExecuteContentSection {
    return Intl.message(
      'Content',
      name: 'rulesExecuteContentSection',
      desc: '',
      args: [],
    );
  }

  /// `当前分区暂无内容`
  String get rulesExecuteEmptyState {
    return Intl.message(
      '当前分区暂无内容',
      name: 'rulesExecuteEmptyState',
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

  /// `选择器测试`
  String get selectorTestSection {
    return Intl.message(
      '选择器测试',
      name: 'selectorTestSection',
      desc: '',
      args: [],
    );
  }

  /// `测试选择器`
  String get selectorTestButton {
    return Intl.message(
      '测试选择器',
      name: 'selectorTestButton',
      desc: '',
      args: [],
    );
  }

  /// `清除结果`
  String get selectorClearResult {
    return Intl.message(
      '清除结果',
      name: 'selectorClearResult',
      desc: '',
      args: [],
    );
  }

  /// `选择器表达式`
  String get selectorExpressionLabel {
    return Intl.message(
      '选择器表达式',
      name: 'selectorExpressionLabel',
      desc: '',
      args: [],
    );
  }

  /// `例如: div.content > h1`
  String get selectorCssHint {
    return Intl.message(
      '例如: div.content > h1',
      name: 'selectorCssHint',
      desc: '',
      args: [],
    );
  }

  /// `例如: //div[@class="content"]`
  String get selectorXPathHint {
    return Intl.message(
      '例如: //div[@class="content"]',
      name: 'selectorXPathHint',
      desc: '',
      args: [],
    );
  }

  /// `匹配成功 ({count} 个元素)`
  String selectorMatchSuccess(Object count) {
    return Intl.message(
      '匹配成功 ($count 个元素)',
      name: 'selectorMatchSuccess',
      desc: '',
      args: [count],
    );
  }

  /// `匹配失败`
  String get selectorMatchFailed {
    return Intl.message(
      '匹配失败',
      name: 'selectorMatchFailed',
      desc: '',
      args: [],
    );
  }

  /// `错误: {error}`
  String selectorMatchError(Object error) {
    return Intl.message(
      '错误: $error',
      name: 'selectorMatchError',
      desc: '',
      args: [error],
    );
  }

  /// `匹配样本`
  String get selectorMatchSamples {
    return Intl.message(
      '匹配样本',
      name: 'selectorMatchSamples',
      desc: '',
      args: [],
    );
  }

  /// `还有 {count} 个匹配元素...`
  String selectorMatchMore(Object count) {
    return Intl.message(
      '还有 $count 个匹配元素...',
      name: 'selectorMatchMore',
      desc: '',
      args: [count],
    );
  }

  /// `文本`
  String get selectorElementText {
    return Intl.message('文本', name: 'selectorElementText', desc: '', args: []);
  }

  /// `HTML`
  String get selectorElementHtml {
    return Intl.message(
      'HTML',
      name: 'selectorElementHtml',
      desc: '',
      args: [],
    );
  }

  /// `收藏`
  String get navFavorites {
    return Intl.message('收藏', name: 'navFavorites', desc: '', args: []);
  }

  /// `发现`
  String get navDiscover {
    return Intl.message('发现', name: 'navDiscover', desc: '', args: []);
  }

  /// `搜索`
  String get navSearch {
    return Intl.message('搜索', name: 'navSearch', desc: '', args: []);
  }

  /// `我的收藏`
  String get favoritesPageTitle {
    return Intl.message('我的收藏', name: 'favoritesPageTitle', desc: '', args: []);
  }

  /// `管理您收藏的多媒体内容`
  String get favoritesPageSubtitle {
    return Intl.message(
      '管理您收藏的多媒体内容',
      name: 'favoritesPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `还没有收藏`
  String get favoritesEmptyTitle {
    return Intl.message(
      '还没有收藏',
      name: 'favoritesEmptyTitle',
      desc: '',
      args: [],
    );
  }

  /// `去发现页浏览并收藏您喜欢的内容`
  String get favoritesEmptySubtitle {
    return Intl.message(
      '去发现页浏览并收藏您喜欢的内容',
      name: 'favoritesEmptySubtitle',
      desc: '',
      args: [],
    );
  }

  /// `最近观看`
  String get favoritesRecent {
    return Intl.message('最近观看', name: 'favoritesRecent', desc: '', args: []);
  }

  /// `全部收藏`
  String get favoritesAll {
    return Intl.message('全部收藏', name: 'favoritesAll', desc: '', args: []);
  }

  /// `全部`
  String get mediaTypeAll {
    return Intl.message('全部', name: 'mediaTypeAll', desc: '', args: []);
  }

  /// `视频`
  String get mediaTypeVideo {
    return Intl.message('视频', name: 'mediaTypeVideo', desc: '', args: []);
  }

  /// `音乐`
  String get mediaTypeMusic {
    return Intl.message('音乐', name: 'mediaTypeMusic', desc: '', args: []);
  }

  /// `小说`
  String get mediaTypeNovel {
    return Intl.message('小说', name: 'mediaTypeNovel', desc: '', args: []);
  }

  /// `漫画`
  String get mediaTypeComic {
    return Intl.message('漫画', name: 'mediaTypeComic', desc: '', args: []);
  }

  /// `图片`
  String get mediaTypeImage {
    return Intl.message('图片', name: 'mediaTypeImage', desc: '', args: []);
  }

  /// `暂无最近观看记录`
  String get noRecentHistory {
    return Intl.message(
      '暂无最近观看记录',
      name: 'noRecentHistory',
      desc: '',
      args: [],
    );
  }

  /// `去发现`
  String get goToDiscover {
    return Intl.message('去发现', name: 'goToDiscover', desc: '', args: []);
  }

  /// `发现`
  String get discoverPageTitle {
    return Intl.message('发现', name: 'discoverPageTitle', desc: '', args: []);
  }

  /// `探索精彩内容`
  String get discoverPageSubtitle {
    return Intl.message(
      '探索精彩内容',
      name: 'discoverPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `选择规则`
  String get discoverSelectRule {
    return Intl.message('选择规则', name: 'discoverSelectRule', desc: '', args: []);
  }

  /// `选择一个规则开始探索`
  String get discoverSelectRuleHint {
    return Intl.message(
      '选择一个规则开始探索',
      name: 'discoverSelectRuleHint',
      desc: '',
      args: [],
    );
  }

  /// `从上方选择一个数据源规则，发现精彩内容`
  String get discoverSelectRuleDescription {
    return Intl.message(
      '从上方选择一个数据源规则，发现精彩内容',
      name: 'discoverSelectRuleDescription',
      desc: '',
      args: [],
    );
  }

  /// `暂无可用规则`
  String get discoverNoRules {
    return Intl.message('暂无可用规则', name: 'discoverNoRules', desc: '', args: []);
  }

  /// `加载更多`
  String get discoverLoadMore {
    return Intl.message('加载更多', name: 'discoverLoadMore', desc: '', args: []);
  }

  /// `没有更多数据了`
  String get discoverNoMoreData {
    return Intl.message(
      '没有更多数据了',
      name: 'discoverNoMoreData',
      desc: '',
      args: [],
    );
  }

  /// `搜索`
  String get searchPageTitle {
    return Intl.message('搜索', name: 'searchPageTitle', desc: '', args: []);
  }

  /// `搜索视频、音乐、小说、漫画、图片`
  String get searchPageSubtitle {
    return Intl.message(
      '搜索视频、音乐、小说、漫画、图片',
      name: 'searchPageSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `输入关键词搜索...`
  String get searchHint {
    return Intl.message('输入关键词搜索...', name: 'searchHint', desc: '', args: []);
  }

  /// `搜索历史`
  String get searchHistory {
    return Intl.message('搜索历史', name: 'searchHistory', desc: '', args: []);
  }

  /// `清除历史`
  String get searchClearHistory {
    return Intl.message('清除历史', name: 'searchClearHistory', desc: '', args: []);
  }

  /// `热门搜索`
  String get searchHot {
    return Intl.message('热门搜索', name: 'searchHot', desc: '', args: []);
  }

  /// `搜索结果`
  String get searchResults {
    return Intl.message('搜索结果', name: 'searchResults', desc: '', args: []);
  }

  /// `没有找到相关内容`
  String get searchNoResults {
    return Intl.message(
      '没有找到相关内容',
      name: 'searchNoResults',
      desc: '',
      args: [],
    );
  }

  /// `全部`
  String get searchTabAll {
    return Intl.message('全部', name: 'searchTabAll', desc: '', args: []);
  }

  /// `视频`
  String get searchTabVideo {
    return Intl.message('视频', name: 'searchTabVideo', desc: '', args: []);
  }

  /// `音乐`
  String get searchTabMusic {
    return Intl.message('音乐', name: 'searchTabMusic', desc: '', args: []);
  }

  /// `小说`
  String get searchTabNovel {
    return Intl.message('小说', name: 'searchTabNovel', desc: '', args: []);
  }

  /// `漫画`
  String get searchTabComic {
    return Intl.message('漫画', name: 'searchTabComic', desc: '', args: []);
  }

  /// `图片`
  String get searchTabImage {
    return Intl.message('图片', name: 'searchTabImage', desc: '', args: []);
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
