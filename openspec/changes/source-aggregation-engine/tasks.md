## 1. Rust NLP Support
- [ ] 1.1 In `Cargo.toml`, add `jieba-rs`, `ferrous-opencc`, `textdistance`.
- [ ] 1.2 In `rust/src/api/text_processor.rs`, expose `segment` and `to_simplified` to FRB.
- [ ] 1.3 In `rust/src/api/similarity.rs`, expose `jaccard` and `levenshtein`.

## 2. Dart Merger Logic
- [ ] 2.1 Implement `TitleNormalizer` in Dart utilizing the generated FFI methods.
- [ ] 2.2 Implement `SourceMerger` comparing incoming streams of `CrawlerItem` against an existing set of `MergedReference`.

## 3. UI Integration
- [ ] 3.1 Refactor the current search provider state in Dart to consume and output an ever-updating `Stream` of filtered items rather than a flat `Future<List>`.
- [ ] 3.2 Add UI visual tags inside `SearchItemCard` to represent the number of sources aggregated (e.g., `[6 Sources]`).