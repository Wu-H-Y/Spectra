## ADDED Requirements

### Requirement: Native HTML Parsing
The system MUST parse HTML documents using `rlibxml2` in a Rust environment, bypassing the Dart virtual machine to improve memory efficiency and speed.

#### Scenario: Parse HTML Document
- **WHEN** a raw HTML string is provided to the Rust FFI
- **THEN** it returns a structured document reference that can be queried natively

### Requirement: XPath Extraction
The system MUST support full XPath 1.0 syntax for querying parsed HTML documents using the `rlibxml2` engine.

#### Scenario: Extract Text Content via XPath
- **WHEN** an XPath query targeting text nodes is executed
- **THEN** it returns an array of matched strings

### Requirement: CSS Extraction
The system MUST support CSS selector syntax for querying HTML documents using the `scraper` library in Rust.

#### Scenario: Extract Elements via CSS
- **WHEN** a CSS selector query is executed
- **THEN** it returns an array of matched elements or strings

### Requirement: Regex Extraction
The system MUST support Regular Expression matching for extracting content directly from strings using the Rust `regex` crate.

#### Scenario: Extract Matches via Regex
- **WHEN** a valid regex pattern with capture groups is provided
- **THEN** it returns the captured string matches

### Requirement: JSONPath Extraction
The system MUST support JSONPath queries for extracting data from JSON strings using the `jsonpath-rust` crate.

#### Scenario: Extract Data via JSONPath
- **WHEN** a JSON string and a valid JSONPath query are provided
- **THEN** it returns the matched JSON values as strings