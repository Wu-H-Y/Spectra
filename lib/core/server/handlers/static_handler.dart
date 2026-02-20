/// 静态文件处理器
///
/// 使用 dart:io 实现静态文件服务，用于服务编辑器资源。
library;

import 'dart:io';

import 'package:mime/mime.dart';
import 'package:relic/relic.dart';

/// MIME 类型映射
const _defaultMimeType = 'application/octet-stream';

/// 获取文件的 MIME 类型
String _getMimeType(String path) {
  final mimeType = lookupMimeType(path);
  return mimeType ?? _defaultMimeType;
}

/// 创建用于从编辑器目录提供静态文件的处理器
///
/// [editorPath] 应指向构建好的 Web 编辑器资源。
Handler createEditorStaticHandler(String editorPath) {
  return (Request request) async {
    // 获取请求路径
    final path = request.url.path;

    // 移除前导斜杠并构建文件路径
    var filePath = path.isEmpty || path == '/'
        ? '$editorPath/index.html'
        : '$editorPath$path';

    // 如果路径是目录，尝试提供 index.html
    final file = File(filePath);
    // ignore: avoid_slow_async_io - 文件存在性检查是必要的
    if (await file.exists()) {
      // ignore: avoid_slow_async_io - 获取文件状态是必要的
      final stat = await file.stat();
      if (stat.type == FileSystemEntityType.directory) {
        filePath = '$filePath/index.html';
      }
    }

    final finalFile = File(filePath);
    // ignore: avoid_slow_async_io - 文件存在性检查是必要的
    if (!await finalFile.exists()) {
      return Response.notFound(
        body: Body.fromString('Not Found: $path'),
      );
    }

    try {
      final mimeType = _getMimeType(filePath);
      final bytes = await finalFile.readAsBytes();

      return Response.ok(
        body: Body.fromData(bytes, mimeType: MimeType.parse(mimeType)),
        headers: Headers.build((h) {
          h.contentLength = bytes.length;
        }),
      );
    } on Exception catch (e) {
      return Response.internalServerError(
        body: Body.fromString('Error reading file: $e'),
      );
    }
  };
}

/// 检查 assets/editor 目录是否存在
bool editorAssetsExist(String projectPath) {
  final editorDir = Directory('$projectPath/assets/editor');
  return editorDir.existsSync();
}
