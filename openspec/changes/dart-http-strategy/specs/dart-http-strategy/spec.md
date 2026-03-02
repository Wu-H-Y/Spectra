## ADDED Requirements

### Requirement: Abstract HTTP fetch via Strategy
The system MUST decouple HTTP network requests into a strategy pattern abstracting across the FFI boundaries.

#### Scenario: Send a GET Request
- **WHEN** a simple `GET` request is evaluated
- **THEN** it executes standard mapping parameters (URL, Headers, Timeout) to the underlying Rust method call

### Requirement: Serialize Cookie and Proxy Profiles
The strategy MUST serialize dynamic connection attributes into configurations before requesting Data from the Rust Client.

#### Scenario: Pass Authentication Cookies
- **WHEN** cookies are passed inside the `NetworkConfig` execution state
- **THEN** the Rust FFI parses and sets the associated headers

### Requirement: Return Safe Functional Types
The strategy MUST return an `Either<Failure, HttpResponse>` wrapped object containing status codes, body payloads arrays, and headers.

#### Scenario: Catch Connection Timeout
- **WHEN** the FFI raises a Timeout exception
- **THEN** it maps to an app-level `NetworkFailure` rather than a raw Dart exception