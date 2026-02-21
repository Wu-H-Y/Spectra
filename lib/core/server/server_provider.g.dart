// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// HTTP 服务器 Provider。

@ProviderFor(Server)
final serverProvider = ServerProvider._();

/// HTTP 服务器 Provider。
final class ServerProvider extends $NotifierProvider<Server, ServerStatus> {
  /// HTTP 服务器 Provider。
  ServerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'serverProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$serverHash();

  @$internal
  @override
  Server create() => Server();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServerStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServerStatus>(value),
    );
  }
}

String _$serverHash() => r'91f630e433b211d5c7cec6bb12da606a6f4b0de3';

/// HTTP 服务器 Provider。

abstract class _$Server extends $Notifier<ServerStatus> {
  ServerStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ServerStatus, ServerStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServerStatus, ServerStatus>,
              ServerStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
