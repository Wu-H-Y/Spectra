import 'package:flutter/material.dart';
import 'package:spectra/core/i18n/strings.g.dart';

enum _ImportRuleAction { file, url }

/// 规则导入入口按钮。
class ImportRuleButton extends StatelessWidget {
  /// 创建规则导入入口按钮。
  const ImportRuleButton({
    required this.onImportFile,
    required this.onImportUrl,
    super.key,
  });

  /// 点击文件导入回调。
  final VoidCallback onImportFile;

  /// 点击 URL 导入回调。
  final VoidCallback onImportUrl;

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return PopupMenuButton<_ImportRuleAction>(
      key: const Key('rules-import-button'),
      tooltip: t.rulesImportButton,
      icon: const Icon(Icons.file_upload_outlined),
      onSelected: (action) {
        switch (action) {
          case _ImportRuleAction.file:
            onImportFile();
          case _ImportRuleAction.url:
            onImportUrl();
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<_ImportRuleAction>(
          value: _ImportRuleAction.file,
          child: Text(t.rulesImportFileButton),
        ),
        PopupMenuItem<_ImportRuleAction>(
          value: _ImportRuleAction.url,
          child: Text(t.rulesImportUrlButton),
        ),
      ],
    );
  }
}
