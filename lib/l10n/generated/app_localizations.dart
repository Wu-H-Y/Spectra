import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Spectra'**
  String get appName;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Spectra'**
  String get homeTitle;

  /// No description provided for @homeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A modern multimedia data collection application'**
  String get homeSubtitle;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeModeDark;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeModeLight;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeModeSystem;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get languageChinese;

  /// No description provided for @featureVideo.
  ///
  /// In en, this message translates to:
  /// **'Video Collection'**
  String get featureVideo;

  /// No description provided for @featureMusic.
  ///
  /// In en, this message translates to:
  /// **'Music Collection'**
  String get featureMusic;

  /// No description provided for @featureNovel.
  ///
  /// In en, this message translates to:
  /// **'Novel Collection'**
  String get featureNovel;

  /// No description provided for @featureComic.
  ///
  /// In en, this message translates to:
  /// **'Comic Collection'**
  String get featureComic;

  /// No description provided for @featureImage.
  ///
  /// In en, this message translates to:
  /// **'Image Collection'**
  String get featureImage;

  /// No description provided for @goHome.
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get goHome;

  /// No description provided for @pageNotFound.
  ///
  /// In en, this message translates to:
  /// **'404 - Page Not Found'**
  String get pageNotFound;

  /// No description provided for @appearanceSettings.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSettings;

  /// No description provided for @generalSettings.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get generalSettings;

  /// No description provided for @currentTheme.
  ///
  /// In en, this message translates to:
  /// **'Current theme'**
  String get currentTheme;

  /// No description provided for @currentLanguage.
  ///
  /// In en, this message translates to:
  /// **'Current language'**
  String get currentLanguage;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @developerTools.
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get developerTools;

  /// No description provided for @ruleEditor.
  ///
  /// In en, this message translates to:
  /// **'Rule Editor'**
  String get ruleEditor;

  /// No description provided for @ruleEditorDescription.
  ///
  /// In en, this message translates to:
  /// **'Open web-based rule editor for crawler rules'**
  String get ruleEditorDescription;

  /// No description provided for @rulesExecutePageTitle.
  ///
  /// In en, this message translates to:
  /// **'Runtime Workspace'**
  String get rulesExecutePageTitle;

  /// No description provided for @rulesExecutePageDescription.
  ///
  /// In en, this message translates to:
  /// **'Manage server status, the active Flutter session, preview state, run results, and node event timeline from one Flutter-owned runtime workspace.'**
  String get rulesExecutePageDescription;

  /// No description provided for @rulesExecuteWorkspaceSection.
  ///
  /// In en, this message translates to:
  /// **'Workspace Context'**
  String get rulesExecuteWorkspaceSection;

  /// No description provided for @rulesExecuteSessionLabel.
  ///
  /// In en, this message translates to:
  /// **'Current Session'**
  String get rulesExecuteSessionLabel;

  /// No description provided for @rulesExecuteRuleLabel.
  ///
  /// In en, this message translates to:
  /// **'Execution Rule'**
  String get rulesExecuteRuleLabel;

  /// No description provided for @rulesExecuteNoRules.
  ///
  /// In en, this message translates to:
  /// **'No executable rules are available yet. Create one through the existing rules API first.'**
  String get rulesExecuteNoRules;

  /// No description provided for @rulesExecuteRunButton.
  ///
  /// In en, this message translates to:
  /// **'Execute Rule'**
  String get rulesExecuteRunButton;

  /// No description provided for @rulesExecuteResponseSection.
  ///
  /// In en, this message translates to:
  /// **'Execute Response JSON'**
  String get rulesExecuteResponseSection;

  /// No description provided for @rulesExecuteRunsSection.
  ///
  /// In en, this message translates to:
  /// **'Run Registry'**
  String get rulesExecuteRunsSection;

  /// No description provided for @rulesExecuteNoRuns.
  ///
  /// In en, this message translates to:
  /// **'No runs have been created for this session yet'**
  String get rulesExecuteNoRuns;

  /// No description provided for @rulesExecuteActivePreviewLabel.
  ///
  /// In en, this message translates to:
  /// **'Active Preview'**
  String get rulesExecuteActivePreviewLabel;

  /// No description provided for @rulesExecuteNoActivePreview.
  ///
  /// In en, this message translates to:
  /// **'No active preview is attached to this session'**
  String get rulesExecuteNoActivePreview;

  /// No description provided for @rulesExecuteDebugUrlLabel.
  ///
  /// In en, this message translates to:
  /// **'Debug URL'**
  String get rulesExecuteDebugUrlLabel;

  /// No description provided for @rulesExecuteTimelineSection.
  ///
  /// In en, this message translates to:
  /// **'Node Event Timeline'**
  String get rulesExecuteTimelineSection;

  /// No description provided for @rulesExecuteTimelineEmpty.
  ///
  /// In en, this message translates to:
  /// **'No timeline events are available for this session yet'**
  String get rulesExecuteTimelineEmpty;

  /// No description provided for @rulesExecuteTimelineConnected.
  ///
  /// In en, this message translates to:
  /// **'Timeline connected'**
  String get rulesExecuteTimelineConnected;

  /// No description provided for @rulesExecuteTimelineDisconnected.
  ///
  /// In en, this message translates to:
  /// **'Timeline disconnected'**
  String get rulesExecuteTimelineDisconnected;

  /// No description provided for @rulesExecuteRunStatusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get rulesExecuteRunStatusAccepted;

  /// No description provided for @rulesExecuteRunStatusRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get rulesExecuteRunStatusRunning;

  /// No description provided for @rulesExecuteRunStatusFinished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get rulesExecuteRunStatusFinished;

  /// No description provided for @rulesExecuteNormalizedSection.
  ///
  /// In en, this message translates to:
  /// **'Normalized Result JSON'**
  String get rulesExecuteNormalizedSection;

  /// No description provided for @rulesExecuteSearchSection.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get rulesExecuteSearchSection;

  /// No description provided for @rulesExecuteDetailSection.
  ///
  /// In en, this message translates to:
  /// **'Detail'**
  String get rulesExecuteDetailSection;

  /// No description provided for @rulesExecuteTocSection.
  ///
  /// In en, this message translates to:
  /// **'Toc'**
  String get rulesExecuteTocSection;

  /// No description provided for @rulesExecuteContentSection.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get rulesExecuteContentSection;

  /// No description provided for @rulesExecuteEmptyState.
  ///
  /// In en, this message translates to:
  /// **'No content is available for this section yet'**
  String get rulesExecuteEmptyState;

  /// No description provided for @serverStatus.
  ///
  /// In en, this message translates to:
  /// **'Server Status'**
  String get serverStatus;

  /// No description provided for @serverRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get serverRunning;

  /// No description provided for @serverStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get serverStopped;

  /// No description provided for @serverStart.
  ///
  /// In en, this message translates to:
  /// **'Start Server'**
  String get serverStart;

  /// No description provided for @serverStop.
  ///
  /// In en, this message translates to:
  /// **'Stop Server'**
  String get serverStop;

  /// No description provided for @serverUrl.
  ///
  /// In en, this message translates to:
  /// **'Server URL'**
  String get serverUrl;

  /// No description provided for @openInBrowser.
  ///
  /// In en, this message translates to:
  /// **'Open in Browser'**
  String get openInBrowser;

  /// No description provided for @serverStartError.
  ///
  /// In en, this message translates to:
  /// **'Failed to start server'**
  String get serverStartError;

  /// No description provided for @errorTitleDefault.
  ///
  /// In en, this message translates to:
  /// **'Notice'**
  String get errorTitleDefault;

  /// No description provided for @errorTitleNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network Error'**
  String get errorTitleNetwork;

  /// No description provided for @errorTitleAuth.
  ///
  /// In en, this message translates to:
  /// **'Authentication Failed'**
  String get errorTitleAuth;

  /// No description provided for @errorTitlePermission.
  ///
  /// In en, this message translates to:
  /// **'Permission Denied'**
  String get errorTitlePermission;

  /// No description provided for @errorTitleRule.
  ///
  /// In en, this message translates to:
  /// **'Rule Error'**
  String get errorTitleRule;

  /// No description provided for @errorTitleUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error'**
  String get errorTitleUnknown;

  /// No description provided for @errorNetworkUnreachable.
  ///
  /// In en, this message translates to:
  /// **'Network unreachable. Please check your connection.'**
  String get errorNetworkUnreachable;

  /// No description provided for @errorConnectionTimeout.
  ///
  /// In en, this message translates to:
  /// **'Connection timed out. Please try again later.'**
  String get errorConnectionTimeout;

  /// No description provided for @errorServerError.
  ///
  /// In en, this message translates to:
  /// **'Server error ({code})'**
  String errorServerError(Object code);

  /// No description provided for @errorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'Session expired. Please log in again.'**
  String get errorUnauthorized;

  /// No description provided for @errorForbidden.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have permission to perform this action.'**
  String get errorForbidden;

  /// No description provided for @errorNotFound.
  ///
  /// In en, this message translates to:
  /// **'The requested resource was not found.'**
  String get errorNotFound;

  /// No description provided for @errorBadRequest.
  ///
  /// In en, this message translates to:
  /// **'Invalid request parameters. Please check and try again.'**
  String get errorBadRequest;

  /// No description provided for @errorParseError.
  ///
  /// In en, this message translates to:
  /// **'Failed to parse data. Please try again later.'**
  String get errorParseError;

  /// No description provided for @errorRuleParseError.
  ///
  /// In en, this message translates to:
  /// **'Rule parse error: {message}'**
  String errorRuleParseError(Object message);

  /// No description provided for @errorRuleExecutionError.
  ///
  /// In en, this message translates to:
  /// **'Rule execution error: {message}'**
  String errorRuleExecutionError(Object message);

  /// No description provided for @errorSelectorError.
  ///
  /// In en, this message translates to:
  /// **'Selector matching failed: {selector}'**
  String errorSelectorError(Object selector);

  /// No description provided for @errorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least {count} characters long.'**
  String errorWeakPassword(Object count);

  /// No description provided for @errorUsernameExists.
  ///
  /// In en, this message translates to:
  /// **'Username \"{username}\" already exists.'**
  String errorUsernameExists(Object username);

  /// No description provided for @errorDatabaseError.
  ///
  /// In en, this message translates to:
  /// **'Database operation failed. Please try again later.'**
  String get errorDatabaseError;

  /// No description provided for @errorCacheError.
  ///
  /// In en, this message translates to:
  /// **'Cache operation failed. Please try again later.'**
  String get errorCacheError;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again later.'**
  String get errorUnknown;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @previewPage.
  ///
  /// In en, this message translates to:
  /// **'Page Preview'**
  String get previewPage;

  /// No description provided for @enterUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter URL'**
  String get enterUrl;

  /// No description provided for @enterUrlToPreview.
  ///
  /// In en, this message translates to:
  /// **'Enter a URL to preview the page'**
  String get enterUrlToPreview;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @selectElement.
  ///
  /// In en, this message translates to:
  /// **'Select Element'**
  String get selectElement;

  /// No description provided for @cancelSelection.
  ///
  /// In en, this message translates to:
  /// **'Cancel Selection'**
  String get cancelSelection;

  /// No description provided for @tapToSelectElement.
  ///
  /// In en, this message translates to:
  /// **'Tap on the page to select an element'**
  String get tapToSelectElement;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @selectedElement.
  ///
  /// In en, this message translates to:
  /// **'Selected Element'**
  String get selectedElement;

  /// No description provided for @textContent.
  ///
  /// In en, this message translates to:
  /// **'Text Content'**
  String get textContent;

  /// No description provided for @sendToEditor.
  ///
  /// In en, this message translates to:
  /// **'Send to Editor'**
  String get sendToEditor;

  /// No description provided for @webViewPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'WebView will be displayed here'**
  String get webViewPlaceholder;

  /// No description provided for @selectorTestSection.
  ///
  /// In en, this message translates to:
  /// **'Selector Test'**
  String get selectorTestSection;

  /// No description provided for @selectorTestButton.
  ///
  /// In en, this message translates to:
  /// **'Test Selector'**
  String get selectorTestButton;

  /// No description provided for @selectorClearResult.
  ///
  /// In en, this message translates to:
  /// **'Clear Result'**
  String get selectorClearResult;

  /// No description provided for @selectorExpressionLabel.
  ///
  /// In en, this message translates to:
  /// **'Selector Expression'**
  String get selectorExpressionLabel;

  /// No description provided for @selectorCssHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., div.content > h1'**
  String get selectorCssHint;

  /// No description provided for @selectorXPathHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., //div[@class=\"content\"]'**
  String get selectorXPathHint;

  /// No description provided for @selectorMatchSuccess.
  ///
  /// In en, this message translates to:
  /// **'Match Success ({count} elements)'**
  String selectorMatchSuccess(Object count);

  /// No description provided for @selectorMatchFailed.
  ///
  /// In en, this message translates to:
  /// **'Match Failed'**
  String get selectorMatchFailed;

  /// No description provided for @selectorMatchError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String selectorMatchError(Object error);

  /// No description provided for @selectorMatchSamples.
  ///
  /// In en, this message translates to:
  /// **'Matched Samples'**
  String get selectorMatchSamples;

  /// No description provided for @selectorMatchMore.
  ///
  /// In en, this message translates to:
  /// **'{count} more matched elements...'**
  String selectorMatchMore(Object count);

  /// No description provided for @selectorElementText.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get selectorElementText;

  /// No description provided for @selectorElementHtml.
  ///
  /// In en, this message translates to:
  /// **'HTML'**
  String get selectorElementHtml;

  /// No description provided for @navFavorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get navFavorites;

  /// No description provided for @navDiscover.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get navDiscover;

  /// No description provided for @navSearch.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get navSearch;

  /// No description provided for @favoritesPageTitle.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get favoritesPageTitle;

  /// No description provided for @favoritesPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your favorite multimedia content'**
  String get favoritesPageSubtitle;

  /// No description provided for @favoritesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No favorites yet'**
  String get favoritesEmptyTitle;

  /// No description provided for @favoritesEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Go to Discover to browse and save content you like'**
  String get favoritesEmptySubtitle;

  /// No description provided for @favoritesRecent.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed'**
  String get favoritesRecent;

  /// No description provided for @favoritesAll.
  ///
  /// In en, this message translates to:
  /// **'All Favorites'**
  String get favoritesAll;

  /// No description provided for @mediaTypeAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get mediaTypeAll;

  /// No description provided for @mediaTypeVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get mediaTypeVideo;

  /// No description provided for @mediaTypeMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get mediaTypeMusic;

  /// No description provided for @mediaTypeNovel.
  ///
  /// In en, this message translates to:
  /// **'Novel'**
  String get mediaTypeNovel;

  /// No description provided for @mediaTypeComic.
  ///
  /// In en, this message translates to:
  /// **'Comic'**
  String get mediaTypeComic;

  /// No description provided for @mediaTypeImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get mediaTypeImage;

  /// No description provided for @noRecentHistory.
  ///
  /// In en, this message translates to:
  /// **'No recent viewing history'**
  String get noRecentHistory;

  /// No description provided for @goToDiscover.
  ///
  /// In en, this message translates to:
  /// **'Go to Discover'**
  String get goToDiscover;

  /// No description provided for @discoverPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Discover'**
  String get discoverPageTitle;

  /// No description provided for @discoverPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore amazing content'**
  String get discoverPageSubtitle;

  /// No description provided for @discoverSelectRule.
  ///
  /// In en, this message translates to:
  /// **'Select Rule'**
  String get discoverSelectRule;

  /// No description provided for @discoverSelectRuleHint.
  ///
  /// In en, this message translates to:
  /// **'Select a rule to start exploring'**
  String get discoverSelectRuleHint;

  /// No description provided for @discoverSelectRuleDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose a data source rule above to discover great content'**
  String get discoverSelectRuleDescription;

  /// No description provided for @discoverNoRules.
  ///
  /// In en, this message translates to:
  /// **'No rules available'**
  String get discoverNoRules;

  /// No description provided for @discoverLoadMore.
  ///
  /// In en, this message translates to:
  /// **'Load More'**
  String get discoverLoadMore;

  /// No description provided for @discoverNoMoreData.
  ///
  /// In en, this message translates to:
  /// **'No more data'**
  String get discoverNoMoreData;

  /// No description provided for @settingsDataStorage.
  ///
  /// In en, this message translates to:
  /// **'Data Storage'**
  String get settingsDataStorage;

  /// No description provided for @settingsCacheSize.
  ///
  /// In en, this message translates to:
  /// **'Cache Size'**
  String get settingsCacheSize;

  /// No description provided for @settingsClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear Cache'**
  String get settingsClearCache;

  /// No description provided for @settingsClearCacheConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all cache? This action cannot be undone.'**
  String get settingsClearCacheConfirm;

  /// No description provided for @settingsCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared'**
  String get settingsCacheCleared;

  /// No description provided for @settingsExportFavorites.
  ///
  /// In en, this message translates to:
  /// **'Export Favorites'**
  String get settingsExportFavorites;

  /// No description provided for @settingsImportFavorites.
  ///
  /// In en, this message translates to:
  /// **'Import Favorites'**
  String get settingsImportFavorites;

  /// No description provided for @settingsPlayback.
  ///
  /// In en, this message translates to:
  /// **'Playback'**
  String get settingsPlayback;

  /// No description provided for @settingsAutoPlay.
  ///
  /// In en, this message translates to:
  /// **'Auto Play'**
  String get settingsAutoPlay;

  /// No description provided for @settingsAutoPlayOn.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get settingsAutoPlayOn;

  /// No description provided for @settingsAutoPlayOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get settingsAutoPlayOff;

  /// No description provided for @settingsDefaultQuality.
  ///
  /// In en, this message translates to:
  /// **'Default Quality'**
  String get settingsDefaultQuality;

  /// No description provided for @settingsQualityAuto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get settingsQualityAuto;

  /// No description provided for @settingsQualityHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get settingsQualityHigh;

  /// No description provided for @settingsQualityStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get settingsQualityStandard;

  /// No description provided for @settingsQualityLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get settingsQualityLow;

  /// No description provided for @actionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get actionConfirm;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @searchPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchPageTitle;

  /// No description provided for @searchPageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search videos, music, novels, comics, images'**
  String get searchPageSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Enter keywords to search...'**
  String get searchHint;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get searchHistory;

  /// No description provided for @searchClearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get searchClearHistory;

  /// No description provided for @searchHot.
  ///
  /// In en, this message translates to:
  /// **'Hot Searches'**
  String get searchHot;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @searchNoResults.
  ///
  /// In en, this message translates to:
  /// **'No related content found'**
  String get searchNoResults;

  /// No description provided for @searchTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get searchTabAll;

  /// No description provided for @searchTabVideo.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get searchTabVideo;

  /// No description provided for @searchTabMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get searchTabMusic;

  /// No description provided for @searchTabNovel.
  ///
  /// In en, this message translates to:
  /// **'Novel'**
  String get searchTabNovel;

  /// No description provided for @searchTabComic.
  ///
  /// In en, this message translates to:
  /// **'Comic'**
  String get searchTabComic;

  /// No description provided for @searchTabImage.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get searchTabImage;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
