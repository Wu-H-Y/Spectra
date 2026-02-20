# State Management Specification (Delta)

## MODIFIED Requirements

### Requirement: ProviderScope application wrapper
The system SHALL wrap the entire application with Riverpod's ProviderScope to enable state management across all widgets.

#### Scenario: Application initialization
- **WHEN** the application starts
- **THEN** ProviderScope SHALL be the root widget wrapping SpectraApp

#### Scenario: Provider access
- **WHEN** any widget needs to access state
- **THEN** the widget SHALL use `ref.read()` or `ref.watch()` to access providers

---

### Requirement: Code-generated providers
The system SHALL use riverpod_generator to create type-safe providers with the `@riverpod` annotation.

#### Scenario: Provider definition
- **WHEN** a developer defines a provider
- **THEN** the provider SHALL use `@riverpod` annotation on a class extending `_$ClassName`

#### Scenario: Generated code availability
- **WHEN** build_runner completes successfully
- **THEN** generated `.g.dart` files SHALL be available for all annotated providers

---

### Requirement: Global providers in shared layer
The system SHALL place application-wide providers in `lib/shared/providers/` directory.

#### Scenario: Theme mode provider
- **WHEN** the app needs to access or modify theme mode
- **THEN** ThemeModeProvider SHALL provide current theme mode and toggle method

#### Scenario: Locale provider
- **WHEN** the app needs to access or modify locale
- **THEN** LocaleProvider SHALL provide current locale and change method

---

### Requirement: Feature-scoped providers
Each feature module SHALL have its own `presentation/providers/` directory for feature-specific state.

#### Scenario: Feature provider isolation
- **WHEN** a feature defines providers
- **THEN** providers SHALL be scoped to that feature's directory

#### Scenario: Cross-feature state access
- **WHEN** a feature needs to access another feature's state
- **THEN** the feature SHALL import the provider from the other feature's providers directory

---

### Requirement: State persistence integration
The system SHALL integrate with Hive CE for persisting user preferences through providers.

#### Scenario: Theme persistence
- **WHEN** user changes theme mode
- **THEN** the new setting SHALL be persisted to Hive and restored on app restart

#### Scenario: Locale persistence
- **WHEN** user changes locale
- **THEN** the new setting SHALL be persisted to Hive and restored on app restart

---

## ADDED Requirements

### Requirement: hooks_riverpod package
The system SHALL use `hooks_riverpod` instead of `flutter_riverpod` to enable hooks integration.

#### Scenario: Package dependency
- **WHEN** setting up the project
- **THEN** `hooks_riverpod: ^3.2.1` SHALL be a dependency instead of `flutter_riverpod`

#### Scenario: ProviderScope compatibility
- **WHEN** using ProviderScope
- **THEN** it SHALL work identically to flutter_riverpod's ProviderScope

---

### Requirement: HookConsumerWidget as standard widget base
Widgets that need provider access SHALL extend `HookConsumerWidget` to enable both hooks and provider usage.

#### Scenario: Widget with provider access
- **WHEN** a widget needs to watch or read providers
- **THEN** the widget SHALL extend `HookConsumerWidget`

#### Scenario: Build method with ref
- **WHEN** implementing a HookConsumerWidget
- **THEN** the build method signature SHALL be `Widget build(BuildContext context, WidgetRef ref)`

#### Scenario: ConsumerWidget migration
- **WHEN** migrating existing ConsumerWidget code
- **THEN** change the base class to `HookConsumerWidget` and add `WidgetRef ref` parameter

---

### Requirement: flutter_hooks for local state
The system SHALL use `flutter_hooks` package for managing local widget state alongside providers.

#### Scenario: Package dependency
- **WHEN** setting up the project
- **THEN** `flutter_hooks: ^0.21.2` SHALL be a dependency

#### Scenario: Hook usage in widgets
- **WHEN** a widget needs local state (not shared)
- **THEN** hooks like `useState`, `useEffect`, `useMemoized` SHALL be used

---

### Requirement: Hook-based controller management
TextEditingControllers, AnimationControllers, and other controllers SHALL be managed using hooks for automatic disposal.

#### Scenario: TextEditingController with hook
- **WHEN** a TextField needs a controller
- **THEN** `useTextEditingController()` SHALL be used instead of manual initialization

#### Scenario: AnimationController with hook
- **WHEN** an animation is needed
- **THEN** `useAnimationController()` SHALL be used with automatic vsync and disposal

#### Scenario: Automatic resource cleanup
- **WHEN** the widget is removed from the tree
- **THEN** all hook-managed controllers SHALL be automatically disposed
