## Context

Processing results from 10+ crawling targets for a single search string means resolving hundreds of titles and author strings against each other. Traditional `title == target_title` logic fails due to differences in whitespace, localization (Traditional vs Simplified Chinese), and metadata appended to titles (e.g., "Naruto (HD)").

## Goals / Non-Goals

**Goals:**
- Implement fuzzy matching string algorithms (Jaccard Index, Levenshtein Distance).
- Implement a pre-processing pipeline for title normalization (convert to Simplified Chinese, strip common noise words).
- Expose the heavy comparison computation to the Rust FFI to avoid blocking the Dart UI isolate when evaluating hundreds of O(n^2) Cartesian products.

**Non-Goals:**
- Machine learning embeddings for semantic similarity. We stick strictly to token-based or edit-distance strings.

## Decisions

- **Decision:** Utilize Rust (`jieba-rs` for tokenizing Chinese chars, and `ferrous-opencc` for Simplified/Traditional conversion) through the FFI for the string normalization and `textdistance` crate for the Jaccard similarity.
- **Rationale:** Analyzing and tokenizing Chinese text in Dart is slow and lacks good, up-to-date segmentation libraries compared to Rust's NLP ecosystem.

## Risks / Trade-offs

- **[Risk] Slower search response times.** Waiting for all 10 sources to finish before merging them ruins the "progressive load" experience.
  - **Mitigation:** Implement streaming aggregation. The engine should emit a `Stream<MergedResult>` and incrementally patch similarities as slower sources trickle in.