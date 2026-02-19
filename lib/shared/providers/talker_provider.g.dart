// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'talker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Talker 实例 Provider
///
/// 提供全局 Talker 实例，用于日志记录和错误处理。

@ProviderFor(talker)
final talkerProvider = TalkerProvider._();

/// Talker 实例 Provider
///
/// 提供全局 Talker 实例，用于日志记录和错误处理。

final class TalkerProvider extends $FunctionalProvider<Talker, Talker, Talker>
    with $Provider<Talker> {
  /// Talker 实例 Provider
  ///
  /// 提供全局 Talker 实例，用于日志记录和错误处理。
  TalkerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'talkerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$talkerHash();

  @$internal
  @override
  $ProviderElement<Talker> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Talker create(Ref ref) {
    return talker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Talker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Talker>(value),
    );
  }
}

String _$talkerHash() => r'5f9b470d074de1666d19f9d6323bf6573fa0ad8d';
