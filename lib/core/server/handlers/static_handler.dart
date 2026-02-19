import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf_static/shelf_static.dart' as shelf_static;

/// Creates a handler for serving static files from the editor directory.
///
/// The [editorPath] should point to the built web editor assets.
Handler createEditorStaticHandler(String editorPath) {
  return shelf_static.createStaticHandler(editorPath);
}

/// Check if assets/editor directory exists.
bool editorAssetsExist(String projectPath) {
  final editorDir = Directory('$projectPath/assets/editor');
  return editorDir.existsSync();
}
