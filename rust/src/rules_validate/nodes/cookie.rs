use std::collections::BTreeSet;

use super::super::{
    CODE_COOKIE_DOMAIN_INVALID, CODE_COOKIE_DOMAIN_NOT_ALLOWED, CODE_COOKIE_EXPIRES_INVALID,
    CODE_COOKIE_NAME_REQUIRED,
    utils::{diagnostic, normalize_cookie_domain},
};
use crate::rules_ir::{Diagnostic, NodeKind, RuleEnvelope};

pub(crate) fn validate_cookie_nodes(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
    for (node_index, node) in rule.graph.nodes.iter().enumerate() {
        if !matches!(node.kind, NodeKind::CookiePut | NodeKind::CookieGet) {
            continue;
        }

        let key = node
            .params
            .get("name")
            .map(|value| value.trim())
            .unwrap_or_default();
        if key.is_empty() {
            diagnostics.push(diagnostic(
                CODE_COOKIE_NAME_REQUIRED,
                format!("graph.nodes[{node_index}].params.name"),
                Some(node.id.clone()),
                "Cookie 节点参数 name 不能为空".to_string(),
            ));
        }

        if matches!(node.kind, NodeKind::CookiePut)
            && let Some(expires) = node.params.get("expires")
        {
            match expires.trim().parse::<i64>() {
                Ok(value) if value > 0 => {}
                _ => diagnostics.push(diagnostic(
                    CODE_COOKIE_EXPIRES_INVALID,
                    format!("graph.nodes[{node_index}].params.expires"),
                    Some(node.id.clone()),
                    "CookiePut 参数 expires 必须是 Unix 秒级时间戳（整数，> 0）".to_string(),
                )),
            }
        }

        let Some(raw_domain) = node.params.get("domain") else {
            continue;
        };
        let normalized_domain = normalize_cookie_domain(raw_domain);
        if normalized_domain.is_empty() || normalized_domain == "$current" {
            continue;
        }

        if !is_valid_cookie_domain(&normalized_domain) {
            diagnostics.push(diagnostic(
                CODE_COOKIE_DOMAIN_INVALID,
                format!("graph.nodes[{node_index}].params.domain"),
                Some(node.id.clone()),
                format!("Cookie 域名 `{normalized_domain}` 非法"),
            ));
            continue;
        }

        let allowlist = parse_domain_allowlist(node.params.get("allowDomains"));
        if !allowlist.contains(normalized_domain.as_str()) {
            diagnostics.push(diagnostic(
                CODE_COOKIE_DOMAIN_NOT_ALLOWED,
                format!("graph.nodes[{node_index}].params.domain"),
                Some(node.id.clone()),
                "Cookie 跨域写入默认禁止；仅允许当前请求域（domain 省略或 $current）或 allowDomains 白名单"
                    .to_string(),
            ));
        }
    }
}

fn parse_domain_allowlist(value: Option<&String>) -> BTreeSet<String> {
    let mut allowlist = BTreeSet::new();
    if let Some(value) = value {
        for item in value.split(',') {
            let domain = normalize_cookie_domain(item);
            if !domain.is_empty() {
                allowlist.insert(domain);
            }
        }
    }

    allowlist
}

fn is_valid_cookie_domain(domain: &str) -> bool {
    if domain.is_empty() || domain.len() > 253 {
        return false;
    }
    if domain.contains(['/', ':', ' ']) {
        return false;
    }

    domain.split('.').all(|label| {
        !label.is_empty()
            && label.len() <= 63
            && !label.starts_with('-')
            && !label.ends_with('-')
            && label
                .chars()
                .all(|char| char.is_ascii_alphanumeric() || char == '-')
    })
}
