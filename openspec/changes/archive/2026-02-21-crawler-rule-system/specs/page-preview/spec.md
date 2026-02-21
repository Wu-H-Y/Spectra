# Page Preview

## ADDED Requirements

### Requirement: Preview Window

The system SHALL provide a page preview window in Flutter:

- Load target URL in WebView
- Support login and session handling
- Support scroll and interaction

#### Scenario: URL loading

- **WHEN** preview is opened with a URL
- **THEN** the system SHALL load the page in WebView

---

### Requirement: Element Selection Mode

The system SHALL support element selection mode:

- Highlight element on hover
- Generate CSS selector on click
- Generate XPath alternative
- Return selector data via WebSocket

#### Scenario: Element click

- **WHEN** user clicks an element in selection mode
- **THEN** the system SHALL generate and return the selector

#### Scenario: WebSocket message

- **WHEN** an element is selected
- **THEN** the system SHALL send:
```json
{
  "type": "element_selected",
  "data": {
    "selector": ".video-title",
    "selectorType": "css",
    "xpath": "//h1[@class='video-title']",
    "text": "元素文本",
    "html": "<h1 class=\"video-title\">...</h1>"
  }
}
```

---

### Requirement: Selector Highlighting

The system SHALL highlight matching elements:

- Accept selector from Web editor
- Highlight all matching elements
- Show element count

#### Scenario: Selector test

- **WHEN** Web editor sends a selector to test
- **THEN** the system SHALL highlight all matching elements

---

### Requirement: Preview Controls

The system SHALL provide preview controls:

- URL input field
- Refresh button
- Back/Forward navigation
- Selection mode toggle
- Close preview

#### Scenario: Navigation

- **WHEN** user clicks links in preview
- **THEN** the WebView SHALL navigate and update URL

---

### Requirement: Mobile/Desktop Support

The system SHALL support both platforms:

- Desktop: Open in new window/dialog
- Mobile: Full-screen preview with back button

#### Scenario: Responsive layout

- **WHEN** preview is opened on mobile
- **THEN** the system SHALL use full-screen layout

---

### Requirement: Communication Protocol

The system SHALL communicate with Web editor via WebSocket:

- `preview_open`: Open preview with URL
- `preview_select_mode`: Enter selection mode
- `preview_highlight`: Highlight elements matching selector
- `preview_screenshot`: Capture screenshot
- `element_selected`: Element selection result

#### Scenario: Connection establishment

- **WHEN** preview feature is used
- **THEN** WebSocket connection SHALL be established between Flutter and Web editor
