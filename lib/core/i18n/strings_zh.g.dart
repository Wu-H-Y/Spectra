///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsZh = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// zh: 'Spectra'
	String get appName => 'Spectra';

	/// zh: '一款现代化的多媒体数据采集应用'
	String get appDescription => '一款现代化的多媒体数据采集应用';

	/// zh: 'CSS'
	String get selectorTypeCss => 'CSS';

	/// zh: 'XPath'
	String get selectorTypeXpath => 'XPath';

	/// zh: '设置'
	String get settingsTitle => '设置';

	/// zh: '主题模式'
	String get themeMode => '主题模式';

	/// zh: '深色'
	String get themeModeDark => '深色';

	/// zh: '浅色'
	String get themeModeLight => '浅色';

	/// zh: '跟随系统'
	String get themeModeSystem => '跟随系统';

	/// zh: '语言'
	String get language => '语言';

	/// zh: '英文'
	String get languageEnglish => '英文';

	/// zh: '中文'
	String get languageChinese => '中文';

	/// zh: '返回首页'
	String get goHome => '返回首页';

	/// zh: '404 - 页面未找到'
	String get pageNotFound => '404 - 页面未找到';

	/// zh: '外观'
	String get appearanceSettings => '外观';

	/// zh: '关于'
	String get about => '关于';

	/// zh: '版本'
	String get version => '版本';

	/// zh: '开发者工具'
	String get developerTools => '开发者工具';

	/// zh: '规则编辑器'
	String get ruleEditor => '规则编辑器';

	/// zh: '打开网页端爬虫规则编辑器'
	String get ruleEditorDescription => '打开网页端爬虫规则编辑器';

	/// zh: '规则管理'
	String get rulesPageTitle => '规则管理';

	/// zh: '暂无规则，请先导入规则文件'
	String get rulesPageEmpty => '暂无规则，请先导入规则文件';

	/// zh: '导入规则'
	String get rulesImportButton => '导入规则';

	/// zh: '导入文件'
	String get rulesImportFileButton => '导入文件';

	/// zh: '从 URL 导入'
	String get rulesImportUrlButton => '从 URL 导入';

	/// zh: '规则导入失败'
	String get rulesImportFailedTitle => '规则导入失败';

	/// zh: '无法读取所选文件路径，请重新选择'
	String get rulesImportFilePathMissing => '无法读取所选文件路径，请重新选择';

	/// zh: '规则导入成功：$ruleName'
	String rulesImportSuccess({required Object ruleName}) => '规则导入成功：${ruleName}';

	/// zh: '规则导入成功'
	String get rulesImportSuccessPlain => '规则导入成功';

	/// zh: '正在导入规则...'
	String get rulesImporting => '正在导入规则...';

	/// zh: '从 URL 导入'
	String get rulesImportUrlTitle => '从 URL 导入';

	/// zh: '请输入规则 URL'
	String get rulesImportUrlHint => '请输入规则 URL';

	/// zh: '仅支持 http/https 规则地址'
	String get rulesImportUrlHelper => '仅支持 http/https 规则地址';

	/// zh: '开始导入'
	String get rulesImportUrlSubmit => '开始导入';

	/// zh: '运行时工作区'
	String get rulesExecutePageTitle => '运行时工作区';

	/// zh: '在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。'
	String get rulesExecutePageDescription => '在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。';

	/// zh: '工作区上下文'
	String get rulesExecuteWorkspaceSection => '工作区上下文';

	/// zh: '当前 Session'
	String get rulesExecuteSessionLabel => '当前 Session';

	/// zh: '执行规则'
	String get rulesExecuteRuleLabel => '执行规则';

	/// zh: '当前没有可执行规则，请先通过现有规则接口创建规则。'
	String get rulesExecuteNoRules => '当前没有可执行规则，请先通过现有规则接口创建规则。';

	/// zh: '执行规则'
	String get rulesExecuteRunButton => '执行规则';

	/// zh: '执行响应 JSON'
	String get rulesExecuteResponseSection => '执行响应 JSON';

	/// zh: '运行注册表'
	String get rulesExecuteRunsSection => '运行注册表';

	/// zh: '当前 session 还没有运行记录'
	String get rulesExecuteNoRuns => '当前 session 还没有运行记录';

	/// zh: '活跃预览'
	String get rulesExecuteActivePreviewLabel => '活跃预览';

	/// zh: '当前没有活跃预览'
	String get rulesExecuteNoActivePreview => '当前没有活跃预览';

	/// zh: '调试地址'
	String get rulesExecuteDebugUrlLabel => '调试地址';

	/// zh: '节点事件时间线'
	String get rulesExecuteTimelineSection => '节点事件时间线';

	/// zh: '当前 session 还没有时间线事件'
	String get rulesExecuteTimelineEmpty => '当前 session 还没有时间线事件';

	/// zh: '时间线已连接'
	String get rulesExecuteTimelineConnected => '时间线已连接';

	/// zh: '时间线未连接'
	String get rulesExecuteTimelineDisconnected => '时间线未连接';

	/// zh: '已受理'
	String get rulesExecuteRunStatusAccepted => '已受理';

	/// zh: '执行中'
	String get rulesExecuteRunStatusRunning => '执行中';

	/// zh: '已完成'
	String get rulesExecuteRunStatusFinished => '已完成';

	/// zh: '服务器状态'
	String get serverStatus => '服务器状态';

	/// zh: '运行中'
	String get serverRunning => '运行中';

	/// zh: '已停止'
	String get serverStopped => '已停止';

	/// zh: '启动服务器'
	String get serverStart => '启动服务器';

	/// zh: '停止服务器'
	String get serverStop => '停止服务器';

	/// zh: '服务器地址'
	String get serverUrl => '服务器地址';

	/// zh: '在浏览器中打开'
	String get openInBrowser => '在浏览器中打开';

	/// zh: '重试'
	String get retry => '重试';

	/// zh: '页面预览'
	String get previewPage => '页面预览';

	/// zh: '输入网址'
	String get enterUrl => '输入网址';

	/// zh: '输入网址以预览页面'
	String get enterUrlToPreview => '输入网址以预览页面';

	/// zh: '前往'
	String get go => '前往';

	/// zh: '刷新'
	String get refresh => '刷新';

	/// zh: '选择元素'
	String get selectElement => '选择元素';

	/// zh: '取消选择'
	String get cancelSelection => '取消选择';

	/// zh: '点击页面以选择元素'
	String get tapToSelectElement => '点击页面以选择元素';

	/// zh: '取消'
	String get cancel => '取消';

	/// zh: '复制'
	String get copy => '复制';

	/// zh: '已选元素'
	String get selectedElement => '已选元素';

	/// zh: '文本内容'
	String get textContent => '文本内容';

	/// zh: 'WebView 将在此显示'
	String get webViewPlaceholder => 'WebView 将在此显示';

	/// zh: '选择器测试'
	String get selectorTestSection => '选择器测试';

	/// zh: '测试选择器'
	String get selectorTestButton => '测试选择器';

	/// zh: '清除结果'
	String get selectorClearResult => '清除结果';

	/// zh: '选择器表达式'
	String get selectorExpressionLabel => '选择器表达式';

	/// zh: '例如：div.content > h1'
	String get selectorCssHint => '例如：div.content > h1';

	/// zh: '例如：//div[@class="content"]'
	String get selectorXPathHint => '例如：//div[@class="content"]';

	/// zh: '匹配成功 ($count 个元素)'
	String selectorMatchSuccess({required Object count}) => '匹配成功 (${count} 个元素)';

	/// zh: '匹配失败'
	String get selectorMatchFailed => '匹配失败';

	/// zh: '错误：$error'
	String selectorMatchError({required Object error}) => '错误：${error}';

	/// zh: '匹配样本'
	String get selectorMatchSamples => '匹配样本';

	/// zh: '还有 $count 个匹配元素...'
	String selectorMatchMore({required Object count}) => '还有 ${count} 个匹配元素...';

	/// zh: '文本'
	String get selectorElementText => '文本';

	/// zh: 'HTML'
	String get selectorElementHtml => 'HTML';

	/// zh: '收藏'
	String get navFavorites => '收藏';

	/// zh: '发现'
	String get navDiscover => '发现';

	/// zh: '搜索'
	String get navSearch => '搜索';

	/// zh: '我的收藏'
	String get favoritesPageTitle => '我的收藏';

	/// zh: '管理您收藏的多媒体内容'
	String get favoritesPageSubtitle => '管理您收藏的多媒体内容';

	/// zh: '还没有收藏'
	String get favoritesEmptyTitle => '还没有收藏';

	/// zh: '去发现页浏览并收藏您喜欢的内容'
	String get favoritesEmptySubtitle => '去发现页浏览并收藏您喜欢的内容';

	/// zh: '最近观看'
	String get favoritesRecent => '最近观看';

	/// zh: '全部收藏'
	String get favoritesAll => '全部收藏';

	/// zh: '全部'
	String get mediaTypeAll => '全部';

	/// zh: '视频'
	String get mediaTypeVideo => '视频';

	/// zh: '音乐'
	String get mediaTypeMusic => '音乐';

	/// zh: '小说'
	String get mediaTypeNovel => '小说';

	/// zh: '漫画'
	String get mediaTypeComic => '漫画';

	/// zh: '图片'
	String get mediaTypeImage => '图片';

	/// zh: '暂无最近观看记录'
	String get noRecentHistory => '暂无最近观看记录';

	/// zh: '去发现'
	String get goToDiscover => '去发现';

	/// zh: '发现'
	String get discoverPageTitle => '发现';

	/// zh: '探索精彩内容'
	String get discoverPageSubtitle => '探索精彩内容';

	/// zh: '选择规则'
	String get discoverSelectRule => '选择规则';

	/// zh: '选择一个规则开始探索'
	String get discoverSelectRuleHint => '选择一个规则开始探索';

	/// zh: '从上方选择一个数据源规则，发现精彩内容'
	String get discoverSelectRuleDescription => '从上方选择一个数据源规则，发现精彩内容';

	/// zh: '暂无可用规则'
	String get discoverNoRules => '暂无可用规则';

	/// zh: '加载更多'
	String get discoverLoadMore => '加载更多';

	/// zh: '没有更多数据了'
	String get discoverNoMoreData => '没有更多数据了';

	/// zh: '数据存储'
	String get settingsDataStorage => '数据存储';

	/// zh: '缓存大小'
	String get settingsCacheSize => '缓存大小';

	/// zh: '清除缓存'
	String get settingsClearCache => '清除缓存';

	/// zh: '确定要清除所有缓存吗？此操作不可恢复。'
	String get settingsClearCacheConfirm => '确定要清除所有缓存吗？此操作不可恢复。';

	/// zh: '缓存已清除'
	String get settingsCacheCleared => '缓存已清除';

	/// zh: '导出收藏'
	String get settingsExportFavorites => '导出收藏';

	/// zh: '导入收藏'
	String get settingsImportFavorites => '导入收藏';

	/// zh: '播放预览'
	String get settingsPlayback => '播放预览';

	/// zh: '自动播放'
	String get settingsAutoPlay => '自动播放';

	/// zh: '开启'
	String get settingsAutoPlayOn => '开启';

	/// zh: '关闭'
	String get settingsAutoPlayOff => '关闭';

	/// zh: '默认画质'
	String get settingsDefaultQuality => '默认画质';

	/// zh: '自动'
	String get settingsQualityAuto => '自动';

	/// zh: '高清'
	String get settingsQualityHigh => '高清';

	/// zh: '标清'
	String get settingsQualityStandard => '标清';

	/// zh: '流畅'
	String get settingsQualityLow => '流畅';

	/// zh: '确定'
	String get actionConfirm => '确定';

	/// zh: '取消'
	String get actionCancel => '取消';

	/// zh: '关闭'
	String get actionClose => '关闭';

	/// zh: '搜索'
	String get searchPageTitle => '搜索';

	/// zh: '搜索视频、音乐、小说、漫画、图片'
	String get searchPageSubtitle => '搜索视频、音乐、小说、漫画、图片';

	/// zh: '输入关键词搜索...'
	String get searchHint => '输入关键词搜索...';

	/// zh: '搜索历史'
	String get searchHistory => '搜索历史';

	/// zh: '清除历史'
	String get searchClearHistory => '清除历史';

	/// zh: '热门搜索'
	String get searchHot => '热门搜索';

	/// zh: '搜索结果'
	String get searchResults => '搜索结果';

	/// zh: '没有找到相关内容'
	String get searchNoResults => '没有找到相关内容';

	/// zh: '全部'
	String get searchTabAll => '全部';

	/// zh: '视频'
	String get searchTabVideo => '视频';

	/// zh: '音乐'
	String get searchTabMusic => '音乐';

	/// zh: '小说'
	String get searchTabNovel => '小说';

	/// zh: '漫画'
	String get searchTabComic => '漫画';

	/// zh: '图片'
	String get searchTabImage => '图片';

	/// zh: '提示'
	String get errorTitleDefault => '提示';

	/// zh: '网络错误'
	String get errorTitleNetwork => '网络错误';

	/// zh: '身份验证失败'
	String get errorTitleAuth => '身份验证失败';

	/// zh: '权限不足'
	String get errorTitlePermission => '权限不足';

	/// zh: '规则错误'
	String get errorTitleRule => '规则错误';

	/// zh: '未知错误'
	String get errorTitleUnknown => '未知错误';

	/// zh: '网络不可达，请检查您的网络连接'
	String get errorNetworkUnreachable => '网络不可达，请检查您的网络连接';

	/// zh: '连接超时，请稍后重试'
	String get errorConnectionTimeout => '连接超时，请稍后重试';

	/// zh: '服务器内部错误 ($code)'
	String errorServerError({required Object code}) => '服务器内部错误 (${code})';

	/// zh: '登录已过期，请重新登录'
	String get errorUnauthorized => '登录已过期，请重新登录';

	/// zh: '您没有权限执行此操作'
	String get errorForbidden => '您没有权限执行此操作';

	/// zh: '请求的资源不存在'
	String get errorNotFound => '请求的资源不存在';

	/// zh: '请求参数有误，请检查后重试'
	String get errorBadRequest => '请求参数有误，请检查后重试';

	/// zh: '数据解析失败，请稍后重试'
	String get errorParseError => '数据解析失败，请稍后重试';

	/// zh: '规则解析失败：$message'
	String errorRuleParseError({required Object message}) => '规则解析失败：${message}';

	/// zh: '规则执行失败：$message'
	String errorRuleExecutionError({required Object message}) => '规则执行失败：${message}';

	/// zh: '选择器匹配失败：$selector'
	String errorSelectorError({required Object selector}) => '选择器匹配失败：${selector}';

	/// zh: '密码长度不能少于 $count 位'
	String errorWeakPassword({required Object count}) => '密码长度不能少于 ${count} 位';

	/// zh: '用户名 "$username" 已存在'
	String errorUsernameExists({required Object username}) => '用户名 "${username}" 已存在';

	/// zh: '数据库操作失败，请稍后重试'
	String get errorDatabaseError => '数据库操作失败，请稍后重试';

	/// zh: '缓存操作失败，请稍后重试'
	String get errorCacheError => '缓存操作失败，请稍后重试';

	/// zh: '发生未知错误，请稍后重试'
	String get errorUnknown => '发生未知错误，请稍后重试';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Spectra',
			'appDescription' => '一款现代化的多媒体数据采集应用',
			'selectorTypeCss' => 'CSS',
			'selectorTypeXpath' => 'XPath',
			'settingsTitle' => '设置',
			'themeMode' => '主题模式',
			'themeModeDark' => '深色',
			'themeModeLight' => '浅色',
			'themeModeSystem' => '跟随系统',
			'language' => '语言',
			'languageEnglish' => '英文',
			'languageChinese' => '中文',
			'goHome' => '返回首页',
			'pageNotFound' => '404 - 页面未找到',
			'appearanceSettings' => '外观',
			'about' => '关于',
			'version' => '版本',
			'developerTools' => '开发者工具',
			'ruleEditor' => '规则编辑器',
			'ruleEditorDescription' => '打开网页端爬虫规则编辑器',
			'rulesPageTitle' => '规则管理',
			'rulesPageEmpty' => '暂无规则，请先导入规则文件',
			'rulesImportButton' => '导入规则',
			'rulesImportFileButton' => '导入文件',
			'rulesImportUrlButton' => '从 URL 导入',
			'rulesImportFailedTitle' => '规则导入失败',
			'rulesImportFilePathMissing' => '无法读取所选文件路径，请重新选择',
			'rulesImportSuccess' => ({required Object ruleName}) => '规则导入成功：${ruleName}',
			'rulesImportSuccessPlain' => '规则导入成功',
			'rulesImporting' => '正在导入规则...',
			'rulesImportUrlTitle' => '从 URL 导入',
			'rulesImportUrlHint' => '请输入规则 URL',
			'rulesImportUrlHelper' => '仅支持 http/https 规则地址',
			'rulesImportUrlSubmit' => '开始导入',
			'rulesExecutePageTitle' => '运行时工作区',
			'rulesExecutePageDescription' => '在 Flutter 侧统一查看服务器状态、当前 session、活跃预览、执行结果与节点事件时间线，并直接发起预览与执行。',
			'rulesExecuteWorkspaceSection' => '工作区上下文',
			'rulesExecuteSessionLabel' => '当前 Session',
			'rulesExecuteRuleLabel' => '执行规则',
			'rulesExecuteNoRules' => '当前没有可执行规则，请先通过现有规则接口创建规则。',
			'rulesExecuteRunButton' => '执行规则',
			'rulesExecuteResponseSection' => '执行响应 JSON',
			'rulesExecuteRunsSection' => '运行注册表',
			'rulesExecuteNoRuns' => '当前 session 还没有运行记录',
			'rulesExecuteActivePreviewLabel' => '活跃预览',
			'rulesExecuteNoActivePreview' => '当前没有活跃预览',
			'rulesExecuteDebugUrlLabel' => '调试地址',
			'rulesExecuteTimelineSection' => '节点事件时间线',
			'rulesExecuteTimelineEmpty' => '当前 session 还没有时间线事件',
			'rulesExecuteTimelineConnected' => '时间线已连接',
			'rulesExecuteTimelineDisconnected' => '时间线未连接',
			'rulesExecuteRunStatusAccepted' => '已受理',
			'rulesExecuteRunStatusRunning' => '执行中',
			'rulesExecuteRunStatusFinished' => '已完成',
			'serverStatus' => '服务器状态',
			'serverRunning' => '运行中',
			'serverStopped' => '已停止',
			'serverStart' => '启动服务器',
			'serverStop' => '停止服务器',
			'serverUrl' => '服务器地址',
			'openInBrowser' => '在浏览器中打开',
			'retry' => '重试',
			'previewPage' => '页面预览',
			'enterUrl' => '输入网址',
			'enterUrlToPreview' => '输入网址以预览页面',
			'go' => '前往',
			'refresh' => '刷新',
			'selectElement' => '选择元素',
			'cancelSelection' => '取消选择',
			'tapToSelectElement' => '点击页面以选择元素',
			'cancel' => '取消',
			'copy' => '复制',
			'selectedElement' => '已选元素',
			'textContent' => '文本内容',
			'webViewPlaceholder' => 'WebView 将在此显示',
			'selectorTestSection' => '选择器测试',
			'selectorTestButton' => '测试选择器',
			'selectorClearResult' => '清除结果',
			'selectorExpressionLabel' => '选择器表达式',
			'selectorCssHint' => '例如：div.content > h1',
			'selectorXPathHint' => '例如：//div[@class="content"]',
			'selectorMatchSuccess' => ({required Object count}) => '匹配成功 (${count} 个元素)',
			'selectorMatchFailed' => '匹配失败',
			'selectorMatchError' => ({required Object error}) => '错误：${error}',
			'selectorMatchSamples' => '匹配样本',
			'selectorMatchMore' => ({required Object count}) => '还有 ${count} 个匹配元素...',
			'selectorElementText' => '文本',
			'selectorElementHtml' => 'HTML',
			'navFavorites' => '收藏',
			'navDiscover' => '发现',
			'navSearch' => '搜索',
			'favoritesPageTitle' => '我的收藏',
			'favoritesPageSubtitle' => '管理您收藏的多媒体内容',
			'favoritesEmptyTitle' => '还没有收藏',
			'favoritesEmptySubtitle' => '去发现页浏览并收藏您喜欢的内容',
			'favoritesRecent' => '最近观看',
			'favoritesAll' => '全部收藏',
			'mediaTypeAll' => '全部',
			'mediaTypeVideo' => '视频',
			'mediaTypeMusic' => '音乐',
			'mediaTypeNovel' => '小说',
			'mediaTypeComic' => '漫画',
			'mediaTypeImage' => '图片',
			'noRecentHistory' => '暂无最近观看记录',
			'goToDiscover' => '去发现',
			'discoverPageTitle' => '发现',
			'discoverPageSubtitle' => '探索精彩内容',
			'discoverSelectRule' => '选择规则',
			'discoverSelectRuleHint' => '选择一个规则开始探索',
			'discoverSelectRuleDescription' => '从上方选择一个数据源规则，发现精彩内容',
			'discoverNoRules' => '暂无可用规则',
			'discoverLoadMore' => '加载更多',
			'discoverNoMoreData' => '没有更多数据了',
			'settingsDataStorage' => '数据存储',
			'settingsCacheSize' => '缓存大小',
			'settingsClearCache' => '清除缓存',
			'settingsClearCacheConfirm' => '确定要清除所有缓存吗？此操作不可恢复。',
			'settingsCacheCleared' => '缓存已清除',
			'settingsExportFavorites' => '导出收藏',
			'settingsImportFavorites' => '导入收藏',
			'settingsPlayback' => '播放预览',
			'settingsAutoPlay' => '自动播放',
			'settingsAutoPlayOn' => '开启',
			'settingsAutoPlayOff' => '关闭',
			'settingsDefaultQuality' => '默认画质',
			'settingsQualityAuto' => '自动',
			'settingsQualityHigh' => '高清',
			'settingsQualityStandard' => '标清',
			'settingsQualityLow' => '流畅',
			'actionConfirm' => '确定',
			'actionCancel' => '取消',
			'actionClose' => '关闭',
			'searchPageTitle' => '搜索',
			'searchPageSubtitle' => '搜索视频、音乐、小说、漫画、图片',
			'searchHint' => '输入关键词搜索...',
			'searchHistory' => '搜索历史',
			'searchClearHistory' => '清除历史',
			'searchHot' => '热门搜索',
			'searchResults' => '搜索结果',
			'searchNoResults' => '没有找到相关内容',
			'searchTabAll' => '全部',
			'searchTabVideo' => '视频',
			'searchTabMusic' => '音乐',
			'searchTabNovel' => '小说',
			'searchTabComic' => '漫画',
			'searchTabImage' => '图片',
			'errorTitleDefault' => '提示',
			'errorTitleNetwork' => '网络错误',
			'errorTitleAuth' => '身份验证失败',
			'errorTitlePermission' => '权限不足',
			'errorTitleRule' => '规则错误',
			'errorTitleUnknown' => '未知错误',
			'errorNetworkUnreachable' => '网络不可达，请检查您的网络连接',
			'errorConnectionTimeout' => '连接超时，请稍后重试',
			'errorServerError' => ({required Object code}) => '服务器内部错误 (${code})',
			'errorUnauthorized' => '登录已过期，请重新登录',
			'errorForbidden' => '您没有权限执行此操作',
			'errorNotFound' => '请求的资源不存在',
			'errorBadRequest' => '请求参数有误，请检查后重试',
			'errorParseError' => '数据解析失败，请稍后重试',
			'errorRuleParseError' => ({required Object message}) => '规则解析失败：${message}',
			'errorRuleExecutionError' => ({required Object message}) => '规则执行失败：${message}',
			'errorSelectorError' => ({required Object selector}) => '选择器匹配失败：${selector}',
			'errorWeakPassword' => ({required Object count}) => '密码长度不能少于 ${count} 位',
			'errorUsernameExists' => ({required Object username}) => '用户名 "${username}" 已存在',
			'errorDatabaseError' => '数据库操作失败，请稍后重试',
			'errorCacheError' => '缓存操作失败，请稍后重试',
			'errorUnknown' => '发生未知错误，请稍后重试',
			_ => null,
		};
	}
}
