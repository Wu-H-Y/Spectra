## ADDED Requirements

### Requirement: String Manipulations
The system MUST provide high-performance native string transformation functions in Rust, including `trim`, `replace`, `lower`, `upper`.

#### Scenario: Trim Whitespace
- **WHEN** a string with leading and trailing whitespaces is processed via `@trim`
- **THEN** it returns a clean, trimmed string

### Requirement: URL Operations
The system MUST provide native URL joining operations via a `url` crate.

#### Scenario: Join Base URL
- **WHEN** a base URL and a relative path are processed
- **THEN** it returns a valid, absolute URL string