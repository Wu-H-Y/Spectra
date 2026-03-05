import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

const _ruleKeySalt = 'spectra.rule.storage.v1';

/// 规则主密钥加载回调
typedef RuleMasterKeyProvider = Future<Uint8List> Function();

/// 内存主密钥提供器
class InMemoryRuleMasterKeyProvider {
  /// 构造一个固定主密钥提供器
  InMemoryRuleMasterKeyProvider(List<int> masterKeyBytes)
    : _masterKeyBytes = Uint8List.fromList(masterKeyBytes);

  final Uint8List _masterKeyBytes;

  /// 加载用于派生规则子密钥的主密钥
  Future<Uint8List> loadMasterKey() async {
    return Uint8List.fromList(_masterKeyBytes);
  }
}

/// 规则级存储加密器（AEAD + HKDF）
class RuleStorageCipher {
  /// 构造规则级存储加密器
  RuleStorageCipher({required RuleMasterKeyProvider keyProvider})
    : _keyProvider = keyProvider;

  static const int _keyLength = 32;
  static const int _nonceLength = 12;
  static const int _macLength = 16;
  static const int _macBits = 128;

  final RuleMasterKeyProvider _keyProvider;
  final Random _secureRandom = Random.secure();

  /// 使用规则标识对明文加密
  Future<String> encrypt({
    required String ruleId,
    required String plaintext,
  }) async {
    final nonce = _randomBytes(_nonceLength);
    final ruleKey = await _deriveRuleKey(ruleId);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        true,
        AEADParameters(
          KeyParameter(ruleKey),
          _macBits,
          nonce,
          Uint8List(0),
        ),
      );

    final plainBytes = Uint8List.fromList(utf8.encode(plaintext));
    final cipherWithMac = cipher.process(plainBytes);
    final cipherText = cipherWithMac.sublist(
      0,
      cipherWithMac.length - _macLength,
    );
    final mac = cipherWithMac.sublist(
      cipherWithMac.length - _macLength,
      cipherWithMac.length,
    );

    final payload = <String, Object>{
      'version': 1,
      'nonce': base64UrlEncode(nonce),
      'cipherText': base64UrlEncode(cipherText),
      'mac': base64UrlEncode(mac),
    };

    return jsonEncode(payload);
  }

  /// 使用规则标识解密密文
  Future<String> decrypt({
    required String ruleId,
    required String encryptedPayload,
  }) async {
    final payload = jsonDecode(encryptedPayload) as Map<String, dynamic>;

    final nonce = base64Url.decode(payload['nonce'] as String);
    final cipherText = base64Url.decode(payload['cipherText'] as String);
    final mac = base64Url.decode(payload['mac'] as String);

    final ruleKey = await _deriveRuleKey(ruleId);
    final cipher = GCMBlockCipher(AESEngine())
      ..init(
        false,
        AEADParameters(
          KeyParameter(ruleKey),
          _macBits,
          Uint8List.fromList(nonce),
          Uint8List(0),
        ),
      );

    final cipherWithMac = Uint8List.fromList([...cipherText, ...mac]);
    final plainBytes = cipher.process(cipherWithMac);

    return utf8.decode(plainBytes);
  }

  Future<Uint8List> _deriveRuleKey(String ruleId) async {
    final derivator = KeyDerivator('SHA-256/HKDF')
      ..init(
        HkdfParameters(
          await _keyProvider(),
          _keyLength,
          Uint8List.fromList(utf8.encode(_ruleKeySalt)),
          Uint8List.fromList(utf8.encode(ruleId)),
        ),
      );

    return derivator.process(Uint8List(0));
  }

  Uint8List _randomBytes(int length) {
    return Uint8List.fromList(
      List<int>.generate(
        length,
        (_) => _secureRandom.nextInt(256),
        growable: false,
      ),
    );
  }
}
