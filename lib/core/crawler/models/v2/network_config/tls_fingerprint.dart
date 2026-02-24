import 'package:freezed_annotation/freezed_annotation.dart';

part 'tls_fingerprint.freezed.dart';
part 'tls_fingerprint.g.dart';

/// 模拟的浏览器类型。
enum BrowserType {
  /// Chrome 110 版本。
  chrome110,

  /// Chrome 120 版本。
  chrome120,

  /// Chrome 130 版本。
  chrome130,

  /// Firefox 110 版本。
  firefox110,

  /// Safari 15.6 版本。
  safari156,

  /// Safari 17 版本。
  safari17,

  /// Edge 101 版本。
  edge101,
}

/// TLS 指纹配置。
///
/// 模拟真实浏览器的 TLS 握手特征，绕过 TLS 指纹检测。
@freezed
sealed class TlsFingerprint with _$TlsFingerprint {
  const factory TlsFingerprint({
    /// 模拟的浏览器类型。
    @Default(BrowserType.chrome120) BrowserType browser,

    /// 是否使用 curl-impersonate。
    @Default(true) bool useImpersonate,
  }) = _TlsFingerprint;

  factory TlsFingerprint.fromJson(Map<String, dynamic> json) =>
      _$TlsFingerprintFromJson(json);
}
