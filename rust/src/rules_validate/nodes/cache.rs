use super::super::{
    CODE_CACHE_KEY_REQUIRED, CODE_CACHE_SCOPE_INVALID, CODE_CACHE_VALUE_LIMIT_INVALID,
    MAX_CACHE_VALUE_BYTES_LIMIT,
    utils::{diagnostic, normalize_param_value},
};
use crate::rules_ir::{Diagnostic, NodeKind, RuleEnvelope};

pub(crate) fn validate_cache_nodes(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
    for (node_index, node) in rule.graph.nodes.iter().enumerate() {
        if !matches!(node.kind, NodeKind::CacheGet | NodeKind::CachePut) {
            continue;
        }

        let key = node
            .params
            .get("key")
            .map(|value| value.trim())
            .unwrap_or_default();
        if key.is_empty() {
            diagnostics.push(diagnostic(
                CODE_CACHE_KEY_REQUIRED,
                format!("graph.nodes[{node_index}].params.key"),
                Some(node.id.clone()),
                "Cache 节点参数 key 不能为空".to_string(),
            ));
        }

        let scope = node
            .params
            .get("scope")
            .map(|value| normalize_param_value(value))
            .unwrap_or_else(|| "run".to_string());
        if scope != "run" && scope != "rule" {
            diagnostics.push(diagnostic(
                CODE_CACHE_SCOPE_INVALID,
                format!("graph.nodes[{node_index}].params.scope"),
                Some(node.id.clone()),
                "Cache 节点参数 scope 仅支持 run 或 rule".to_string(),
            ));
        }

        if matches!(node.kind, NodeKind::CachePut)
            && let Some(limit) = node.params.get("maxValueBytes")
        {
            match limit.trim().parse::<usize>() {
                Ok(parsed) if parsed > 0 && parsed <= MAX_CACHE_VALUE_BYTES_LIMIT => {}
                _ => diagnostics.push(diagnostic(
                    CODE_CACHE_VALUE_LIMIT_INVALID,
                    format!("graph.nodes[{node_index}].params.maxValueBytes"),
                    Some(node.id.clone()),
                    format!(
                        "CachePut 参数 maxValueBytes 必须为 1..={MAX_CACHE_VALUE_BYTES_LIMIT} 的整数"
                    ),
                )),
            }
        }
    }
}
