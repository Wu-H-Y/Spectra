import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/l10n/generated/l10n.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 播放预览设置子页面
class SettingsPlaybackPage extends HookConsumerWidget {
  const SettingsPlaybackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = S.of(context);

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(l10n.settingsPlayback),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAutoPlaySection(context, l10n),
                const SizedBox(height: 24),
                _buildQualitySection(context, l10n),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPlaySection(BuildContext context, S l10n) {
    // TODO: 使用状态管理
    const autoPlay = false;

    return SwitchListTile(
      secondary: const Icon(Icons.play_circle_outlined),
      title: Text(l10n.settingsAutoPlay),
      subtitle: Text(autoPlay ? l10n.settingsAutoPlayOn : l10n.settingsAutoPlayOff),
      value: autoPlay,
      onChanged: (value) {
        // TODO: 保存设置
      },
    );
  }

  Widget _buildQualitySection(BuildContext context, S l10n) {
    // TODO: 使用状态管理
    const selectedQuality = 'auto';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.settingsDefaultQuality,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ...['auto', 'high', 'standard', 'low'].map((quality) => RadioListTile<String>(
          title: Text(_getQualityLabel(l10n, quality)),
          value: quality,
          groupValue: selectedQuality,
          onChanged: (value) {
            // TODO: 保存设置
          },
        )),
      ],
    );
  }

  String _getQualityLabel(S l10n, String quality) {
    switch (quality) {
      case 'auto':
        return l10n.settingsQualityAuto;
      case 'high':
        return l10n.settingsQualityHigh;
      case 'standard':
        return l10n.settingsQualityStandard;
      case 'low':
        return l10n.settingsQualityLow;
      default:
        return quality;
    }
  }
}
