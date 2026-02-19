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
