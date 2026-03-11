use std::collections::BTreeMap;

use spectra_native::{
    ffi::{FfiExecuteContext, execute_rule, validate_rule},
    rules_ir::{Capabilities, Graph, Metadata, RuleEnvelope},
};

const RUN_ID: &str = "run_runtime_001";

fn empty_rule_json() -> String {
    serde_json::to_string(&RuleEnvelope {
        ir_version: "1.0.0".to_string(),
        metadata: Metadata {
            rule_id: "ffi.empty".to_string(),
            name: "空规则".to_string(),
            description: Some("用于验证最小 execute 路径".to_string()),
        },
        graph: Graph {
            nodes: Vec::new(),
            edges: Vec::new(),
            phase_entrypoints: BTreeMap::new(),
            metadata: None,
            layout: None,
        },
        normalized_outputs: BTreeMap::new(),
        capabilities: Capabilities {
            supports_pagination: false,
            supports_concurrency: false,
            requires_auth: false,
            supports_js: false,
            codec: false,
            crypto: Default::default(),
            allow_inline_secrets: false,
        },
        rate_limit: None,
    })
    .expect("空规则应可序列化")
}

#[test]
fn validate_rule_returns_structured_parse_error() {
    let result = validate_rule("{invalid json".to_string());

    assert!(!result.valid);
    assert_eq!(result.diagnostics.len(), 1);
    assert_eq!(result.diagnostics[0].code, "INVALID_RULE_JSON");
    assert_eq!(result.diagnostics[0].path, "envelopeJson");
}

#[test]
fn validate_rule_returns_fixture_diagnostics() {
    let result = validate_rule(include_str!("../../fixtures/ir_v1_invalid_edge.json").to_string());

    assert!(!result.valid);
    assert!(result.diagnostics.iter().any(|diagnostic| {
        diagnostic.code == "UNKNOWN_NODE"
            && diagnostic.path == "graph.edges[1].from.nodeId"
            && diagnostic.node_id.as_deref() == Some("ghost_node")
    }));
}

#[tokio::test]
async fn execute_rule_returns_canonical_run_id_for_empty_rule() {
    let response = execute_rule(
        empty_rule_json(),
        Some(FfiExecuteContext {
            run_id: Some(RUN_ID.to_string()),
            ..FfiExecuteContext::default()
        }),
    )
    .await;

    assert_eq!(response.run_id.as_deref(), Some(RUN_ID));
    assert!(response.error.is_none());
    assert!(response.initial_result_json.is_none());
    assert!(response.rule_kv_json.is_none());
    assert!(response.cookie_jar_json.is_none());
}

#[tokio::test]
async fn execute_rule_returns_structured_validation_error_with_canonical_run_id() {
    let response = execute_rule(
        include_str!("../../fixtures/ir_v1_invalid_edge.json").to_string(),
        Some(FfiExecuteContext {
            run_id: Some(RUN_ID.to_string()),
            ..FfiExecuteContext::default()
        }),
    )
    .await;

    let error = response.error.expect("校验失败应返回结构化错误");
    assert_eq!(response.run_id.as_deref(), Some(RUN_ID));
    assert_eq!(error.code, "VALIDATION_FAILED");
    assert!(error.diagnostics.iter().any(|diagnostic| {
        diagnostic.code == "UNKNOWN_NODE" && diagnostic.path == "graph.edges[1].from.nodeId"
    }));
}

#[tokio::test]
async fn execute_rule_rejects_invalid_channel_capacity_at_adapter_boundary() {
    let response = execute_rule(
        empty_rule_json(),
        Some(FfiExecuteContext {
            run_id: Some(RUN_ID.to_string()),
            channel_capacity: Some(0),
            ..FfiExecuteContext::default()
        }),
    )
    .await;

    let error = response
        .error
        .expect("非法 channelCapacity 应返回结构化错误");
    assert_eq!(response.run_id.as_deref(), Some(RUN_ID));
    assert_eq!(error.code, "INVALID_CHANNEL_CAPACITY");
    assert_eq!(error.diagnostics.len(), 1);
    assert_eq!(error.diagnostics[0].path, "context.channelCapacity");
}
