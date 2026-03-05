import 'dart:convert';

import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/database/drift/app_database.dart';
import 'package:spectra/core/database/drift/rule_storage_cipher.dart';

void main() {
  group('AppDatabase 迁移与规则加密', () {
    test('从 schema v1 升级到 v2 后包含规则级密文字段', () async {
      final executor = NativeDatabase.memory(
        setup: (rawDb) {
          rawDb
            ..execute('''
            CREATE TABLE rules_v1 (
              id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
              rule_id TEXT NOT NULL UNIQUE,
              name TEXT NOT NULL,
              description TEXT,
              ir_version TEXT NOT NULL,
              rule_envelope_json TEXT NOT NULL,
              display_config_json TEXT,
              enabled INTEGER NOT NULL DEFAULT 1,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            );
          ''')
            ..execute('''
            CREATE TABLE sessions_v1 (
              id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
              session_id TEXT NOT NULL UNIQUE,
              cookie_jar_encrypted TEXT,
              kv_store_encrypted TEXT,
              created_at INTEGER NOT NULL,
              updated_at INTEGER NOT NULL
            );
          ''')
            ..execute('PRAGMA user_version = 1;');
        },
      );

      final database = AppDatabase(executor);
      addTearDown(database.close);

      final tableInfo = await database
          .customSelect("PRAGMA table_info('rules_v1')")
          .get();
      final columnNames = tableInfo
          .map((row) => row.data['name'] as String)
          .toSet();

      expect(columnNames.contains('cookie_jar_encrypted'), isTrue);
      expect(columnNames.contains('kv_store_encrypted'), isTrue);
    });

    test('相同 ruleId 写入后可解密恢复 cookieJar', () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);

      final keyProvider = InMemoryRuleMasterKeyProvider(
        utf8.encode('0123456789abcdef0123456789abcdef'),
      );
      final cipher = RuleStorageCipher(
        keyProvider: keyProvider.loadMasterKey,
      );

      const ruleId = 'rule-001';
      const cookieJarPlaintext =
          '{"domain":"example.com","cookie":"session=abc"}';
      final encryptedCookie = await cipher.encrypt(
        ruleId: ruleId,
        plaintext: cookieJarPlaintext,
      );

      await database
          .into(database.rulesV1)
          .insert(
            RulesV1Companion.insert(
              ruleId: ruleId,
              name: '规则测试',
              irVersion: '1.0.0',
              ruleEnvelopeJson: '{"nodes":[]}',
              cookieJarEncrypted: Value(encryptedCookie),
            ),
          );

      final storedRule = await (database.select(
        database.rulesV1,
      )..where((tbl) => tbl.ruleId.equals(ruleId))).getSingle();

      expect(storedRule.cookieJarEncrypted, isNotNull);
      expect(storedRule.cookieJarEncrypted, isNot(cookieJarPlaintext));

      final decryptedCookie = await cipher.decrypt(
        ruleId: ruleId,
        encryptedPayload: storedRule.cookieJarEncrypted!,
      );

      expect(decryptedCookie, cookieJarPlaintext);
    });
  });
}
