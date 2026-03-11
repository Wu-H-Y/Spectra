// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Spectra';

  @override
  String get homeTitle => '欢迎使用 Spectra';

  @override
  String get homeSubtitle => '一款现代化的多媒体数据采集应用';

  @override
  String get settingsTitle => '设置';

  @override
  String get themeMode => '主题模式';

  @override
  String get themeModeDark => '深色';

  @override
  String get themeModeLight => '浅色';

  @override
  String get themeModeSystem => '跟随系统';

  @override
  String get language => '语言';

  @override
  String get languageEnglish => '英文';

  @override
  String get languageChinese => '中文';

  @override
  String get featureVideo => '视频采集';

  @override
  String get featureMusic => '音乐采集';

  @override
  String get featureNovel => '小说采集';

  @override
  String get featureComic => '漫画采集';

  @override
  String get featureImage => '图片采集';

  @override
  String get goHome => '返回首页';

  @override
  String get pageNotFound => '404 - 页面未找到';

  @override
  String get appearanceSettings => '外观';

  @override
  String get generalSettings => '通用';

  @override
  String get currentTheme => '当前主题';

  @override
  String get currentLanguage => '当前语言';

  @override
  String get about => '关于';

  @override
  String get version => '版本';

  @override
  String get back => '返回';

  @override
  String get developerTools => '开发者工具';

  @override
  String get ruleEditor => '规则编辑器';

  @override
  String get ruleEditorDescription => '打开网页端爬虫规则编辑器';

  @override
  String get rulesExecutePageTitle => '运行时工作区';

  @override
  String get rulesExecutePageDescription => '在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。';

  @override
  String get rulesExecuteWorkspaceSection => '工作区上下文';

  @override
  String get rulesExecuteSessionLabel => '当前 Session';

  @override
  String get rulesExecuteRuleLabel => '执行规则';

  @override
  String get rulesExecuteNoRules => '当前没有可执行规则，请先通过现有规则接口创建规则。';

  @override
  String get rulesExecuteRunButton => '执行规则';

  @override
  String get rulesExecuteResponseSection => '执行响应 JSON';

  @override
  String get rulesExecuteRunsSection => '运行注册表';

  @override
  String get rulesExecuteNoRuns => '当前 session 还没有运行记录';

  @override
  String get rulesExecuteActivePreviewLabel => '活跃预览';

  @override
  String get rulesExecuteNoActivePreview => '当前没有活跃预览';

  @override
  String get rulesExecuteDebugUrlLabel => '调试地址';

  @override
  String get rulesExecuteTimelineSection => '节点事件时间线';

  @override
  String get rulesExecuteTimelineEmpty => '当前 session 还没有时间线事件';

  @override
  String get rulesExecuteTimelineConnected => '时间线已连接';

  @override
  String get rulesExecuteTimelineDisconnected => '时间线未连接';

  @override
  String get rulesExecuteRunStatusAccepted => '已受理';

  @override
  String get rulesExecuteRunStatusRunning => '执行中';

  @override
  String get rulesExecuteRunStatusFinished => '已完成';

  @override
  String get rulesExecuteNormalizedSection => '规范化结果 JSON';

  @override
  String get rulesExecuteSearchSection => 'Search';

  @override
  String get rulesExecuteDetailSection => 'Detail';

  @override
  String get rulesExecuteTocSection => 'Toc';

  @override
  String get rulesExecuteContentSection => 'Content';

  @override
  String get rulesExecuteEmptyState => '当前分区暂无内容';

  @override
  String get serverStatus => '服务器状态';

  @override
  String get serverRunning => '运行中';

  @override
  String get serverStopped => '已停止';

  @override
  String get serverStart => '启动服务器';

  @override
  String get serverStop => '停止服务器';

  @override
  String get serverUrl => '服务器地址';

  @override
  String get openInBrowser => '在浏览器中打开';

  @override
  String get serverStartError => '服务器启动失败';

  @override
  String get errorTitleDefault => '提示';

  @override
  String get errorTitleNetwork => '网络错误';

  @override
  String get errorTitleAuth => '身份验证失败';

  @override
  String get errorTitlePermission => '权限不足';

  @override
  String get errorTitleRule => '规则错误';

  @override
  String get errorTitleUnknown => '未知错误';

  @override
  String get errorNetworkUnreachable => '网络不可达，请检查您的网络连接';

  @override
  String get errorConnectionTimeout => '连接超时，请稍后重试';

  @override
  String errorServerError(Object code) {
    return '服务器内部错误 ($code)';
  }

  @override
  String get errorUnauthorized => '登录已过期，请重新登录';

  @override
  String get errorForbidden => '您没有权限执行此操作';

  @override
  String get errorNotFound => '请求的资源不存在';

  @override
  String get errorBadRequest => '请求参数有误，请检查后重试';

  @override
  String get errorParseError => '数据解析失败，请稍后重试';

  @override
  String errorRuleParseError(Object message) {
    return '规则解析失败：$message';
  }

  @override
  String errorRuleExecutionError(Object message) {
    return '规则执行失败：$message';
  }

  @override
  String errorSelectorError(Object selector) {
    return '选择器匹配失败：$selector';
  }

  @override
  String errorWeakPassword(Object count) {
    return '密码长度不能少于 $count 位';
  }

  @override
  String errorUsernameExists(Object username) {
    return '用户名 \"$username\" 已存在';
  }

  @override
  String get errorDatabaseError => '数据库操作失败，请稍后重试';

  @override
  String get errorCacheError => '缓存操作失败，请稍后重试';

  @override
  String get errorUnknown => '发生未知错误，请稍后重试';

  @override
  String get retry => '重试';

  @override
  String get previewPage => '页面预览';

  @override
  String get enterUrl => '输入网址';

  @override
  String get enterUrlToPreview => '输入网址以预览页面';

  @override
  String get go => '前往';

  @override
  String get refresh => '刷新';

  @override
  String get selectElement => '选择元素';

  @override
  String get cancelSelection => '取消选择';

  @override
  String get tapToSelectElement => '点击页面以选择元素';

  @override
  String get cancel => '取消';

  @override
  String get copy => '复制';

  @override
  String get copiedToClipboard => '已复制到剪贴板';

  @override
  String get selectedElement => '已选元素';

  @override
  String get textContent => '文本内容';

  @override
  String get sendToEditor => '发送到编辑器';

  @override
  String get webViewPlaceholder => 'WebView 将在此显示';

  @override
  String get selectorTestSection => '选择器测试';

  @override
  String get selectorTestButton => '测试选择器';

  @override
  String get selectorClearResult => '清除结果';

  @override
  String get selectorExpressionLabel => '选择器表达式';

  @override
  String get selectorCssHint => '例如: div.content > h1';

  @override
  String get selectorXPathHint => '例如: //div[@class=\"content\"]';

  @override
  String selectorMatchSuccess(Object count) {
    return '匹配成功 ($count 个元素)';
  }

  @override
  String get selectorMatchFailed => '匹配失败';

  @override
  String selectorMatchError(Object error) {
    return '错误: $error';
  }

  @override
  String get selectorMatchSamples => '匹配样本';

  @override
  String selectorMatchMore(Object count) {
    return '还有 $count 个匹配元素...';
  }

  @override
  String get selectorElementText => '文本';

  @override
  String get selectorElementHtml => 'HTML';

  @override
  String get navFavorites => '收藏';

  @override
  String get navDiscover => '发现';

  @override
  String get navSearch => '搜索';

  @override
  String get favoritesPageTitle => '我的收藏';

  @override
  String get favoritesPageSubtitle => '管理您收藏的多媒体内容';

  @override
  String get favoritesEmptyTitle => '还没有收藏';

  @override
  String get favoritesEmptySubtitle => '去发现页浏览并收藏您喜欢的内容';

  @override
  String get favoritesRecent => '最近观看';

  @override
  String get favoritesAll => '全部收藏';

  @override
  String get mediaTypeAll => '全部';

  @override
  String get mediaTypeVideo => '视频';

  @override
  String get mediaTypeMusic => '音乐';

  @override
  String get mediaTypeNovel => '小说';

  @override
  String get mediaTypeComic => '漫画';

  @override
  String get mediaTypeImage => '图片';

  @override
  String get noRecentHistory => '暂无最近观看记录';

  @override
  String get goToDiscover => '去发现';

  @override
  String get discoverPageTitle => '发现';

  @override
  String get discoverPageSubtitle => '探索精彩内容';

  @override
  String get discoverSelectRule => '选择规则';

  @override
  String get discoverSelectRuleHint => '选择一个规则开始探索';

  @override
  String get discoverSelectRuleDescription => '从上方选择一个数据源规则，发现精彩内容';

  @override
  String get discoverNoRules => '暂无可用规则';

  @override
  String get discoverLoadMore => '加载更多';

  @override
  String get discoverNoMoreData => '没有更多数据了';

  @override
  String get settingsDataStorage => '数据存储';

  @override
  String get settingsCacheSize => '缓存大小';

  @override
  String get settingsClearCache => '清除缓存';

  @override
  String get settingsClearCacheConfirm => '确定要清除所有缓存吗？此操作不可恢复。';

  @override
  String get settingsCacheCleared => '缓存已清除';

  @override
  String get settingsExportFavorites => '导出收藏';

  @override
  String get settingsImportFavorites => '导入收藏';

  @override
  String get settingsPlayback => '播放预览';

  @override
  String get settingsAutoPlay => '自动播放';

  @override
  String get settingsAutoPlayOn => '开启';

  @override
  String get settingsAutoPlayOff => '关闭';

  @override
  String get settingsDefaultQuality => '默认画质';

  @override
  String get settingsQualityAuto => '自动';

  @override
  String get settingsQualityHigh => '高清';

  @override
  String get settingsQualityStandard => '标清';

  @override
  String get settingsQualityLow => '流畅';

  @override
  String get actionConfirm => '确定';

  @override
  String get actionCancel => '取消';

  @override
  String get actionClose => '关闭';

  @override
  String get searchPageTitle => '搜索';

  @override
  String get searchPageSubtitle => '搜索视频、音乐、小说、漫画、图片';

  @override
  String get searchHint => '输入关键词搜索...';

  @override
  String get searchHistory => '搜索历史';

  @override
  String get searchClearHistory => '清除历史';

  @override
  String get searchHot => '热门搜索';

  @override
  String get searchResults => '搜索结果';

  @override
  String get searchNoResults => '没有找到相关内容';

  @override
  String get searchTabAll => '全部';

  @override
  String get searchTabVideo => '视频';

  @override
  String get searchTabMusic => '音乐';

  @override
  String get searchTabNovel => '小说';

  @override
  String get searchTabComic => '漫画';

  @override
  String get searchTabImage => '图片';
}
