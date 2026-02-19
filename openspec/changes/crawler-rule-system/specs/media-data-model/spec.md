# Media Data Model

## ADDED Requirements

### Requirement: Base Content Model

The system SHALL define a base content model using freezed with the following fields:

- `id`: Unique identifier (required)
- `title`: Content title (required)
- `cover`: Cover/thumbnail URL (optional)
- `description`: Description/summary (optional)
- `author`: Author information (optional, Author model)
- `tags`: List of tags (optional)
- `category`: Category name (optional)
- `stats`: Content statistics (optional, ContentStats model)
- `createdAt`: Publish date (optional)
- `updatedAt`: Last update date (optional)
- `source`: Content source information (required, ContentSource model)

#### Scenario: Model immutability

- **WHEN** a BaseContent instance is created
- **THEN** all fields SHALL be immutable

#### Scenario: JSON serialization

- **WHEN** a BaseContent is serialized to JSON
- **THEN** the result SHALL be valid JSON matching the model schema

---

### Requirement: Author Model

The system SHALL define an Author model with:

- `id`: Author identifier (optional)
- `name`: Author name (required)
- `avatar`: Avatar URL (optional)
- `description`: Author description (optional)
- `followerCount`: Number of followers (optional)

#### Scenario: Author creation

- **WHEN** an Author is created with only name
- **THEN** the model SHALL be valid with other fields as null

---

### Requirement: Content Stats Model

The system SHALL define a ContentStats model with:

- `viewCount`: View/play count
- `likeCount`: Like count
- `favoriteCount`: Favorite/bookmark count
- `commentCount`: Comment count
- `shareCount`: Share count
- `rating`: Rating score (0-10 or 0-5)
- `ratingCount`: Number of ratings

#### Scenario: Stats aggregation

- **WHEN** content stats are displayed
- **THEN** the system SHALL format large numbers appropriately (e.g., 1.2K, 3.5M)

---

### Requirement: Content Source Model

The system SHALL define a ContentSource model with:

- `ruleId`: Crawler rule ID that extracted this content (required)
- `siteName`: Source site name (required)
- `siteIcon`: Source site icon URL (optional)
- `originalUrl`: Original URL on source site (required)
- `crawledAt`: Timestamp when content was crawled (required)

#### Scenario: Source tracking

- **WHEN** content is saved
- **THEN** the source information SHALL be preserved for future updates

---

### Requirement: Video Content Model

The system SHALL define a VideoContent model extending BaseContent with:

- `type`: Always "video"
- `duration`: Video duration in seconds (optional)
- `playUrl`: Video playback URL (optional)
- `qualities`: List of VideoQuality (optional)
- `chapters`: List of VideoChapter (optional)
- `previewUrl`: Preview/GIF URL (optional)
- `subtitle`: List of Subtitle (optional)
- `danmaku`: DanmakuConfig (optional)
- `status`: Video status (ongoing|completed|upcoming)
- `isVip`: VIP-only flag
- `isPaid`: Paid content flag

#### Scenario: Video with multiple qualities

- **WHEN** a video has multiple quality options
- **THEN** the qualities list SHALL contain all available options

---

### Requirement: Comic Content Model

The system SHALL define a ComicContent model extending BaseContent with:

- `type`: Always "comic"
- `chapters`: List of ComicChapter (required)
- `status`: Comic status (ongoing|completed|hiatus|cancelled)
- `lastChapter`: Latest chapter info (optional)
- `readDirection`: Reading direction (ltr|rtl|vertical)
- `ageRating`: Age restriction (optional)
- `chapterCount`: Total chapter count
- `totalImages`: Total image count

#### Scenario: Comic chapter structure

- **WHEN** a comic chapter is loaded
- **THEN** the images list SHALL contain all page URLs in reading order

---

### Requirement: Novel Content Model

The system SHALL define a NovelContent model extending BaseContent with:

- `type`: Always "novel"
- `chapters`: List of NovelChapter (required)
- `status`: Novel status (ongoing|completed|hiatus|cancelled)
- `wordCount`: Total word count (optional)
- `lastChapter`: Latest chapter info (optional)
- `chapterCount`: Total chapter count

#### Scenario: Novel chapter content

- **WHEN** a novel chapter is loaded
- **THEN** the content field SHALL contain the chapter text

---

### Requirement: Music Content Model

The system SHALL define a MusicContent model extending BaseContent with:

- `type`: Always "music"
- `audioUrl`: Audio playback URL (optional)
- `duration`: Duration in seconds (optional)
- `artist`: Artist name or array of names (required)
- `album`: Album name (optional)
- `albumCover`: Album cover URL (optional)
- `qualities`: List of AudioQuality (optional)
- `lyrics`: Lyrics model (optional)
- `mvUrl`: Music video URL (optional)
- `copyright`: Copyright information (optional)

#### Scenario: Music with lyrics

- **WHEN** a music track has lyrics
- **THEN** the lyrics model SHALL include both text and optional LRC format

---

### Requirement: Image Content Model

The system SHALL define an ImageContent model extending BaseContent with:

- `type`: Always "image"
- `images`: List of ImageInfo (required)
- `isAlbum`: Whether it's an album (required)
- `resolution`: Image resolution (optional)
- `isAIGenerated`: AI-generated flag (optional)
- `aiModel`: AI model name if applicable (optional)

#### Scenario: Single image vs album

- **WHEN** isAlbum is false
- **THEN** images list SHALL contain exactly one item

---

### Requirement: All Models Use freezed

The system SHALL define all media models using freezed annotations:

```dart
@freezed
class VideoContent with _$VideoContent {
  const factory VideoContent({
    required String id,
    required String title,
    // ... other fields
  }) = _VideoContent;

  factory VideoContent.fromJson(Map<String, dynamic> json) =>
      _$VideoContentFromJson(json);
}
```

#### Scenario: Code generation

- **WHEN** build_runner is executed
- **THEN** freezed SHALL generate .freezed.dart and .g.dart files

#### Scenario: Pattern matching

- **WHEN** media content type needs to be determined
- **THEN** the system SHALL use freezed pattern matching capabilities
