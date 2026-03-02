## Why

Currently, when a user searches for a video, novel, or manga, Spectra queries all installed rules/sources and returns a fragmented list where identical content from different sources appears multiple times. To improve user experience, we need a unification engine that intelligently groups identical content from different sources into single entries and ranks the best source provider for playback or reading.

## What Changes

- **Source Merger Engine**: Implementing an aggregation engine using Jaccard/Levenshtein similarity to merge identical search results (based on titles, authors, type).
- **Search Strategy**: Introducing multiple search modes: `ExactSearchStrategy` (full text) vs `FuzzySearchStrategy` (split search queries combined).
- **Chapter/TOC Deduplication**: Dealing with off-by-one errors when merging chapters across two different providers.

## Capabilities

### New Capabilities
- `source-aggregation-engine`: The data pipeline responsible for reducing N disparate search lists into a unified, singular merged list that routes internally to the highest fidelity source.

### Modified Capabilities
- None.

## Impact

- Creates `lib/core/aggregation/` module.
- Introduces `textdistance` calculation algorithms via Dart or Rust FFI (Rust preferred for sheer computational speed).
- Dramatically impacts the UI layer of `SearchPage`, which must now display merged source representations rather than standalone website results.