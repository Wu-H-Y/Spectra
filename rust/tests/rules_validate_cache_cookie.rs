use spectra_native::{
    rules_ir::{LifecyclePhase, Node, NodeKind},
    rules_validate::validate_rule,
};

mod rules_validate_support;

use rules_validate_support::{
    CODE_CACHE_KEY_REQUIRED, CODE_CACHE_SCOPE_INVALID, CODE_CACHE_VALUE_LIMIT_INVALID,
    CODE_COOKIE_DOMAIN_NOT_ALLOWED, CODE_COOKIE_EXPIRES_INVALID, MAX_CACHE_VALUE_BYTES_LIMIT,
    load_fixture, text_port,
};

#[test]
fn validate_cache_put_rejects_empty_key_invalid_scope_and_bad_value_limit() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    rule.graph.nodes.push(Node {
        id: "cache_put".to_string(),
        kind: NodeKind::CachePut,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("key".to_string(), "   ".to_string()),
            ("scope".to_string(), "global".to_string()),
            (
                "maxValueBytes".to_string(),
                (MAX_CACHE_VALUE_BYTES_LIMIT + 1).to_string(),
            ),
        ]
        .into_iter()
        .collect(),
    });
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_CACHE_KEY_REQUIRED)
    );
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_CACHE_SCOPE_INVALID)
    );
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_CACHE_VALUE_LIMIT_INVALID)
    );
}

#[test]
fn validate_cache_get_rejects_empty_key() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    rule.graph.nodes.push(Node {
        id: "cache_get".to_string(),
        kind: NodeKind::CacheGet,
        phase: LifecyclePhase::Search,
        inputs: vec![],
        outputs: vec![text_port("out")],
        params: [("scope".to_string(), "run".to_string())]
            .into_iter()
            .collect(),
    });
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_CACHE_KEY_REQUIRED)
    );
}

#[test]
fn validate_cookie_put_rejects_domain_outside_allowlist() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    rule.graph.nodes.push(Node {
        id: "cookie_put".to_string(),
        kind: NodeKind::CookiePut,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("name".to_string(), "session".to_string()),
            ("domain".to_string(), "cross-domain.example".to_string()),
        ]
        .into_iter()
        .collect(),
    });
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_COOKIE_DOMAIN_NOT_ALLOWED)
    );
}

#[test]
fn validate_cookie_put_rejects_invalid_expires() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    rule.graph.nodes.push(Node {
        id: "cookie_put".to_string(),
        kind: NodeKind::CookiePut,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("name".to_string(), "session".to_string()),
            ("expires".to_string(), "not-a-timestamp".to_string()),
        ]
        .into_iter()
        .collect(),
    });
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|d| d.code == CODE_COOKIE_EXPIRES_INVALID)
    );
}
