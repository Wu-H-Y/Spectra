import 'package:flutter/material.dart';
import 'package:spectra/core/i18n/strings.g.dart';

/// 规则导入中的加载对话框。
class ImportRuleDialog extends StatelessWidget {
  /// 创建规则导入加载对话框。
  const ImportRuleDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t;

    return AlertDialog(
      content: Row(
        children: [
          const SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(t.rulesImporting)),
        ],
      ),
    );
  }
}
