import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spectra/core/rust/rules_ir/normalized_model.dart';
import 'package:spectra/core/server/server_provider.dart';
import 'package:spectra/features/rules_execute/presentation/pages/rules_execute_page.dart';
import 'package:spectra/l10n/generated/l10n.dart';

void main() {
  testWidgets('renders fixed-template sections from execute result', (
    tester,
  ) async {
    final normalizedJson =
        jsonDecode(
              File(
                'fixtures/ir_v1_html_story_expected_normalized.json',
              ).readAsStringSync(),
            )
            as Map<String, dynamic>;
    final model = NormalizedModel.fromJson(normalizedJson);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          serverProvider.overrideWithValue(
            const ServerStatus(
              isRunning: true,
              port: 8080,
              url: 'http://localhost:8080',
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          home: RulesExecutePage(
            service: RulesExecuteService(
              execute: ({required serverUrl}) async => right(
                RulesExecuteResult(
                  executeResponseJson: const {
                    'runId': 'task-21-test',
                    'status': 'accepted',
                  },
                  normalizedJson: normalizedJson,
                  model: model,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byKey(const Key('rules_execute_run_button')));
    await tester.pumpAndSettle();

    expect(
      find.byKey(const Key('rules_execute_response_section')),
      findsOneWidget,
    );
    expect(
      find.byKey(const Key('rules_execute_normalized_section')),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_search_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.byKey(const Key('rules_execute_search_section')),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_detail_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.byKey(const Key('rules_execute_detail_section')),
      findsOneWidget,
    );

    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_toc_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.byKey(const Key('rules_execute_toc_section')), findsOneWidget);

    await tester.scrollUntilVisible(
      find.byKey(const Key('rules_execute_content_section')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(
      find.byKey(const Key('rules_execute_content_section')),
      findsOneWidget,
    );
    expect(find.text('星港纪事'), findsWidgets);
    expect(find.text('林潮声'), findsWidgets);
    expect(find.text('第一章, 起航'), findsOneWidget);
  });
}
