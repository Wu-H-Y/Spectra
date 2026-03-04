// Dummy API file to expose the domain models to flutter_rust_bridge
use crate::domain::rule::{crawler_rule::CrawlerRule, pipeline::PipelineGraph};

// We just need functions that take or return these types
// so that flutter_rust_bridge parses the types and generates Dart equivalents.
pub fn validate_rule(rule: CrawlerRule) -> bool {
    // Dummy implementation
    !rule.id.is_empty()
}

pub fn create_empty_pipeline() -> PipelineGraph {
    PipelineGraph {
        nodes: vec![],
        edges: vec![],
    }
}
