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
    "featureComic": MessageLookupByLibrary.simpleMessage("Comic Collection"),
    "featureImage": MessageLookupByLibrary.simpleMessage("Image Collection"),
    "featureMusic": MessageLookupByLibrary.simpleMessage("Music Collection"),
    "featureNovel": MessageLookupByLibrary.simpleMessage("Novel Collection"),
    "featureVideo": MessageLookupByLibrary.simpleMessage("Video Collection"),
    "generalSettings": MessageLookupByLibrary.simpleMessage("General"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goHome": MessageLookupByLibrary.simpleMessage("Go Home"),
    "homeSubtitle": MessageLookupByLibrary.simpleMessage(
      "A modern multimedia data collection application",
    ),
    "homeTitle": MessageLookupByLibrary.simpleMessage("Welcome to Spectra"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "languageChinese": MessageLookupByLibrary.simpleMessage("Chinese"),
    "languageEnglish": MessageLookupByLibrary.simpleMessage("English"),
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
    "selectElement": MessageLookupByLibrary.simpleMessage("Select Element"),
    "selectedElement": MessageLookupByLibrary.simpleMessage("Selected Element"),
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
