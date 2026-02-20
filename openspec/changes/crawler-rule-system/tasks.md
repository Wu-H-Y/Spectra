# Crawler Rule System - Implementation Tasks

## 1. Project Setup

- [x] 1.1 Add freezed dependencies (freezed_annotation, freezed, json_serializable)
- [x] 1.2 Add shelf dependencies (shelf, shelf_router, shelf_websocket, shelf_static)
- [x] 1.3 Create directory structure for core/crawler/, core/server/, core/media/
- [x] 1.4 Initialize web-editor project with Vite + React + TypeScript
- [x] 1.5 Configure web-editor with Tailwind CSS and shadcn/ui
- [ ] 1.6 Add sizer dependency for responsive UI layout

## 2. Media Data Models (freezed)

- [x] 2.1 Create BaseContent model with shared fields
- [x] 2.2 Create Author model
- [x] 2.3 Create ContentStats model
- [x] 2.4 Create ContentSource model
- [x] 2.5 Create VideoContent model with video-specific fields
- [x] 2.6 Create ComicContent model with comic-specific fields
- [x] 2.7 Create NovelContent model with novel-specific fields
- [x] 2.8 Create MusicContent model with music-specific fields
- [x] 2.9 Create ImageContent model with image-specific fields
- [x] 2.10 Run build_runner to generate freezed code

## 3. Crawler Rule DSL Models (freezed)

- [x] 3.1 Create MediaType enum
- [x] 3.2 Create SelectorType enum (css, xpath, regex, jsonpath, js)
- [x] 3.3 Create Selector model
- [x] 3.4 Create FieldMapping model
- [x] 3.5 Create Transform model
- [x] 3.6 Create PaginationConfig model
- [x] 3.7 Create ListExtract model
- [x] 3.8 Create DetailExtract model
- [x] 3.9 Create ContentExtract model
- [x] 3.10 Create ExtractConfig model
- [x] 3.11 Create MatchConfig model
- [x] 3.12 Create RequestConfig model
- [x] 3.13 Create Action union type (wait, click, scroll, fill, script, condition, loop)
- [x] 3.14 Create DetectionConfig model
- [x] 3.15 Create CrawlerRule model
- [x] 3.16 Run build_runner to generate freezed code

## 4. HTTP Server

- [x] 4.1 Create server_provider.dart with Shelf server
- [x] 4.2 Implement CORS middleware
- [x] 4.3 Create router with /api/* routes
- [x] 4.4 Implement static file handler for /editor/*
- [x] 4.5 Create rules CRUD handlers (GET, POST, PUT, DELETE)
- [x] 4.6 Implement WebSocket handler at /api/ws
- [x] 4.7 Create server status provider (port, URL, running state)
- [x] 4.8 Add server entry point in settings page

## 5. Selector Engine

- [x] 5.1 Implement CSS selector evaluator
- [x] 5.2 Implement XPath evaluator
- [x] 5.3 Implement Regex extractor
- [x] 5.4 Implement JSONPath evaluator
- [x] 5.5 Implement JavaScript expression evaluator
- [x] 5.6 Create SelectorEngine with fallback support

## 6. Rule Execution Engine

- [x] 6.1 Create RuleParser for JSON to model conversion
- [x] 6.2 Implement rule validation with error reporting
- [x] 6.3 Create ListExtractor for list page extraction
- [x] 6.4 Create DetailExtractor for detail page extraction
- [x] 6.5 Create ContentExtractor for media content extraction
- [x] 6.6 Implement pagination handler (URL, click, infinite scroll)
- [x] 6.7 Create TransformPipeline for data transformation
- [x] 6.8 Create ExecutionState tracker
- [x] 6.9 Integrate with HTTP API (/api/execute, /api/validate)

## 7. Anti-Crawl Handling

- [ ] 7.1 Implement ActionExecutor (wait, click, scroll, fill, script)
- [ ] 7.2 Create ConditionEvaluator for conditional actions
- [ ] 7.3 Implement LoopExecutor for repeated actions
- [ ] 7.4 Create CaptchaDetector (reCAPTCHA, hCaptcha detection)
- [ ] 7.5 Implement RateLimitDetector (429, 503 detection)
- [ ] 7.6 Create ProxyManager for proxy rotation
- [ ] 7.7 Implement RequestThrottler with random delay

## 8. Page Preview

- [ ] 8.1 Create preview page UI with WebView
- [ ] 8.2 Implement element selection mode
- [ ] 8.3 Create CSS selector generator from element
- [ ] 8.4 Create XPath generator from element
- [ ] 8.5 Implement selector highlighting
- [ ] 8.6 Create WebSocket communication for preview events
- [ ] 8.7 Add preview entry point in Flutter app

## 9. Web Editor - Setup

- [ ] 9.1 Configure Vite build output to ../assets/editor/
- [ ] 9.2 Set up API proxy for development
- [ ] 9.3 Create WebSocket connection hook
- [ ] 9.4 Set up Zustand stores
- [ ] 9.5 Configure TanStack Query for API calls
- [ ] 9.6 Set up i18n with react-i18next

## 10. Web Editor - Rule Management

- [ ] 10.1 Create rule list page
- [ ] 10.2 Create rule editor layout (form + JSON toggle)
- [ ] 10.3 Implement rule metadata form
- [ ] 10.4 Implement URL matching form
- [ ] 10.5 Implement request configuration form
- [ ] 10.6 Implement field mapping editor
- [ ] 10.7 Implement pagination configuration form
- [ ] 10.8 Implement action sequence editor
- [ ] 10.9 Integrate Monaco Editor for JSON editing
- [ ] 10.10 Implement rule import/export

## 11. Web Editor - Preview Integration

- [ ] 11.1 Create preview trigger button
- [ ] 11.2 Implement WebSocket message handling for element selection
- [ ] 11.3 Create selector auto-fill functionality
- [ ] 11.4 Display preview screenshots
- [ ] 11.5 Implement selector testing panel

## 12. Integration & Testing

- [ ] 12.1 Write sample rules for testing (video, comic, novel, music sites)
- [ ] 12.2 Create integration tests for rule execution
- [ ] 12.3 Test WebSocket communication
- [ ] 12.4 Test mobile device access via LAN
- [ ] 12.5 Test QR code generation for mobile access
- [ ] 12.6 Performance optimization for large page extraction

## 13. Documentation

- [ ] 13.1 Write rule DSL documentation
- [ ] 13.2 Create rule examples for each media type
- [ ] 13.3 Document API endpoints
- [ ] 13.4 Write user guide for web editor

## 14. Responsive UI Implementation

- [ ] 14.1 Wrap MaterialApp with Sizer widget and configure breakpoints
- [ ] 14.2 Create ResponsiveLayout widget for device-type-based layout switching
- [ ] 14.3 Implement mobile layout with bottom navigation and single-column content
- [ ] 14.4 Implement tablet/desktop layout with side navigation and grid content
- [ ] 14.5 Convert fixed pixel values to sizer responsive units (.w, .h, .sp)
- [ ] 14.6 Create responsive spacing constants using sizer units
- [ ] 14.7 Implement responsive icon and button sizing
- [ ] 14.8 Add screen orientation handling for layout changes
- [ ] 14.9 Update page preview UI for responsive mobile/desktop display
- [ ] 14.10 Configure Tailwind CSS responsive breakpoints to match sizer
- [ ] 14.11 Test responsive layouts on different device sizes and orientations
