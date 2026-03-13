///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override String get appName => 'Spectra';
	@override String get appDescription => 'A modern multimedia data collection application';
	@override String get selectorTypeCss => 'CSS';
	@override String get selectorTypeXpath => 'XPath';
	@override String get settingsTitle => 'Settings';
	@override String get themeMode => 'Theme Mode';
	@override String get themeModeDark => 'Dark';
	@override String get themeModeLight => 'Light';
	@override String get themeModeSystem => 'System';
	@override String get language => 'Language';
	@override String get languageEnglish => 'English';
	@override String get languageChinese => 'Chinese';
	@override String get goHome => 'Go Home';
	@override String get pageNotFound => '404 - Page Not Found';
	@override String get appearanceSettings => 'Appearance';
	@override String get about => 'About';
	@override String get version => 'Version';
	@override String get developerTools => 'Developer Tools';
	@override String get ruleEditor => 'Rule Editor';
	@override String get ruleEditorDescription => 'Open web-based rule editor for crawler rules';
	@override String get rulesPageTitle => 'Rules';
	@override String get rulesPageEmpty => 'No rules yet. Import a rule file to get started.';
	@override String get rulesImportButton => 'Import Rule';
	@override String get rulesImportFileButton => 'Import File';
	@override String get rulesImportUrlButton => 'Import from URL';
	@override String get rulesImportFailedTitle => 'Rule Import Failed';
	@override String get rulesImportFilePathMissing => 'Unable to read the selected file path. Please try again.';
	@override String rulesImportSuccess({required Object ruleName}) => 'Rule imported: ${ruleName}';
	@override String get rulesImportSuccessPlain => 'Rule imported successfully';
	@override String get rulesImporting => 'Importing rule...';
	@override String get rulesImportUrlTitle => 'Import from URL';
	@override String get rulesImportUrlHint => 'Enter the rule URL';
	@override String get rulesImportUrlHelper => 'Only http/https rule URLs are supported';
	@override String get rulesImportUrlSubmit => 'Import';
	@override String get rulesExecutePageTitle => 'Runtime Workspace';
	@override String get rulesExecutePageDescription => 'Manage server status, the active Flutter session, preview state, run results, and node event timeline from one Flutter-owned runtime workspace.';
	@override String get rulesExecuteWorkspaceSection => 'Workspace Context';
	@override String get rulesExecuteSessionLabel => 'Current Session';
	@override String get rulesExecuteRuleLabel => 'Execution Rule';
	@override String get rulesExecuteNoRules => 'No executable rules are available yet. Create one through the existing rules API first.';
	@override String get rulesExecuteRunButton => 'Execute Rule';
	@override String get rulesExecuteResponseSection => 'Execute Response JSON';
	@override String get rulesExecuteRunsSection => 'Run Registry';
	@override String get rulesExecuteNoRuns => 'No runs have been created for this session yet';
	@override String get rulesExecuteActivePreviewLabel => 'Active Preview';
	@override String get rulesExecuteNoActivePreview => 'No active preview is attached to this session';
	@override String get rulesExecuteDebugUrlLabel => 'Debug URL';
	@override String get rulesExecuteTimelineSection => 'Node Event Timeline';
	@override String get rulesExecuteTimelineEmpty => 'No timeline events are available for this session yet';
	@override String get rulesExecuteTimelineConnected => 'Timeline connected';
	@override String get rulesExecuteTimelineDisconnected => 'Timeline disconnected';
	@override String get rulesExecuteRunStatusAccepted => 'Accepted';
	@override String get rulesExecuteRunStatusRunning => 'Running';
	@override String get rulesExecuteRunStatusFinished => 'Finished';
	@override String get serverStatus => 'Server Status';
	@override String get serverRunning => 'Running';
	@override String get serverStopped => 'Stopped';
	@override String get serverStart => 'Start Server';
	@override String get serverStop => 'Stop Server';
	@override String get serverUrl => 'Server URL';
	@override String get openInBrowser => 'Open in Browser';
	@override String get retry => 'Retry';
	@override String get previewPage => 'Page Preview';
	@override String get enterUrl => 'Enter URL';
	@override String get enterUrlToPreview => 'Enter a URL to preview the page';
	@override String get go => 'Go';
	@override String get refresh => 'Refresh';
	@override String get selectElement => 'Select Element';
	@override String get cancelSelection => 'Cancel Selection';
	@override String get tapToSelectElement => 'Tap on the page to select an element';
	@override String get cancel => 'Cancel';
	@override String get copy => 'Copy';
	@override String get selectedElement => 'Selected Element';
	@override String get textContent => 'Text Content';
	@override String get webViewPlaceholder => 'WebView will be displayed here';
	@override String get selectorTestSection => 'Selector Test';
	@override String get selectorTestButton => 'Test Selector';
	@override String get selectorClearResult => 'Clear Result';
	@override String get selectorExpressionLabel => 'Selector Expression';
	@override String get selectorCssHint => 'e.g., div.content > h1';
	@override String get selectorXPathHint => 'e.g., //div[@class="content"]';
	@override String selectorMatchSuccess({required Object count}) => 'Match Success (${count} elements)';
	@override String get selectorMatchFailed => 'Match Failed';
	@override String selectorMatchError({required Object error}) => 'Error: ${error}';
	@override String get selectorMatchSamples => 'Matched Samples';
	@override String selectorMatchMore({required Object count}) => '${count} more matched elements...';
	@override String get selectorElementText => 'Text';
	@override String get selectorElementHtml => 'HTML';
	@override String get navFavorites => 'Favorites';
	@override String get navDiscover => 'Discover';
	@override String get navSearch => 'Search';
	@override String get favoritesPageTitle => 'My Favorites';
	@override String get favoritesPageSubtitle => 'Manage your favorite multimedia content';
	@override String get favoritesEmptyTitle => 'No favorites yet';
	@override String get favoritesEmptySubtitle => 'Go to Discover to browse and save content you like';
	@override String get favoritesRecent => 'Recently Viewed';
	@override String get favoritesAll => 'All Favorites';
	@override String get mediaTypeAll => 'All';
	@override String get mediaTypeVideo => 'Video';
	@override String get mediaTypeMusic => 'Music';
	@override String get mediaTypeNovel => 'Novel';
	@override String get mediaTypeComic => 'Comic';
	@override String get mediaTypeImage => 'Image';
	@override String get noRecentHistory => 'No recent viewing history';
	@override String get goToDiscover => 'Go to Discover';
	@override String get discoverPageTitle => 'Discover';
	@override String get discoverPageSubtitle => 'Explore amazing content';
	@override String get discoverSelectRule => 'Select Rule';
	@override String get discoverSelectRuleHint => 'Select a rule to start exploring';
	@override String get discoverSelectRuleDescription => 'Choose a data source rule above to discover great content';
	@override String get discoverNoRules => 'No rules available';
	@override String get discoverLoadMore => 'Load More';
	@override String get discoverNoMoreData => 'No more data';
	@override String get settingsDataStorage => 'Data Storage';
	@override String get settingsCacheSize => 'Cache Size';
	@override String get settingsClearCache => 'Clear Cache';
	@override String get settingsClearCacheConfirm => 'Are you sure you want to clear all cache? This action cannot be undone.';
	@override String get settingsCacheCleared => 'Cache cleared';
	@override String get settingsExportFavorites => 'Export Favorites';
	@override String get settingsImportFavorites => 'Import Favorites';
	@override String get settingsPlayback => 'Playback';
	@override String get settingsAutoPlay => 'Auto Play';
	@override String get settingsAutoPlayOn => 'On';
	@override String get settingsAutoPlayOff => 'Off';
	@override String get settingsDefaultQuality => 'Default Quality';
	@override String get settingsQualityAuto => 'Auto';
	@override String get settingsQualityHigh => 'High';
	@override String get settingsQualityStandard => 'Standard';
	@override String get settingsQualityLow => 'Low';
	@override String get actionConfirm => 'Confirm';
	@override String get actionCancel => 'Cancel';
	@override String get actionClose => 'Close';
	@override String get searchPageTitle => 'Search';
	@override String get searchPageSubtitle => 'Search videos, music, novels, comics, images';
	@override String get searchHint => 'Enter keywords to search...';
	@override String get searchHistory => 'Search History';
	@override String get searchClearHistory => 'Clear History';
	@override String get searchHot => 'Hot Searches';
	@override String get searchResults => 'Search Results';
	@override String get searchNoResults => 'No related content found';
	@override String get searchTabAll => 'All';
	@override String get searchTabVideo => 'Video';
	@override String get searchTabMusic => 'Music';
	@override String get searchTabNovel => 'Novel';
	@override String get searchTabComic => 'Comic';
	@override String get searchTabImage => 'Image';
	@override String get errorTitleDefault => 'Notice';
	@override String get errorTitleNetwork => 'Network Error';
	@override String get errorTitleAuth => 'Authentication Failed';
	@override String get errorTitlePermission => 'Permission Denied';
	@override String get errorTitleRule => 'Rule Error';
	@override String get errorTitleUnknown => 'Unknown Error';
	@override String get errorNetworkUnreachable => 'Network unreachable. Please check your connection.';
	@override String get errorConnectionTimeout => 'Connection timed out. Please try again later.';
	@override String errorServerError({required Object code}) => 'Server error (${code})';
	@override String get errorUnauthorized => 'Session expired. Please log in again.';
	@override String get errorForbidden => 'You don\'t have permission to perform this action.';
	@override String get errorNotFound => 'The requested resource was not found.';
	@override String get errorBadRequest => 'Invalid request parameters. Please check and try again.';
	@override String get errorParseError => 'Failed to parse data. Please try again later.';
	@override String errorRuleParseError({required Object message}) => 'Rule parse error: ${message}';
	@override String errorRuleExecutionError({required Object message}) => 'Rule execution error: ${message}';
	@override String errorSelectorError({required Object selector}) => 'Selector matching failed: ${selector}';
	@override String errorWeakPassword({required Object count}) => 'Password must be at least ${count} characters long.';
	@override String errorUsernameExists({required Object username}) => 'Username "${username}" already exists.';
	@override String get errorDatabaseError => 'Database operation failed. Please try again later.';
	@override String get errorCacheError => 'Cache operation failed. Please try again later.';
	@override String get errorUnknown => 'An unknown error occurred. Please try again later.';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'appName' => 'Spectra',
			'appDescription' => 'A modern multimedia data collection application',
			'selectorTypeCss' => 'CSS',
			'selectorTypeXpath' => 'XPath',
			'settingsTitle' => 'Settings',
			'themeMode' => 'Theme Mode',
			'themeModeDark' => 'Dark',
			'themeModeLight' => 'Light',
			'themeModeSystem' => 'System',
			'language' => 'Language',
			'languageEnglish' => 'English',
			'languageChinese' => 'Chinese',
			'goHome' => 'Go Home',
			'pageNotFound' => '404 - Page Not Found',
			'appearanceSettings' => 'Appearance',
			'about' => 'About',
			'version' => 'Version',
			'developerTools' => 'Developer Tools',
			'ruleEditor' => 'Rule Editor',
			'ruleEditorDescription' => 'Open web-based rule editor for crawler rules',
			'rulesPageTitle' => 'Rules',
			'rulesPageEmpty' => 'No rules yet. Import a rule file to get started.',
			'rulesImportButton' => 'Import Rule',
			'rulesImportFileButton' => 'Import File',
			'rulesImportUrlButton' => 'Import from URL',
			'rulesImportFailedTitle' => 'Rule Import Failed',
			'rulesImportFilePathMissing' => 'Unable to read the selected file path. Please try again.',
			'rulesImportSuccess' => ({required Object ruleName}) => 'Rule imported: ${ruleName}',
			'rulesImportSuccessPlain' => 'Rule imported successfully',
			'rulesImporting' => 'Importing rule...',
			'rulesImportUrlTitle' => 'Import from URL',
			'rulesImportUrlHint' => 'Enter the rule URL',
			'rulesImportUrlHelper' => 'Only http/https rule URLs are supported',
			'rulesImportUrlSubmit' => 'Import',
			'rulesExecutePageTitle' => 'Runtime Workspace',
			'rulesExecutePageDescription' => 'Manage server status, the active Flutter session, preview state, run results, and node event timeline from one Flutter-owned runtime workspace.',
			'rulesExecuteWorkspaceSection' => 'Workspace Context',
			'rulesExecuteSessionLabel' => 'Current Session',
			'rulesExecuteRuleLabel' => 'Execution Rule',
			'rulesExecuteNoRules' => 'No executable rules are available yet. Create one through the existing rules API first.',
			'rulesExecuteRunButton' => 'Execute Rule',
			'rulesExecuteResponseSection' => 'Execute Response JSON',
			'rulesExecuteRunsSection' => 'Run Registry',
			'rulesExecuteNoRuns' => 'No runs have been created for this session yet',
			'rulesExecuteActivePreviewLabel' => 'Active Preview',
			'rulesExecuteNoActivePreview' => 'No active preview is attached to this session',
			'rulesExecuteDebugUrlLabel' => 'Debug URL',
			'rulesExecuteTimelineSection' => 'Node Event Timeline',
			'rulesExecuteTimelineEmpty' => 'No timeline events are available for this session yet',
			'rulesExecuteTimelineConnected' => 'Timeline connected',
			'rulesExecuteTimelineDisconnected' => 'Timeline disconnected',
			'rulesExecuteRunStatusAccepted' => 'Accepted',
			'rulesExecuteRunStatusRunning' => 'Running',
			'rulesExecuteRunStatusFinished' => 'Finished',
			'serverStatus' => 'Server Status',
			'serverRunning' => 'Running',
			'serverStopped' => 'Stopped',
			'serverStart' => 'Start Server',
			'serverStop' => 'Stop Server',
			'serverUrl' => 'Server URL',
			'openInBrowser' => 'Open in Browser',
			'retry' => 'Retry',
			'previewPage' => 'Page Preview',
			'enterUrl' => 'Enter URL',
			'enterUrlToPreview' => 'Enter a URL to preview the page',
			'go' => 'Go',
			'refresh' => 'Refresh',
			'selectElement' => 'Select Element',
			'cancelSelection' => 'Cancel Selection',
			'tapToSelectElement' => 'Tap on the page to select an element',
			'cancel' => 'Cancel',
			'copy' => 'Copy',
			'selectedElement' => 'Selected Element',
			'textContent' => 'Text Content',
			'webViewPlaceholder' => 'WebView will be displayed here',
			'selectorTestSection' => 'Selector Test',
			'selectorTestButton' => 'Test Selector',
			'selectorClearResult' => 'Clear Result',
			'selectorExpressionLabel' => 'Selector Expression',
			'selectorCssHint' => 'e.g., div.content > h1',
			'selectorXPathHint' => 'e.g., //div[@class="content"]',
			'selectorMatchSuccess' => ({required Object count}) => 'Match Success (${count} elements)',
			'selectorMatchFailed' => 'Match Failed',
			'selectorMatchError' => ({required Object error}) => 'Error: ${error}',
			'selectorMatchSamples' => 'Matched Samples',
			'selectorMatchMore' => ({required Object count}) => '${count} more matched elements...',
			'selectorElementText' => 'Text',
			'selectorElementHtml' => 'HTML',
			'navFavorites' => 'Favorites',
			'navDiscover' => 'Discover',
			'navSearch' => 'Search',
			'favoritesPageTitle' => 'My Favorites',
			'favoritesPageSubtitle' => 'Manage your favorite multimedia content',
			'favoritesEmptyTitle' => 'No favorites yet',
			'favoritesEmptySubtitle' => 'Go to Discover to browse and save content you like',
			'favoritesRecent' => 'Recently Viewed',
			'favoritesAll' => 'All Favorites',
			'mediaTypeAll' => 'All',
			'mediaTypeVideo' => 'Video',
			'mediaTypeMusic' => 'Music',
			'mediaTypeNovel' => 'Novel',
			'mediaTypeComic' => 'Comic',
			'mediaTypeImage' => 'Image',
			'noRecentHistory' => 'No recent viewing history',
			'goToDiscover' => 'Go to Discover',
			'discoverPageTitle' => 'Discover',
			'discoverPageSubtitle' => 'Explore amazing content',
			'discoverSelectRule' => 'Select Rule',
			'discoverSelectRuleHint' => 'Select a rule to start exploring',
			'discoverSelectRuleDescription' => 'Choose a data source rule above to discover great content',
			'discoverNoRules' => 'No rules available',
			'discoverLoadMore' => 'Load More',
			'discoverNoMoreData' => 'No more data',
			'settingsDataStorage' => 'Data Storage',
			'settingsCacheSize' => 'Cache Size',
			'settingsClearCache' => 'Clear Cache',
			'settingsClearCacheConfirm' => 'Are you sure you want to clear all cache? This action cannot be undone.',
			'settingsCacheCleared' => 'Cache cleared',
			'settingsExportFavorites' => 'Export Favorites',
			'settingsImportFavorites' => 'Import Favorites',
			'settingsPlayback' => 'Playback',
			'settingsAutoPlay' => 'Auto Play',
			'settingsAutoPlayOn' => 'On',
			'settingsAutoPlayOff' => 'Off',
			'settingsDefaultQuality' => 'Default Quality',
			'settingsQualityAuto' => 'Auto',
			'settingsQualityHigh' => 'High',
			'settingsQualityStandard' => 'Standard',
			'settingsQualityLow' => 'Low',
			'actionConfirm' => 'Confirm',
			'actionCancel' => 'Cancel',
			'actionClose' => 'Close',
			'searchPageTitle' => 'Search',
			'searchPageSubtitle' => 'Search videos, music, novels, comics, images',
			'searchHint' => 'Enter keywords to search...',
			'searchHistory' => 'Search History',
			'searchClearHistory' => 'Clear History',
			'searchHot' => 'Hot Searches',
			'searchResults' => 'Search Results',
			'searchNoResults' => 'No related content found',
			'searchTabAll' => 'All',
			'searchTabVideo' => 'Video',
			'searchTabMusic' => 'Music',
			'searchTabNovel' => 'Novel',
			'searchTabComic' => 'Comic',
			'searchTabImage' => 'Image',
			'errorTitleDefault' => 'Notice',
			'errorTitleNetwork' => 'Network Error',
			'errorTitleAuth' => 'Authentication Failed',
			'errorTitlePermission' => 'Permission Denied',
			'errorTitleRule' => 'Rule Error',
			'errorTitleUnknown' => 'Unknown Error',
			'errorNetworkUnreachable' => 'Network unreachable. Please check your connection.',
			'errorConnectionTimeout' => 'Connection timed out. Please try again later.',
			'errorServerError' => ({required Object code}) => 'Server error (${code})',
			'errorUnauthorized' => 'Session expired. Please log in again.',
			'errorForbidden' => 'You don\'t have permission to perform this action.',
			'errorNotFound' => 'The requested resource was not found.',
			'errorBadRequest' => 'Invalid request parameters. Please check and try again.',
			'errorParseError' => 'Failed to parse data. Please try again later.',
			'errorRuleParseError' => ({required Object message}) => 'Rule parse error: ${message}',
			'errorRuleExecutionError' => ({required Object message}) => 'Rule execution error: ${message}',
			'errorSelectorError' => ({required Object selector}) => 'Selector matching failed: ${selector}',
			'errorWeakPassword' => ({required Object count}) => 'Password must be at least ${count} characters long.',
			'errorUsernameExists' => ({required Object username}) => 'Username "${username}" already exists.',
			'errorDatabaseError' => 'Database operation failed. Please try again later.',
			'errorCacheError' => 'Cache operation failed. Please try again later.',
			'errorUnknown' => 'An unknown error occurred. Please try again later.',
			_ => null,
		};
	}
}
