// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Spectra';

  @override
  String get homeTitle => 'Welcome to Spectra';

  @override
  String get homeSubtitle => 'A modern multimedia data collection application';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeMode => 'Theme Mode';

  @override
  String get themeModeDark => 'Dark';

  @override
  String get themeModeLight => 'Light';

  @override
  String get themeModeSystem => 'System';

  @override
  String get language => 'Language';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageChinese => 'Chinese';

  @override
  String get featureVideo => 'Video Collection';

  @override
  String get featureMusic => 'Music Collection';

  @override
  String get featureNovel => 'Novel Collection';

  @override
  String get featureComic => 'Comic Collection';

  @override
  String get featureImage => 'Image Collection';

  @override
  String get goHome => 'Go Home';

  @override
  String get pageNotFound => '404 - Page Not Found';

  @override
  String get appearanceSettings => 'Appearance';

  @override
  String get generalSettings => 'General';

  @override
  String get currentTheme => 'Current theme';

  @override
  String get currentLanguage => 'Current language';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get back => 'Back';

  @override
  String get developerTools => 'Developer Tools';

  @override
  String get ruleEditor => 'Rule Editor';

  @override
  String get ruleEditorDescription => 'Open web-based rule editor for crawler rules';

  @override
  String get rulesExecutePageTitle => 'Runtime Workspace';

  @override
  String get rulesExecutePageDescription => 'Manage server status, the active Flutter session, preview state, run results, and node event timeline from one Flutter-owned runtime workspace.';

  @override
  String get rulesExecuteWorkspaceSection => 'Workspace Context';

  @override
  String get rulesExecuteSessionLabel => 'Current Session';

  @override
  String get rulesExecuteRuleLabel => 'Execution Rule';

  @override
  String get rulesExecuteNoRules => 'No executable rules are available yet. Create one through the existing rules API first.';

  @override
  String get rulesExecuteRunButton => 'Execute Rule';

  @override
  String get rulesExecuteResponseSection => 'Execute Response JSON';

  @override
  String get rulesExecuteRunsSection => 'Run Registry';

  @override
  String get rulesExecuteNoRuns => 'No runs have been created for this session yet';

  @override
  String get rulesExecuteActivePreviewLabel => 'Active Preview';

  @override
  String get rulesExecuteNoActivePreview => 'No active preview is attached to this session';

  @override
  String get rulesExecuteDebugUrlLabel => 'Debug URL';

  @override
  String get rulesExecuteTimelineSection => 'Node Event Timeline';

  @override
  String get rulesExecuteTimelineEmpty => 'No timeline events are available for this session yet';

  @override
  String get rulesExecuteTimelineConnected => 'Timeline connected';

  @override
  String get rulesExecuteTimelineDisconnected => 'Timeline disconnected';

  @override
  String get rulesExecuteRunStatusAccepted => 'Accepted';

  @override
  String get rulesExecuteRunStatusRunning => 'Running';

  @override
  String get rulesExecuteRunStatusFinished => 'Finished';

  @override
  String get rulesExecuteNormalizedSection => 'Normalized Result JSON';

  @override
  String get rulesExecuteSearchSection => 'Search';

  @override
  String get rulesExecuteDetailSection => 'Detail';

  @override
  String get rulesExecuteTocSection => 'Toc';

  @override
  String get rulesExecuteContentSection => 'Content';

  @override
  String get rulesExecuteEmptyState => 'No content is available for this section yet';

  @override
  String get serverStatus => 'Server Status';

  @override
  String get serverRunning => 'Running';

  @override
  String get serverStopped => 'Stopped';

  @override
  String get serverStart => 'Start Server';

  @override
  String get serverStop => 'Stop Server';

  @override
  String get serverUrl => 'Server URL';

  @override
  String get openInBrowser => 'Open in Browser';

  @override
  String get serverStartError => 'Failed to start server';

  @override
  String get errorTitleDefault => 'Notice';

  @override
  String get errorTitleNetwork => 'Network Error';

  @override
  String get errorTitleAuth => 'Authentication Failed';

  @override
  String get errorTitlePermission => 'Permission Denied';

  @override
  String get errorTitleRule => 'Rule Error';

  @override
  String get errorTitleUnknown => 'Unknown Error';

  @override
  String get errorNetworkUnreachable => 'Network unreachable. Please check your connection.';

  @override
  String get errorConnectionTimeout => 'Connection timed out. Please try again later.';

  @override
  String errorServerError(Object code) {
    return 'Server error ($code)';
  }

  @override
  String get errorUnauthorized => 'Session expired. Please log in again.';

  @override
  String get errorForbidden => 'You don\'t have permission to perform this action.';

  @override
  String get errorNotFound => 'The requested resource was not found.';

  @override
  String get errorBadRequest => 'Invalid request parameters. Please check and try again.';

  @override
  String get errorParseError => 'Failed to parse data. Please try again later.';

  @override
  String errorRuleParseError(Object message) {
    return 'Rule parse error: $message';
  }

  @override
  String errorRuleExecutionError(Object message) {
    return 'Rule execution error: $message';
  }

  @override
  String errorSelectorError(Object selector) {
    return 'Selector matching failed: $selector';
  }

  @override
  String errorWeakPassword(Object count) {
    return 'Password must be at least $count characters long.';
  }

  @override
  String errorUsernameExists(Object username) {
    return 'Username \"$username\" already exists.';
  }

  @override
  String get errorDatabaseError => 'Database operation failed. Please try again later.';

  @override
  String get errorCacheError => 'Cache operation failed. Please try again later.';

  @override
  String get errorUnknown => 'An unknown error occurred. Please try again later.';

  @override
  String get retry => 'Retry';

  @override
  String get previewPage => 'Page Preview';

  @override
  String get enterUrl => 'Enter URL';

  @override
  String get enterUrlToPreview => 'Enter a URL to preview the page';

  @override
  String get go => 'Go';

  @override
  String get refresh => 'Refresh';

  @override
  String get selectElement => 'Select Element';

  @override
  String get cancelSelection => 'Cancel Selection';

  @override
  String get tapToSelectElement => 'Tap on the page to select an element';

  @override
  String get cancel => 'Cancel';

  @override
  String get copy => 'Copy';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get selectedElement => 'Selected Element';

  @override
  String get textContent => 'Text Content';

  @override
  String get sendToEditor => 'Send to Editor';

  @override
  String get webViewPlaceholder => 'WebView will be displayed here';

  @override
  String get selectorTestSection => 'Selector Test';

  @override
  String get selectorTestButton => 'Test Selector';

  @override
  String get selectorClearResult => 'Clear Result';

  @override
  String get selectorExpressionLabel => 'Selector Expression';

  @override
  String get selectorCssHint => 'e.g., div.content > h1';

  @override
  String get selectorXPathHint => 'e.g., //div[@class=\"content\"]';

  @override
  String selectorMatchSuccess(Object count) {
    return 'Match Success ($count elements)';
  }

  @override
  String get selectorMatchFailed => 'Match Failed';

  @override
  String selectorMatchError(Object error) {
    return 'Error: $error';
  }

  @override
  String get selectorMatchSamples => 'Matched Samples';

  @override
  String selectorMatchMore(Object count) {
    return '$count more matched elements...';
  }

  @override
  String get selectorElementText => 'Text';

  @override
  String get selectorElementHtml => 'HTML';

  @override
  String get navFavorites => 'Favorites';

  @override
  String get navDiscover => 'Discover';

  @override
  String get navSearch => 'Search';

  @override
  String get favoritesPageTitle => 'My Favorites';

  @override
  String get favoritesPageSubtitle => 'Manage your favorite multimedia content';

  @override
  String get favoritesEmptyTitle => 'No favorites yet';

  @override
  String get favoritesEmptySubtitle => 'Go to Discover to browse and save content you like';

  @override
  String get favoritesRecent => 'Recently Viewed';

  @override
  String get favoritesAll => 'All Favorites';

  @override
  String get mediaTypeAll => 'All';

  @override
  String get mediaTypeVideo => 'Video';

  @override
  String get mediaTypeMusic => 'Music';

  @override
  String get mediaTypeNovel => 'Novel';

  @override
  String get mediaTypeComic => 'Comic';

  @override
  String get mediaTypeImage => 'Image';

  @override
  String get noRecentHistory => 'No recent viewing history';

  @override
  String get goToDiscover => 'Go to Discover';

  @override
  String get discoverPageTitle => 'Discover';

  @override
  String get discoverPageSubtitle => 'Explore amazing content';

  @override
  String get discoverSelectRule => 'Select Rule';

  @override
  String get discoverSelectRuleHint => 'Select a rule to start exploring';

  @override
  String get discoverSelectRuleDescription => 'Choose a data source rule above to discover great content';

  @override
  String get discoverNoRules => 'No rules available';

  @override
  String get discoverLoadMore => 'Load More';

  @override
  String get discoverNoMoreData => 'No more data';

  @override
  String get settingsDataStorage => 'Data Storage';

  @override
  String get settingsCacheSize => 'Cache Size';

  @override
  String get settingsClearCache => 'Clear Cache';

  @override
  String get settingsClearCacheConfirm => 'Are you sure you want to clear all cache? This action cannot be undone.';

  @override
  String get settingsCacheCleared => 'Cache cleared';

  @override
  String get settingsExportFavorites => 'Export Favorites';

  @override
  String get settingsImportFavorites => 'Import Favorites';

  @override
  String get settingsPlayback => 'Playback';

  @override
  String get settingsAutoPlay => 'Auto Play';

  @override
  String get settingsAutoPlayOn => 'On';

  @override
  String get settingsAutoPlayOff => 'Off';

  @override
  String get settingsDefaultQuality => 'Default Quality';

  @override
  String get settingsQualityAuto => 'Auto';

  @override
  String get settingsQualityHigh => 'High';

  @override
  String get settingsQualityStandard => 'Standard';

  @override
  String get settingsQualityLow => 'Low';

  @override
  String get actionConfirm => 'Confirm';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionClose => 'Close';

  @override
  String get searchPageTitle => 'Search';

  @override
  String get searchPageSubtitle => 'Search videos, music, novels, comics, images';

  @override
  String get searchHint => 'Enter keywords to search...';

  @override
  String get searchHistory => 'Search History';

  @override
  String get searchClearHistory => 'Clear History';

  @override
  String get searchHot => 'Hot Searches';

  @override
  String get searchResults => 'Search Results';

  @override
  String get searchNoResults => 'No related content found';

  @override
  String get searchTabAll => 'All';

  @override
  String get searchTabVideo => 'Video';

  @override
  String get searchTabMusic => 'Music';

  @override
  String get searchTabNovel => 'Novel';

  @override
  String get searchTabComic => 'Comic';

  @override
  String get searchTabImage => 'Image';
}
