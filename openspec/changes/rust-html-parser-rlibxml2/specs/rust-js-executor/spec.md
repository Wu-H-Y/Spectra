## ADDED Requirements

### Requirement: JS Execution Context
The system MUST provide an isolated JavaScript execution environment for dynamic string transformations via the `rquickjs` engine.

#### Scenario: Evaluate Basic JavaScript
- **WHEN** a valid JavaScript snippet operating on a string variable `val` is provided
- **THEN** it executes safely and returns the modified string

### Requirement: Context Variables in JS
The JS execution environment MUST support injecting context variables (e.g., `vars.host`) so the snippet can access external request state.

#### Scenario: Inject Vars Context
- **WHEN** context variables are serialized to the execution context
- **THEN** the script can access them via the `vars` object