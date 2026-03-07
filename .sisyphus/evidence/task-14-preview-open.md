# Task 14 - Preview Open Flow

## Summary

- Confirmed the existing server-side minimal preview session flow already exposes `POST /api/preview/open` via `lib/core/server/routes/preview_routes.dart` and mounts it from `lib/core/server/server_provider.dart`.
- Aligned the web editor to consume `wsChannel.previewSessionId` as the authoritative subscription channel while still accepting the top-level `previewSessionId` for backward compatibility.
- Strengthened the focused preview API test so a subscriber only receives `element_selected` events for the opened preview session.

## Files

- `web-editor/src/components/preview/PreviewPanel.tsx`
- `web-editor/src/hooks/useWebSocket.ts`
- `test/preview_api_test.dart`

## Verification

### 1. Targeted Dart analyze

Command:

```bash
dart analyze lib/core/server/server_provider.dart lib/core/server/routes/preview_routes.dart test/preview_api_test.dart
```

Outcome:

- Passed with no errors via `dart_analyze_files`.

### 2. Targeted preview flow test

Command:

```bash
flutter test test/preview_api_test.dart
```

Outcome:

- Passed.
- Verified `POST /api/preview/open` returns `opened`, `previewSessionId`, `debugUrl`, and `wsChannel.previewSessionId`.
- Verified a WebSocket subscriber scoped to one `previewSessionId` receives the matching `element_selected` callback and does not get a callback published for a different preview session.

### 3. Web editor format

Command:

```bash
bun run format:web
```

Outcome:

- Passed.

### 4. Web editor production build

Command:

```bash
bun run build:web
```

Outcome:

- Passed.

## Notes

- TypeScript LSP diagnostics were unavailable in the current environment because `typescript-language-server` is not installed.
- The web verification fallback was `bun run format:web` plus `bun run build:web`, which both passed.
