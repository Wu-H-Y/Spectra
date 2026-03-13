#![allow(dead_code)]

use spectra_native::rules_ir::{DataType, LifecyclePhase, Node, NodeKind, Port, RuleEnvelope};

pub const CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT: &str =
    "CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT";
pub const CODE_DUPLICATE_NODE_ID: &str = "DUPLICATE_NODE_ID";
pub const CODE_GRAPH_CYCLE: &str = "GRAPH_CYCLE";
pub const CODE_TYPE_MISMATCH: &str = "TYPE_MISMATCH";
pub const CODE_UNKNOWN_NODE: &str = "UNKNOWN_NODE";
pub const CODE_CACHE_KEY_REQUIRED: &str = "CACHE_KEY_REQUIRED";
pub const CODE_CACHE_SCOPE_INVALID: &str = "CACHE_SCOPE_INVALID";
pub const CODE_CACHE_VALUE_LIMIT_INVALID: &str = "CACHE_VALUE_LIMIT_INVALID";
pub const CODE_COOKIE_DOMAIN_NOT_ALLOWED: &str = "COOKIE_DOMAIN_NOT_ALLOWED";
pub const CODE_COOKIE_EXPIRES_INVALID: &str = "COOKIE_EXPIRES_INVALID";
pub const CODE_CAPABILITY_CODEC_REQUIRED: &str = "CAPABILITY_CODEC_REQUIRED";
pub const CODE_CAPABILITY_CRYPTO_AES_REQUIRED: &str = "CAPABILITY_CRYPTO_AES_REQUIRED";
pub const CODE_CAPABILITY_JS_REQUIRED: &str = "CAPABILITY_JS_REQUIRED";
pub const CODE_INLINE_SECRET_NOT_ALLOWED: &str = "INLINE_SECRET_NOT_ALLOWED";
pub const CODE_INVALID_KEY_REF: &str = "INVALID_KEY_REF";
pub const MAX_CACHE_VALUE_BYTES_LIMIT: usize = 262_144;

pub fn text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Text,
        optional: false,
    }
}

pub fn append_js_transform_node(rule: &mut RuleEnvelope) {
    rule.graph.nodes.push(Node {
        id: "js_transform".to_string(),
        kind: NodeKind::Transform,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("family".to_string(), "js".to_string()),
            (
                "script".to_string(),
                "return input.toLowerCase();".to_string(),
            ),
        ]
        .into_iter()
        .collect(),
    });
}

pub fn append_codec_transform_node(rule: &mut RuleEnvelope) {
    rule.graph.nodes.push(Node {
        id: "codec_transform".to_string(),
        kind: NodeKind::Transform,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("family".to_string(), "codec".to_string()),
            ("op".to_string(), "base64Encode".to_string()),
        ]
        .into_iter()
        .collect(),
    });
}

pub fn append_crypto_transform_with_inline_secret_node(rule: &mut RuleEnvelope) {
    rule.graph.nodes.push(Node {
        id: "crypto_transform".to_string(),
        kind: NodeKind::Transform,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("family".to_string(), "crypto".to_string()),
            ("op".to_string(), "aesEncode".to_string()),
            (
                "transformation".to_string(),
                "AES/CBC/PKCS7Padding".to_string(),
            ),
            ("key".to_string(), "1234567890abcdef".to_string()),
            ("iv".to_string(), "fedcba0987654321".to_string()),
        ]
        .into_iter()
        .collect(),
    });
}

pub fn append_crypto_transform_with_key_ref_node(rule: &mut RuleEnvelope) {
    rule.graph.nodes.push(Node {
        id: "crypto_ref_transform".to_string(),
        kind: NodeKind::Transform,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: [
            ("family".to_string(), "crypto".to_string()),
            ("op".to_string(), "aesEncode".to_string()),
            (
                "transformation".to_string(),
                "AES/CBC/PKCS7Padding".to_string(),
            ),
            (
                "keyRef".to_string(),
                r#"{"provider":"variable","name":"SPECTRA_AES_KEY"}"#.to_string(),
            ),
            (
                "ivRef".to_string(),
                r#"{"provider":"variable","name":"SPECTRA_AES_IV"}"#.to_string(),
            ),
        ]
        .into_iter()
        .collect(),
    });
}

pub fn load_fixture(path: &str) -> RuleEnvelope {
    serde_json::from_str(path).expect("fixture 应该可成功反序列化")
}
