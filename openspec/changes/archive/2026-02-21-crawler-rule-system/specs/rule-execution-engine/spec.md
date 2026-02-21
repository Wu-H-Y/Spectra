# Rule Execution Engine

## ADDED Requirements

### Requirement: Rule Parsing

The system SHALL parse JSON rule definitions into Dart models:

- Validate JSON structure against schema
- Convert to freezed model instances
- Report validation errors with field paths

#### Scenario: Valid rule parsing

- **WHEN** a valid JSON rule is parsed
- **THEN** the system SHALL return a CrawlerRule instance

#### Scenario: Invalid rule handling

- **WHEN** an invalid JSON rule is parsed
- **THEN** the system SHALL return detailed validation errors

---

### Requirement: Selector Engine

The system SHALL implement a selector engine supporting multiple types:

- **CSS Selector**: Parse and evaluate CSS selectors against HTML
- **XPath**: Evaluate XPath expressions against HTML/XML
- **Regex**: Apply regular expressions to text content
- **JSONPath**: Evaluate JSONPath against JSON data
- **JavaScript**: Execute JS expressions in browser context

#### Scenario: CSS selector evaluation

- **WHEN** a CSS selector `.video-title` is evaluated
- **THEN** the system SHALL return matching element(s)

#### Scenario: Fallback selector

- **WHEN** a primary selector fails to match
- **THEN** the system SHALL try fallback selectors in order

---

### Requirement: List Extraction

The system SHALL extract data from list pages:

- Find container elements
- Extract fields from each container
- Support nested field extraction
- Handle pagination

#### Scenario: Multiple item extraction

- **WHEN** list extraction is executed
- **THEN** the system SHALL return an array of extracted items

---

### Requirement: Detail Extraction

The system SHALL extract data from detail pages:

- Follow links from list items
- Extract fields from detail page
- Support chapter/episode extraction

#### Scenario: Link following

- **WHEN** detail urlFromList is configured
- **THEN** the system SHALL fetch each detail URL before extraction

---

### Requirement: Content Extraction

The system SHALL extract media-specific content:

- Video: playUrl, qualities, subtitles
- Comic: images array
- Novel: chapter content text
- Music: audioUrl, lyrics

#### Scenario: Video URL extraction

- **WHEN** video content extraction is configured
- **THEN** the system SHALL extract playable URL(s)

---

### Requirement: Pagination Handling

The system SHALL handle pagination:

- **URL pagination**: Follow next page links
- **Click pagination**: Click load more buttons
- **Infinite scroll**: Scroll to load more content

#### Scenario: Max pages limit

- **WHEN** maxPages is configured
- **THEN** the system SHALL stop after reaching the limit

---

### Requirement: Data Transformation

The system SHALL apply data transformations:

- `trim`: Remove whitespace
- `number`: Parse numbers
- `date`: Parse dates
- `url`: Normalize URLs
- `regex`: Regex replacement
- `replace`: String replacement

#### Scenario: Chained transforms

- **WHEN** multiple transforms are configured
- **THEN** the system SHALL apply them in sequence

---

### Requirement: Execution State

The system SHALL track execution state:

- Current URL being processed
- Number of items extracted
- Errors encountered
- Progress percentage

#### Scenario: Progress reporting

- **WHEN** execution is in progress
- **THEN** the system SHALL report progress via callback/stream
