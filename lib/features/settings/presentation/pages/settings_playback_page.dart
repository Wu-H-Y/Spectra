import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/i18n/strings.g.dart';
import 'package:spectra/shared/widgets/adaptive_scaffold.dart';

/// 播放预览设置子页面
/// 管理播放预览相关的设置选项
class SettingsPlaybackPage extends HookConsumerWidget {
  /// 创建播放预览设置页面
  const SettingsPlaybackPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = context.t;

    return AdaptiveScaffold(
      currentIndex: 3,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(t.settingsPlayback),
            pinned: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildAutoPlaySection(context, t),
                const SizedBox(height: 24),
                _buildQualitySection(context, t),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoPlaySection(BuildContext context, Translations t) {
    // TODO(WuHaiYue): 实现自动播放设置
    const autoPlay = false;

    return SwitchListTile(
      secondary: const Icon(Icons.play_circle_outlined),
      title: Text(t.settingsAutoPlay),
      // 暂时禁用自动播放设置，TODO 实现后移除
      // ignore: dead_code
      subtitle: Text(autoPlay ? t.settingsAutoPlayOn : t.settingsAutoPlayOff),
      value: autoPlay,
      onChanged: null,
    );
  }

  Widget _buildQualitySection(BuildContext context, Translations t) {
    const selectedQuality = 'auto';

    final qualities = ['auto', 'high', 'standard', 'low'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.settingsDefaultQuality,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: selectedQuality,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: qualities
              .map(
                (quality) => DropdownMenuItem<String>(
                  value: quality,
                  child: Text(_getQualityLabel(t, quality)),
                ),
              )
              .toList(growable: false),
          onChanged: (value) {
            // TODO(developer): 保存设置
          },
        ),
      ],
    );
  }

  String _getQualityLabel(Translations t, String quality) {
    switch (quality) {
      case 'auto':
        return t.settingsQualityAuto;
      case 'high':
        return t.settingsQualityHigh;
      case 'standard':
        return t.settingsQualityStandard;
      case 'low':
        return t.settingsQualityLow;
      default:
        return quality;
    }
  }
}
