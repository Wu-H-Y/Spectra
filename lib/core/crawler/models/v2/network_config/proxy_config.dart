import 'package:freezed_annotation/freezed_annotation.dart';

part 'proxy_config.freezed.dart';
part 'proxy_config.g.dart';

/// 代理类型。
enum ProxyType {
  /// HTTP 代理。
  http,

  /// HTTPS 代理。
  https,

  /// SOCKS5 代理。
  socks5,
}

/// 代理轮换策略。
enum ProxyRotation {
  /// 顺序轮换。
  roundRobin,

  /// 随机选择。
  random,

  /// 按权重。
  weighted,

  /// 固定使用第一个。
  fixed,
}

/// 代理服务器配置。
@freezed
sealed class ProxyServer with _$ProxyServer {
  const factory ProxyServer({
    /// 服务器地址。
    required String host,

    /// 端口。
    required int port,

    /// 代理类型。
    required ProxyType type,

    /// 用户名。
    String? username,

    /// 密码。
    String? password,

    /// 权重 (用于加权轮换)。
    @Default(1) int weight,
  }) = _ProxyServer;

  factory ProxyServer.fromJson(Map<String, dynamic> json) =>
      _$ProxyServerFromJson(json);
}

/// 代理配置。
@freezed
sealed class ProxyConfig with _$ProxyConfig {
  const factory ProxyConfig({
    /// 代理服务器列表。
    required List<ProxyServer> servers,

    /// 轮换策略。
    @Default(ProxyRotation.roundRobin) ProxyRotation rotation,

    /// 失败时是否切换代理。
    @Default(true) bool failover,

    /// 验证 URL。
    String? testUrl,
  }) = _ProxyConfig;

  factory ProxyConfig.fromJson(Map<String, dynamic> json) =>
      _$ProxyConfigFromJson(json);
}
