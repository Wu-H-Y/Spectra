use spectra_native::rules_validate::validate_rule;

mod rules_validate_support;

use rules_validate_support::{
    CODE_CAPABILITY_CODEC_REQUIRED, CODE_CAPABILITY_CRYPTO_AES_REQUIRED,
    CODE_CAPABILITY_JS_REQUIRED, CODE_INLINE_SECRET_NOT_ALLOWED, CODE_INVALID_KEY_REF,
    append_codec_transform_node, append_crypto_transform_with_inline_secret_node,
    append_crypto_transform_with_key_ref_node, append_js_transform_node, load_fixture,
};

#[test]
fn validate_js_transform_requires_js_capability() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_js_transform_node(&mut rule);
    rule.capabilities.supports_js = false;
    let diagnostics = validate_rule(&rule);
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_CAPABILITY_JS_REQUIRED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
            && diagnostic.node_id.as_deref() == Some("js_transform")
    }));
}

#[test]
fn validate_js_transform_passes_when_js_capability_enabled() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_js_transform_node(&mut rule);
    rule.capabilities.supports_js = true;
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_CAPABILITY_JS_REQUIRED)
    );
}

#[test]
fn validate_codec_transform_requires_codec_capability() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_codec_transform_node(&mut rule);
    rule.capabilities.codec = false;
    let diagnostics = validate_rule(&rule);
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_CAPABILITY_CODEC_REQUIRED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
            && diagnostic.node_id.as_deref() == Some("codec_transform")
    }));
}

#[test]
fn validate_crypto_transform_requires_aes_capability_and_rejects_inline_secret_by_default() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_inline_secret_node(&mut rule);
    rule.capabilities.crypto.aes = false;
    rule.capabilities.allow_inline_secrets = false;
    let diagnostics = validate_rule(&rule);
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_CAPABILITY_CRYPTO_AES_REQUIRED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
            && diagnostic.node_id.as_deref() == Some("crypto_transform")
    }));
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.key")
            && diagnostic.node_id.as_deref() == Some("crypto_transform")
    }));
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.iv")
            && diagnostic.node_id.as_deref() == Some("crypto_transform")
    }));
}

#[test]
fn validate_crypto_transform_allows_inline_secret_when_capability_enabled() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_inline_secret_node(&mut rule);
    rule.capabilities.crypto.aes = true;
    rule.capabilities.allow_inline_secrets = true;
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_INLINE_SECRET_NOT_ALLOWED)
    );
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_CAPABILITY_CRYPTO_AES_REQUIRED)
    );
}

#[test]
fn validate_crypto_transform_key_ref_is_accepted_when_inline_secret_disabled() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_key_ref_node(&mut rule);
    rule.capabilities.crypto.aes = true;
    rule.capabilities.allow_inline_secrets = false;
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_INLINE_SECRET_NOT_ALLOWED)
    );
    assert!(
        diagnostics
            .iter()
            .all(|diagnostic| diagnostic.code != CODE_INVALID_KEY_REF)
    );
}

#[test]
fn validate_crypto_transform_rejects_invalid_or_unsupported_key_ref() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_key_ref_node(&mut rule);
    rule.capabilities.crypto.aes = true;
    rule.capabilities.allow_inline_secrets = false;
    let target = rule
        .graph
        .nodes
        .iter_mut()
        .find(|node| node.id == "crypto_ref_transform")
        .expect("应存在 crypto_ref_transform");
    target.params.insert(
        "keyRef".to_string(),
        r#"{"provider":"secureStore","name":""}"#.to_string(),
    );
    target
        .params
        .insert("ivRef".to_string(), "{not-json".to_string());
    let diagnostics = validate_rule(&rule);
    assert!(
        diagnostics
            .iter()
            .any(|diagnostic| diagnostic.code == CODE_INVALID_KEY_REF)
    );
}

#[test]
fn validate_crypto_transform_rejects_inline_key_ref_when_inline_secret_disabled() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_key_ref_node(&mut rule);
    rule.capabilities.crypto.aes = true;
    rule.capabilities.allow_inline_secrets = false;
    let target = rule
        .graph
        .nodes
        .iter_mut()
        .find(|node| node.id == "crypto_ref_transform")
        .expect("应存在 crypto_ref_transform");
    target.params.insert(
        "keyRef".to_string(),
        r#"{"provider":"inline","value":"1234567890abcdef"}"#.to_string(),
    );
    let diagnostics = validate_rule(&rule);
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.keyRef")
    }));
}

#[test]
fn validate_crypto_transform_rejects_secure_store_key_ref_until_runtime_support_lands() {
    let mut rule = load_fixture(include_str!(concat!(
        env!("CARGO_MANIFEST_DIR"),
        "/../fixtures/ir_v1_min.json"
    )));
    append_crypto_transform_with_key_ref_node(&mut rule);
    rule.capabilities.crypto.aes = true;
    rule.capabilities.allow_inline_secrets = false;
    let target = rule
        .graph
        .nodes
        .iter_mut()
        .find(|node| node.id == "crypto_ref_transform")
        .expect("应存在 crypto_ref_transform");
    target.params.insert(
        "keyRef".to_string(),
        r#"{"provider":"secureStore","name":"vault/aes/key"}"#.to_string(),
    );
    target.params.insert(
        "ivRef".to_string(),
        r#"{"provider":"secureStore","name":"vault/aes/iv"}"#.to_string(),
    );
    let diagnostics = validate_rule(&rule);
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_INVALID_KEY_REF
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.keyRef")
    }));
    assert!(diagnostics.iter().any(|diagnostic| {
        diagnostic.code == CODE_INVALID_KEY_REF
            && diagnostic.path.as_deref() == Some("graph.nodes[2].params.ivRef")
    }));
}
