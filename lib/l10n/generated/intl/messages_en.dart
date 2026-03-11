// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(message) => "Rule execution error: ${message}";

  static String m1(message) => "Rule parse error: ${message}";

  static String m2(selector) => "Selector matching failed: ${selector}";

  static String m3(code) => "Server error (${code})";

  static String m4(username) => "Username \"${username}\" already exists.";

  static String m5(count) =>
      "Password must be at least ${count} characters long.";

  static String m6(error) => "Error: ${error}";

  static String m7(count) => "${count} more matched elements...";

  static String m8(count) => "Match Success (${count} elements)";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "appName": MessageLookupByLibrary.simpleMessage("Spectra"),
    "appearanceSettings": MessageLookupByLibrary.simpleMessage("Appearance"),
    "back": MessageLookupByLibrary.simpleMessage("Back"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelSelection": MessageLookupByLibrary.simpleMessage("Cancel Selection"),
    "copiedToClipboard": MessageLookupByLibrary.simpleMessage(
      "Copied to clipboard",
    ),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "currentLanguage": MessageLookupByLibrary.simpleMessage("Current language"),
    "currentTheme": MessageLookupByLibrary.simpleMessage("Current theme"),
    "developerTools": MessageLookupByLibrary.simpleMessage("Developer Tools"),
    "discoverLoadMore": MessageLookupByLibrary.simpleMessage("Load More"),
    "discoverNoMoreData": MessageLookupByLibrary.simpleMessage("No more data"),
    "discoverNoRules": MessageLookupByLibrary.simpleMessage(
      "No rules available",
    ),
    "discoverPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Explore amazing content",
    ),
    "discoverPageTitle": MessageLookupByLibrary.simpleMessage("Discover"),
    "discoverSelectRule": MessageLookupByLibrary.simpleMessage("Select Rule"),
    "discoverSelectRuleDescription": MessageLookupByLibrary.simpleMessage(
      "Choose a data source rule above to discover great content",
    ),
    "discoverSelectRuleHint": MessageLookupByLibrary.simpleMessage(
      "Select a rule to start exploring",
    ),
    "enterUrl": MessageLookupByLibrary.simpleMessage("Enter URL"),
    "enterUrlToPreview": MessageLookupByLibrary.simpleMessage(
      "Enter a URL to preview the page",
    ),
    "errorBadRequest": MessageLookupByLibrary.simpleMessage(
      "Invalid request parameters. Please check and try again.",
    ),
    "errorCacheError": MessageLookupByLibrary.simpleMessage(
      "Cache operation failed. Please try again later.",
    ),
    "errorConnectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timed out. Please try again later.",
    ),
    "errorDatabaseError": MessageLookupByLibrary.simpleMessage(
      "Database operation failed. Please try again later.",
    ),
    "errorForbidden": MessageLookupByLibrary.simpleMessage(
      "You don\'t have permission to perform this action.",
    ),
    "errorNetworkUnreachable": MessageLookupByLibrary.simpleMessage(
      "Network unreachable. Please check your connection.",
    ),
    "errorNotFound": MessageLookupByLibrary.simpleMessage(
      "The requested resource was not found.",
    ),
    "errorParseError": MessageLookupByLibrary.simpleMessage(
      "Failed to parse data. Please try again later.",
    ),
    "errorRuleExecutionError": m0,
    "errorRuleParseError": m1,
    "errorSelectorError": m2,
    "errorServerError": m3,
    "errorTitleAuth": MessageLookupByLibrary.simpleMessage(
      "Authentication Failed",
    ),
    "errorTitleDefault": MessageLookupByLibrary.simpleMessage("Notice"),
    "errorTitleNetwork": MessageLookupByLibrary.simpleMessage("Network Error"),
    "errorTitlePermission": MessageLookupByLibrary.simpleMessage(
      "Permission Denied",
    ),
    "errorTitleRule": MessageLookupByLibrary.simpleMessage("Rule Error"),
    "errorTitleUnknown": MessageLookupByLibrary.simpleMessage("Unknown Error"),
    "errorUnauthorized": MessageLookupByLibrary.simpleMessage(
      "Session expired. Please log in again.",
    ),
    "errorUnknown": MessageLookupByLibrary.simpleMessage(
      "An unknown error occurred. Please try again later.",
    ),
    "errorUsernameExists": m4,
    "errorWeakPassword": m5,
    "favoritesAll": MessageLookupByLibrary.simpleMessage("All Favorites"),
    "favoritesEmptySubtitle": MessageLookupByLibrary.simpleMessage(
      "Go to Discover to browse and save content you like",
    ),
    "favoritesEmptyTitle": MessageLookupByLibrary.simpleMessage(
      "No favorites yet",
    ),
    "favoritesPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Manage your favorite multimedia content",
    ),
    "favoritesPageTitle": MessageLookupByLibrary.simpleMessage("My Favorites"),
    "favoritesRecent": MessageLookupByLibrary.simpleMessage("Recently Viewed"),
    "featureComic": MessageLookupByLibrary.simpleMessage("Comic Collection"),
    "featureImage": MessageLookupByLibrary.simpleMessage("Image Collection"),
    "featureMusic": MessageLookupByLibrary.simpleMessage("Music Collection"),
    "featureNovel": MessageLookupByLibrary.simpleMessage("Novel Collection"),
    "featureVideo": MessageLookupByLibrary.simpleMessage("Video Collection"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("General"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goHome": MessageLookupByLibrary.simpleMessage("Go Home"),
    "goToDiscover": MessageLookupByLibrary.simpleMessage("Go to Discover"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "A modern multimedia data collection application",
    ),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Welcome to Spectra"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinese"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
    "mediaTypeAll": MessageLookupByLibrary.simpleMessage("All"),
    "mediaTypeComic": MessageLookupByLibrary.simpleMessage("Comic"),
    "mediaTypeImage": MessageLookupByLibrary.simpleMessage("Image"),
    "mediaTypeMusic": MessageLookupByLibrary.simpleMessage("Music"),
    "mediaTypeNovel": MessageLookupByLibrary.simpleMessage("Novel"),
    "mediaTypeVideo": MessageLookupByLibrary.simpleMessage("Video"),
    "navDiscover": MessageLookupByLibrary.simpleMessage("Discover"),
    "navFavorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "navSearch": MessageLookupByLibrary.simpleMessage("Search"),
    "noRecentHistory": MessageLookupByLibrary.simpleMessage(
      "No recent viewing history",
    ),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in Browser"),
    "pageNotFound": MessageLookupByLibrary.simpleMessage(
      "404 - Page Not Found",
    ),
    "previewPage": MessageLookupByLibrary.simpleMessage("Page Preview"),
    "refresh": MessageLookupByLibrary.simpleMessage("Refresh"),
    "retry": MessageLookupByLibrary.simpleMessage("Retry"),
    "ruleEditor": MessageLookupByLibrary.simpleMessage("Rule Editor"),
    "ruleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Open web-based rule editor for crawler rules",
    ),
    "rulesExecuteActivePreviewLabel": MessageLookupByLibrary.simpleMessage(
      "Active Preview",
    ),
    "rulesExecuteContentSection": MessageLookupByLibrary.simpleMessage(
      "Content",
    ),
    "rulesExecuteDebugUrlLabel": MessageLookupByLibrary.simpleMessage(
      "Debug URL",
    ),
    "rulesExecuteDetailSection": MessageLookupByLibrary.simpleMessage("Detail"),
    "rulesExecuteEmptyState": MessageLookupByLibrary.simpleMessage(
      "No content is available for this section yet",
    ),
    "rulesExecuteNoActivePreview": MessageLookupByLibrary.simpleMessage(
      "No active preview is attached to this session",
    ),
    "rulesExecuteNoRules": MessageLookupByLibrary.simpleMessage(
      "No executable rules are available yet. Create one through the existing rules API first.",
    ),
    "rulesExecuteNoRuns": MessageLookupByLibrary.simpleMessage(
      "No runs have been created for this session yet",
    ),
    "rulesExecuteNormalizedSection": MessageLookupByLibrary.simpleMessage(
      "Normalized Result JSON",
    ),
    "rulesExecutePageDescription": MessageLookupByLibrary.simpleMessage(
      "Manage server status, the active Flutter session, preview state, run results, and node event timeline from one Flutter-owned runtime workspace.",
    ),
    "rulesExecutePageTitle": MessageLookupByLibrary.simpleMessage(
      "Runtime Workspace",
    ),
    "rulesExecuteResponseSection": MessageLookupByLibrary.simpleMessage(
      "Execute Response JSON",
    ),
    "rulesExecuteRuleLabel": MessageLookupByLibrary.simpleMessage(
      "Execution Rule",
    ),
    "rulesExecuteRunButton": MessageLookupByLibrary.simpleMessage(
      "Execute Rule",
    ),
    "rulesExecuteRunStatusAccepted": MessageLookupByLibrary.simpleMessage(
      "Accepted",
    ),
    "rulesExecuteRunStatusFinished": MessageLookupByLibrary.simpleMessage(
      "Finished",
    ),
    "rulesExecuteRunStatusRunning": MessageLookupByLibrary.simpleMessage(
      "Running",
    ),
    "rulesExecuteRunsSection": MessageLookupByLibrary.simpleMessage(
      "Run Registry",
    ),
    "rulesExecuteSearchSection": MessageLookupByLibrary.simpleMessage("Search"),
    "rulesExecuteSessionLabel": MessageLookupByLibrary.simpleMessage(
      "Current Session",
    ),
    "rulesExecuteTimelineConnected": MessageLookupByLibrary.simpleMessage(
      "Timeline connected",
    ),
    "rulesExecuteTimelineDisconnected": MessageLookupByLibrary.simpleMessage(
      "Timeline disconnected",
    ),
    "rulesExecuteTimelineEmpty": MessageLookupByLibrary.simpleMessage(
      "No timeline events are available for this session yet",
    ),
    "rulesExecuteTimelineSection": MessageLookupByLibrary.simpleMessage(
      "Node Event Timeline",
    ),
    "rulesExecuteTocSection": MessageLookupByLibrary.simpleMessage("Toc"),
    "rulesExecuteWorkspaceSection": MessageLookupByLibrary.simpleMessage(
      "Workspace Context",
    ),
    "searchClearHistory": MessageLookupByLibrary.simpleMessage("Clear History"),
    "searchHint": MessageLookupByLibrary.simpleMessage(
      "Enter keywords to search...",
    ),
    "searchHistory": MessageLookupByLibrary.simpleMessage("Search History"),
    "searchHot": MessageLookupByLibrary.simpleMessage("Hot Searches"),
    "searchNoResults": MessageLookupByLibrary.simpleMessage(
      "No related content found",
    ),
    "searchPageSubtitle": MessageLookupByLibrary.simpleMessage(
      "Search videos, music, novels, comics, images",
    ),
    "searchPageTitle": MessageLookupByLibrary.simpleMessage("Search"),
    "searchResults": MessageLookupByLibrary.simpleMessage("Search Results"),
    "searchTabAll": MessageLookupByLibrary.simpleMessage("All"),
    "searchTabComic": MessageLookupByLibrary.simpleMessage("Comic"),
    "searchTabImage": MessageLookupByLibrary.simpleMessage("Image"),
    "searchTabMusic": MessageLookupByLibrary.simpleMessage("Music"),
    "searchTabNovel": MessageLookupByLibrary.simpleMessage("Novel"),
    "searchTabVideo": MessageLookupByLibrary.simpleMessage("Video"),
    "selectElement": MessageLookupByLibrary.simpleMessage("Select Element"),
    "selectedElement": MessageLookupByLibrary.simpleMessage("Selected Element"),
    "selectorClearResult": MessageLookupByLibrary.simpleMessage("Clear Result"),
    "selectorCssHint": MessageLookupByLibrary.simpleMessage(
      "e.g., div.content > h1",
    ),
    "selectorElementHtml": MessageLookupByLibrary.simpleMessage("HTML"),
    "selectorElementText": MessageLookupByLibrary.simpleMessage("Text"),
    "selectorExpressionLabel": MessageLookupByLibrary.simpleMessage(
      "Selector Expression",
    ),
    "selectorMatchError": m6,
    "selectorMatchFailed": MessageLookupByLibrary.simpleMessage("Match Failed"),
    "selectorMatchMore": m7,
    "selectorMatchSamples": MessageLookupByLibrary.simpleMessage(
      "Matched Samples",
    ),
    "selectorMatchSuccess": m8,
    "selectorTestButton": MessageLookupByLibrary.simpleMessage("Test Selector"),
    "selectorTestSection": MessageLookupByLibrary.simpleMessage(
      "Selector Test",
    ),
    "selectorXPathHint": MessageLookupByLibrary.simpleMessage(
      "e.g., //div[@class=\"content\"]",
    ),
    "sendToEditor": MessageLookupByLibrary.simpleMessage("Send to Editor"),
    "serverRunning": MessageLookupByLibrary.simpleMessage("Running"),
    "serverStart": MessageLookupByLibrary.simpleMessage("Start Server"),
    "serverStartError": MessageLookupByLibrary.simpleMessage(
      "Failed to start server",
    ),
    "serverStatus": MessageLookupByLibrary.simpleMessage("Server Status"),
    "serverStop": MessageLookupByLibrary.simpleMessage("Stop Server"),
    "serverStopped": MessageLookupByLibrary.simpleMessage("Stopped"),
    "serverUrl": MessageLookupByLibrary.simpleMessage("Server URL"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "tapToSelectElement": MessageLookupByLibrary.simpleMessage(
      "Tap on the page to select an element",
    ),
    "textContent": MessageLookupByLibrary.simpleMessage("Text Content"),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme Mode"),
    "themeModeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeModeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeModeSystem": MessageLookupByLibrary.simpleMessage("System"),
    "version": MessageLookupByLibrary.simpleMessage("Version"),
    "webViewPlaceholder": MessageLookupByLibrary.simpleMessage(
      "WebView will be displayed here",
    ),
  };
}
