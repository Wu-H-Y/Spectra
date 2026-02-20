# Flutter Hooks Specification

## ADDED Requirements

### Requirement: HookConsumerWidget as base class
All widgets that need both hooks and provider access SHALL extend `HookConsumerWidget` instead of `ConsumerWidget` or `StatefulWidget`.

#### Scenario: Widget with hooks and providers
- **WHEN** a widget needs to use hooks and access providers
- **THEN** the widget SHALL extend `HookConsumerWidget`

#### Scenario: Build method signature
- **WHEN** implementing a HookConsumerWidget
- **THEN** the build method SHALL accept `(BuildContext context, WidgetRef ref)` parameters

---

### Requirement: useState for local mutable state
The system SHALL use `useState<T>()` hook for managing local mutable state within widgets.

#### Scenario: Initialize local state
- **WHEN** a widget needs local mutable state
- **THEN** `useState(initialValue)` SHALL be called in the build method

#### Scenario: Update local state
- **WHEN** updating local state
- **THEN** the code SHALL assign to `state.value` which triggers a rebuild

#### Scenario: Access current value
- **WHEN** reading the current state value
- **THEN** the code SHALL access `state.value`

---

### Requirement: useEffect for side effects
The system SHALL use `useEffect()` hook for handling side effects including initialization and cleanup.

#### Scenario: Initialization effect
- **WHEN** a widget needs to run code on mount
- **THEN** `useEffect(() { ... }, [])` SHALL be used with empty dependency array

#### Scenario: Cleanup on dispose
- **WHEN** a widget needs to clean up resources
- **THEN** the effect callback SHALL return a cleanup function

#### Scenario: Dependency-based re-execution
- **WHEN** an effect should re-run when values change
- **THEN** those values SHALL be included in the dependency array

---

### Requirement: useMemoized for expensive computations
The system SHALL use `useMemoized()` hook to cache expensive computations.

#### Scenario: Cache computation result
- **WHEN** performing an expensive computation
- **THEN** `useMemoized(() => computation, [dependencies])` SHALL be used

#### Scenario: Re-compute on dependency change
- **WHEN** a dependency value changes
- **THEN** the computation SHALL be re-executed and the cache updated

---

### Requirement: Controller hooks for Flutter widgets
The system SHALL use controller hooks for managing TextEditingController, AnimationController, ScrollController, etc.

#### Scenario: Text editing controller
- **WHEN** a TextField needs a controller
- **THEN** `useTextEditingController()` hook SHALL be used

#### Scenario: Animation controller
- **WHEN** an animation is needed
- **THEN** `useAnimationController()` hook SHALL be used

#### Scenario: Focus node
- **WHEN** focus management is needed
- **THEN** `useFocusNode()` hook SHALL be used

#### Scenario: Automatic disposal
- **WHEN** the widget is disposed
- **THEN** all controller hooks SHALL automatically dispose their resources

---

### Requirement: useListenable for ValueNotifier and ChangeNotifier
The system SHALL use `useListenable()` hook to subscribe to Listenable objects.

#### Scenario: Subscribe to ValueNotifier
- **WHEN** a widget needs to react to ValueNotifier changes
- **THEN** `useListenable(valueNotifier)` SHALL be used

#### Scenario: Selective rebuild with useListenableSelector
- **WHEN** only specific properties should trigger rebuild
- **THEN** `useListenableSelector(listenable, selector)` SHALL be used

---

### Requirement: Hooks rules compliance
All hooks SHALL follow the rules of hooks: called unconditionally at the top level of build method.

#### Scenario: No conditional hooks
- **WHEN** writing a widget's build method
- **THEN** hooks SHALL NOT be called inside if statements, loops, or nested functions

#### Scenario: Consistent call order
- **WHEN** multiple hooks are used
- **THEN** they SHALL be called in the same order on every build

#### Scenario: Top-level only
- **WHEN** calling hooks
- **THEN** they SHALL only be called directly in the build method, not in callbacks or helpers

---

### Requirement: Migration from StatefulWidget
StatefulWidgets SHALL be migrated to HookConsumerWidget when they benefit from hooks.

#### Scenario: Replace initState
- **WHEN** migrating from StatefulWidget
- **THEN** `initState` logic SHALL be moved to `useEffect(() { ... }, [])`

#### Scenario: Replace dispose
- **WHEN** migrating from StatefulWidget
- **THEN** `dispose` logic SHALL be moved to the cleanup function of `useEffect`

#### Scenario: Replace state variables
- **WHEN** migrating from StatefulWidget
- **THEN** state variables SHALL be replaced with `useState()` hooks
