// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the HTTP server.

@ProviderFor(Server)
final serverProvider = ServerProvider._();

/// Provider for the HTTP server.
final class ServerProvider extends $NotifierProvider<Server, ServerStatus> {
  /// Provider for the HTTP server.
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

String _$serverHash() => r'6881011fc30ae1723aec36f27a6fed0cb1706c14';

/// Provider for the HTTP server.

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
