// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preview_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 页面预览 Provider。

@ProviderFor(PagePreview)
final pagePreviewProvider = PagePreviewProvider._();

/// 页面预览 Provider。
final class PagePreviewProvider
    extends $NotifierProvider<PagePreview, PreviewState> {
  /// 页面预览 Provider。
  PagePreviewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pagePreviewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pagePreviewHash();

  @$internal
  @override
  PagePreview create() => PagePreview();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreviewState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreviewState>(value),
    );
  }
}

String _$pagePreviewHash() => r'81154575a50f979078bfea6a25f0dba1adbc22c9';

/// 页面预览 Provider。

abstract class _$PagePreview extends $Notifier<PreviewState> {
  PreviewState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<PreviewState, PreviewState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PreviewState, PreviewState>,
              PreviewState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// 选择器选项 Provider。

@ProviderFor(SelectorOption)
final selectorOptionProvider = SelectorOptionProvider._();

/// 选择器选项 Provider。
final class SelectorOptionProvider
    extends $NotifierProvider<SelectorOption, SelectorTypeOption> {
  /// 选择器选项 Provider。
  SelectorOptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectorOptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectorOptionHash();

  @$internal
  @override
  SelectorOption create() => SelectorOption();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SelectorTypeOption value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SelectorTypeOption>(value),
    );
  }
}

String _$selectorOptionHash() => r'0144b751c46d23e28b01322eb53b6f61589595b9';

/// 选择器选项 Provider。

abstract class _$SelectorOption extends $Notifier<SelectorTypeOption> {
  SelectorTypeOption build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SelectorTypeOption, SelectorTypeOption>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SelectorTypeOption, SelectorTypeOption>,
              SelectorTypeOption,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
