# Web Rule Editor

## ADDED Requirements

### Requirement: Technology Stack

The editor SHALL be built with:

- React 18+ with TypeScript
- Vite for development and build
- Tailwind CSS for styling
- shadcn/ui for UI components
- React Flow for visual node editing
- Monaco Editor for code editing
- Zustand for state management
- TanStack Query for API calls

#### Scenario: Build output

- **WHEN** the editor is built
- **THEN** the output SHALL be placed in assets/editor/

---

### Requirement: Rule CRUD

The editor SHALL support rule operations:

- Create new rule
- Read rule list
- Update existing rule
- Delete rule
- Duplicate rule
- Import/Export rule (JSON)

#### Scenario: Rule creation

- **WHEN** user creates a new rule
- **THEN** the editor SHALL generate a unique ID and save to backend

---

### Requirement: Form-Based Editing

The editor SHALL provide form-based rule editing:

- Rule metadata (name, type, version)
- URL matching configuration
- Request configuration
- Field mapping with selector picker
- Pagination configuration

#### Scenario: Form validation

- **WHEN** user submits the form
- **THEN** the editor SHALL validate all required fields

---

### Requirement: Code Editor

The editor SHALL provide JSON code editing:

- Monaco Editor integration
- JSON Schema validation
- Syntax highlighting
- Auto-completion
- Format on save

#### Scenario: JSON editing

- **WHEN** user edits JSON directly
- **THEN** the editor SHALL validate and show errors

---

### Requirement: Selector Testing

The editor SHALL support selector testing:

- Send URL to Flutter app for preview
- Receive selected elements via WebSocket
- Auto-fill selector fields

#### Scenario: Element selection

- **WHEN** user clicks "Select Element" button
- **THEN** the editor SHALL send preview request to Flutter app

---

### Requirement: Preview Integration

The editor SHALL integrate with Flutter preview:

- WebSocket connection to Flutter backend
- Real-time selector updates
- Preview screenshots display

#### Scenario: WebSocket connection

- **WHEN** editor connects to Flutter backend
- **THEN** a WebSocket connection SHALL be established

---

### Requirement: Multi-language Support

The editor SHALL support internationalization:

- Chinese (zh-CN)
- English (en-US)

#### Scenario: Language switching

- **WHEN** user changes language
- **THEN** all UI text SHALL update accordingly
