use super::super::{
    CODE_CAPABILITY_CODEC_REQUIRED, CODE_CAPABILITY_CRYPTO_AES_REQUIRED,
    CODE_CRYPTO_PARAM_REQUIRED, CODE_INLINE_SECRET_NOT_ALLOWED, CODE_INVALID_KEY_REF,
    utils::{diagnostic, normalize_param_value},
};
use crate::rules_ir::{Diagnostic, KeyRef, KeyRefProvider, Node, NodeKind, RuleEnvelope};

pub(crate) fn validate_transform_capabilities(
    rule: &RuleEnvelope,
    diagnostics: &mut Vec<Diagnostic>,
) {
    for (node_index, node) in rule.graph.nodes.iter().enumerate() {
        if node.kind != NodeKind::Transform {
            continue;
        }

        let Some(family) = node.params.get("family") else {
            continue;
        };
        let family = normalize_param_value(family);

        match family.as_str() {
            "codec" => {
                if !rule.capabilities.codec {
                    diagnostics.push(diagnostic(
                        CODE_CAPABILITY_CODEC_REQUIRED,
                        format!("graph.nodes[{node_index}].params.family"),
                        Some(node.id.clone()),
                        "使用 transform family=codec 时，必须声明 capabilities.codec=true"
                            .to_string(),
                    ));
                }
            }
            "crypto" => {
                if !rule.capabilities.crypto.aes {
                    diagnostics.push(diagnostic(
                        CODE_CAPABILITY_CRYPTO_AES_REQUIRED,
                        format!("graph.nodes[{node_index}].params.family"),
                        Some(node.id.clone()),
                        "使用 transform family=crypto（AES）时，必须声明 capabilities.crypto.aes=true"
                            .to_string(),
                    ));
                }

                if rule.capabilities.allow_inline_secrets {
                    validate_crypto_key_refs(node, node_index, diagnostics);
                    validate_crypto_required_params(node, node_index, diagnostics);
                    continue;
                }

                if has_inline_secret_param(node, "key") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.key"),
                        Some(node.id.clone()),
                        "默认禁止内联密钥；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_key_ref(node, "keyRef") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.keyRef"),
                        Some(node.id.clone()),
                        "默认禁止内联密钥引用（provider=inline）；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_param(node, "iv") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.iv"),
                        Some(node.id.clone()),
                        "默认禁止内联 IV；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_key_ref(node, "ivRef") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.ivRef"),
                        Some(node.id.clone()),
                        "默认禁止内联 IV 引用（provider=inline）；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                validate_crypto_key_refs(node, node_index, diagnostics);
                validate_crypto_required_params(node, node_index, diagnostics);
            }
            _ => {}
        }
    }
}

fn validate_crypto_required_params(
    node: &Node,
    node_index: usize,
    diagnostics: &mut Vec<Diagnostic>,
) {
    let op = node
        .params
        .get("op")
        .map(|value| normalize_param_value(value))
        .unwrap_or_default();
    let transformation = node
        .params
        .get("transformation")
        .map(|value| normalize_param_value(value).replace([' ', '_'], ""));

    if !has_inline_secret_param(node, "key") && !has_inline_secret_param(node, "keyRef") {
        diagnostics.push(diagnostic(
            CODE_CRYPTO_PARAM_REQUIRED,
            format!("graph.nodes[{node_index}].params.key"),
            Some(node.id.clone()),
            "crypto 节点必须提供 key 或 keyRef".to_string(),
        ));
    }

    let requires_iv = matches!(op.as_str(), "aescbcencode" | "aescbcdecode")
        || matches!(
            transformation.as_deref(),
            Some("aes/cbc/pkcs7padding") | Some("aes/cbc/pkcs7")
        );

    if requires_iv
        && !has_inline_secret_param(node, "iv")
        && !has_inline_secret_param(node, "ivRef")
    {
        diagnostics.push(diagnostic(
            CODE_CRYPTO_PARAM_REQUIRED,
            format!("graph.nodes[{node_index}].params.iv"),
            Some(node.id.clone()),
            "CBC 模式必须提供 iv 或 ivRef".to_string(),
        ));
    }
}

fn validate_crypto_key_refs(node: &Node, node_index: usize, diagnostics: &mut Vec<Diagnostic>) {
    for (param_name, path_key) in [("keyRef", "keyRef"), ("ivRef", "ivRef")] {
        let Some(raw_value) = node.params.get(param_name) else {
            continue;
        };
        let trimmed = raw_value.trim();
        if trimmed.is_empty() {
            continue;
        }

        let parsed = serde_json::from_str::<KeyRef>(trimmed);
        let key_ref = match parsed {
            Ok(value) => value,
            Err(error) => {
                diagnostics.push(diagnostic(
                    CODE_INVALID_KEY_REF,
                    format!("graph.nodes[{node_index}].params.{path_key}"),
                    Some(node.id.clone()),
                    format!("{param_name} 必须是合法 KeyRef JSON：{error}"),
                ));
                continue;
            }
        };

        match key_ref.provider {
            KeyRefProvider::Inline => {
                if key_ref
                    .value
                    .as_deref()
                    .unwrap_or_default()
                    .trim()
                    .is_empty()
                {
                    diagnostics.push(diagnostic(
                        CODE_INVALID_KEY_REF,
                        format!("graph.nodes[{node_index}].params.{path_key}"),
                        Some(node.id.clone()),
                        format!("{param_name} provider=inline 时必须提供非空 value"),
                    ));
                }
            }
            KeyRefProvider::Variable => {
                if key_ref
                    .name
                    .as_deref()
                    .unwrap_or_default()
                    .trim()
                    .is_empty()
                {
                    diagnostics.push(diagnostic(
                        CODE_INVALID_KEY_REF,
                        format!("graph.nodes[{node_index}].params.{path_key}"),
                        Some(node.id.clone()),
                        format!("{param_name} provider=variable 时必须提供非空 name"),
                    ));
                }
            }
            KeyRefProvider::SecureStore => {
                diagnostics.push(diagnostic(
                    CODE_INVALID_KEY_REF,
                    format!("graph.nodes[{node_index}].params.{path_key}"),
                    Some(node.id.clone()),
                    "provider=secureStore 尚未接入实际适配器，请先配置 secure-store 运行时后再使用"
                        .to_string(),
                ));
            }
        }
    }
}

fn has_inline_secret_param(node: &Node, key: &str) -> bool {
    node.params
        .get(key)
        .map(|value| !value.trim().is_empty())
        .unwrap_or(false)
}

fn has_inline_secret_key_ref(node: &Node, key: &str) -> bool {
    let Some(raw_ref) = node.params.get(key) else {
        return false;
    };

    serde_json::from_str::<KeyRef>(raw_ref)
        .map(|value| {
            matches!(value.provider, KeyRefProvider::Inline)
                && !value.value.as_deref().unwrap_or_default().trim().is_empty()
        })
        .unwrap_or(false)
}
