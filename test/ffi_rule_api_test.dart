import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:spectra/core/rust/api.dart';
import 'package:spectra/core/rust/frb_generated.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    RustLib.initMock(api: _MockRustApi());
  });

  test('validateRule returns structured diagnostics', () async {
    final envelopeJson = await File(
      'fixtures/ir_v1_invalid_edge.json',
    ).readAsString();

    final result = validateRule(envelopeJson: envelopeJson);

    expect(result.valid, isFalse);
    expect(result.diagnostics, isNotEmpty);
    expect(result.diagnostics.first.code, 'UNKNOWN_NODE');
    expect(result.diagnostics.first.path, 'graph.edges[1].from.nodeId');
  });

  test('executeRule returns runId for valid rule', () async {
    final envelopeJson = await File(
      'fixtures/ir_v1_json_api_bundle.json',
    ).readAsString();

    final result = await executeRule(
      envelopeJson: envelopeJson,
      context: const FfiExecuteContext(runId: 'dart-test-run'),
    );

    expect(result.error, isNull);
    expect(result.runId, 'dart-test-run');
  });
}

class _MockRustApi extends RustLibApi {
  @override
  Future<FfiExecuteResponse> crateFfiExecuteRule({
    required String envelopeJson,
    FfiExecuteContext? context,
  }) async {
    if (envelopeJson.contains('ghost_node')) {
      return const FfiExecuteResponse(
        runId: 'mock-run-invalid',
        error: FfiExecuteError(
          code: 'VALIDATION_FAILED',
          message: '规则校验失败',
          diagnostics: [
            FfiDiagnostic(
              code: 'UNKNOWN_NODE',
              path: 'graph.edges[1].from.nodeId',
              message: '引用了不存在的节点 `ghost_node`',
              nodeId: 'ghost_node',
            ),
          ],
        ),
      );
    }

    return FfiExecuteResponse(
      runId: context?.runId ?? 'mock-run-valid',
    );
  }

  @override
  Future<FfiExecuteContext> crateFfiFfiExecuteContextDefault() async =>
      const FfiExecuteContext();

  @override
  bool crateFfiPing() => true;

  @override
  FfiValidationResult crateFfiValidateRule({required String envelopeJson}) {
    if (envelopeJson.contains('ghost_node')) {
      return const FfiValidationResult(
        valid: false,
        diagnostics: [
          FfiDiagnostic(
            code: 'UNKNOWN_NODE',
            path: 'graph.edges[1].from.nodeId',
            message: '引用了不存在的节点 `ghost_node`',
            nodeId: 'ghost_node',
          ),
        ],
      );
    }

    return const FfiValidationResult(valid: true, diagnostics: []);
  }
}
