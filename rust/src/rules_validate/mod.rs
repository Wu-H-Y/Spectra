mod capabilities;
mod edges;
mod graph;
mod nodes;
mod phase;
mod topology;
mod types;
mod utils;

use capabilities::validate_capabilities;
use edges::validate_edges;
use graph::GraphIndex;
use nodes::{validate_cache_nodes, validate_cookie_nodes};
use phase::{validate_normalized_outputs, validate_phase_entrypoints};
use topology::validate_topology;

use crate::rules_ir::{Diagnostic, RuleEnvelope};

const CODE_DUPLICATE_NODE_ID: &str = "DUPLICATE_NODE_ID";
const CODE_DUPLICATE_INPUT_PORT: &str = "DUPLICATE_INPUT_PORT";
const CODE_DUPLICATE_OUTPUT_PORT: &str = "DUPLICATE_OUTPUT_PORT";
const CODE_UNKNOWN_NODE: &str = "UNKNOWN_NODE";
const CODE_UNKNOWN_PORT: &str = "UNKNOWN_PORT";
const CODE_INVALID_EDGE_PHASE_ORDER: &str = "INVALID_EDGE_PHASE_ORDER";
const CODE_TYPE_MISMATCH: &str = "TYPE_MISMATCH";
const CODE_GRAPH_CYCLE: &str = "GRAPH_CYCLE";
const CODE_INVALID_PHASE_ENTRYPOINT: &str = "INVALID_PHASE_ENTRYPOINT";
const CODE_INVALID_NORMALIZED_OUTPUT: &str = "INVALID_NORMALIZED_OUTPUT";
const CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT: &str =
    "CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT";
const CODE_CAPABILITY_JS_REQUIRED: &str = "CAPABILITY_JS_REQUIRED";
const CODE_CAPABILITY_CODEC_REQUIRED: &str = "CAPABILITY_CODEC_REQUIRED";
const CODE_CAPABILITY_CRYPTO_AES_REQUIRED: &str = "CAPABILITY_CRYPTO_AES_REQUIRED";
const CODE_INLINE_SECRET_NOT_ALLOWED: &str = "INLINE_SECRET_NOT_ALLOWED";
const CODE_INVALID_KEY_REF: &str = "INVALID_KEY_REF";
const CODE_CRYPTO_PARAM_REQUIRED: &str = "CRYPTO_PARAM_REQUIRED";
const CODE_CACHE_KEY_REQUIRED: &str = "CACHE_KEY_REQUIRED";
const CODE_CACHE_SCOPE_INVALID: &str = "CACHE_SCOPE_INVALID";
const CODE_CACHE_VALUE_LIMIT_INVALID: &str = "CACHE_VALUE_LIMIT_INVALID";
const CODE_COOKIE_NAME_REQUIRED: &str = "COOKIE_NAME_REQUIRED";
const CODE_COOKIE_DOMAIN_INVALID: &str = "COOKIE_DOMAIN_INVALID";
const CODE_COOKIE_DOMAIN_NOT_ALLOWED: &str = "COOKIE_DOMAIN_NOT_ALLOWED";
const CODE_COOKIE_EXPIRES_INVALID: &str = "COOKIE_EXPIRES_INVALID";

const MAX_CACHE_VALUE_BYTES_LIMIT: usize = 262_144;

/// 校验规则 IR 并返回结构化诊断。
pub fn validate_rule(rule: &RuleEnvelope) -> Vec<Diagnostic> {
    let mut diagnostics = Vec::new();
    let graph_index = GraphIndex::build(rule, &mut diagnostics);

    validate_phase_entrypoints(rule, &graph_index, &mut diagnostics);
    validate_normalized_outputs(rule, &graph_index, &mut diagnostics);
    let valid_edges = validate_edges(rule, &graph_index, &mut diagnostics);
    validate_topology(&graph_index, &valid_edges, &mut diagnostics);
    validate_cache_nodes(rule, &mut diagnostics);
    validate_cookie_nodes(rule, &mut diagnostics);
    validate_capabilities(rule, &graph_index, &mut diagnostics);

    diagnostics
}
