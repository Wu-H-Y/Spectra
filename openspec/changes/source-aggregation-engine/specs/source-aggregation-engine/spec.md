## ADDED Requirements

### Requirement: Cross Source Aggregation
The system MUST aggregate search items originating from multiple distinct Crawler Sources into unified entries based on a configurable similarity threshold.

#### Scenario: Merge Identical Titles
- **WHEN** multiple sources return "Naruto" by "Masashi Kishimoto"
- **THEN** the API returns a single combined `MergedReference` object

### Requirement: String Normalization
The system MUST normalize Chinese strings by converting Traditional to Simplified and stripping punctuation prior to Jaccard matching via the Rust NLP FFI.

#### Scenario: Normalize Titles
- **WHEN** "火影忍者" and "火影忍者（高畫質）" are evaluated
- **THEN** they score above the 0.96 threshold due to NLP stripping