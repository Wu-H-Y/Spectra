import 'package:flutter/material.dart';
import 'package:spectra/core/i18n/strings.g.dart';

/// URL 导入规则输入对话框。
class ImportRuleUrlDialog extends StatefulWidget {
  /// 创建 URL 导入规则输入对话框。
  const ImportRuleUrlDialog({this.initialUrl, super.key});

  /// 预填充的 URL。
  final String? initialUrl;

  @override
  State<ImportRuleUrlDialog> createState() => _ImportRuleUrlDialogState();
}

class _ImportRuleUrlDialogState extends State<ImportRuleUrlDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialUrl ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AlertDialog(
      title: Text(t.rulesImportUrlTitle),
      content: TextField(
        key: const Key('rules-import-url-field'),
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(
          hintText: t.rulesImportUrlHint,
          helperText: t.rulesImportUrlHelper,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.cancel),
        ),
        FilledButton(
          key: const Key('rules-import-url-submit'),
          onPressed: () {
            Navigator.of(context).pop(_controller.text.trim());
          },
          child: Text(t.rulesImportUrlSubmit),
        ),
      ],
    );
  }
}
