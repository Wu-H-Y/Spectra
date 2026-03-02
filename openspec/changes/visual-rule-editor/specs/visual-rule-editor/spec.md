## ADDED Requirements

### Requirement: Visual Node Graph Editor
The editor MUST supply a drag-and-drop workspace where nodes represent pipeline extractions and edges represent data flow.

#### Scenario: Chain Rule Steps
- **WHEN** a user connects a CSS extraction node to a Trimming node
- **THEN** the editor visually represents the sequence of execution

### Requirement: Strict Serialization
The node graph MUST perfectly serialize back to the unified JSON array syntax matching the `ts-rs` definitions.

#### Scenario: Save Graph to JSON
- **WHEN** a user finishes connecting nodes and saves the rule
- **THEN** the editor outputs a JSON array structure understandable by the Rust evaluation engine
