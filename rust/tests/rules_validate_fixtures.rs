use spectra_native::rules_validate::validate_rule;

mod rules_validate_support;

use rules_validate_support::{
    CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT, CODE_DUPLICATE_NODE_ID, CODE_GRAPH_CYCLE,
    CODE_TYPE_MISMATCH, CODE_UNKNOWN_NODE, load_fixture,
};

#[test]
fn validate_min_fixture_success() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics.is_empty(),
        "最小规则不应产生诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_invalid_edge_fixture_reports_unknown_node() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_invalid_edge.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics.iter().any(|diagnostic| {
            diagnostic.code == CODE_UNKNOWN_NODE
                && diagnostic.path.as_deref() == Some("graph.edges[1].from.nodeId")
                && diagnostic.node_id.as_deref() == Some("ghost_node")
        }),
        "无效边 fixture 应包含 UNKNOWN_NODE 诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_type_mismatch_fixture_reports_type_mismatch() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_type_mismatch.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|diagnostic| diagnostic.code == CODE_TYPE_MISMATCH),
        "类型不匹配 fixture 应包含 TYPE_MISMATCH 诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_cycle_fixture_reports_cycle() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_cycle.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|diagnostic| diagnostic.code == CODE_GRAPH_CYCLE),
        "环路 fixture 应包含 GRAPH_CYCLE 诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_html_story_fixture_success() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_html_story_bundle.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics.is_empty(),
        "HTML 示例 fixture 不应产生诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_json_api_fixture_success() {
    let rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_json_api_bundle.json"
    )));
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics.is_empty(),
        "JSON API 示例 fixture 不应产生诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_pagination_capability_requires_search_output() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    rule.normalized_outputs.clear();
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics.iter().any(|diagnostic| {
            diagnostic.code == CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT
                && diagnostic.path.as_deref() == Some("capabilities.supportsPagination")
        }),
        "分页能力缺少 search 输出时应产生 capability 诊断: {diagnostics:#?}"
    );
}

#[test]
fn validate_duplicate_node_without_cycle_does_not_report_graph_cycle() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    let duplicate_node = rule.graph.nodes[0].clone();
    rule.graph.nodes.push(duplicate_node);
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|diagnostic| diagnostic.code == CODE_DUPLICATE_NODE_ID),
        "重复节点应保留 DUPLICATE_NODE_ID 诊断: {diagnostics:#?}"
    );
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_GRAPH_CYCLE),
        "重复节点但无环时不应误报 GRAPH_CYCLE: {diagnostics:#?}"
    );
}
