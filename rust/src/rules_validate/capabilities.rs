use super::{
    CODE_CAPABILITY_JS_REQUIRED, CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT,
    graph::GraphIndex,
    nodes::validate_transform_capabilities,
    types::PortDirection,
    utils::{diagnostic, normalize_param_value},
};
use crate::rules_ir::{DataType, Diagnostic, LifecyclePhase, NodeKind, RuleEnvelope};

pub(crate) fn validate_capabilities(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) {
    let capabilities = &rule.capabilities;

    if capabilities.supports_pagination {
        validate_pagination_capability(rule, graph_index, diagnostics);
    }

    validate_js_capability(rule, diagnostics);
    validate_transform_capabilities(rule, diagnostics);
}

fn validate_js_capability(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
    if rule.capabilities.supports_js {
        return;
    }

    for (node_index, node) in rule.graph.nodes.iter().enumerate() {
        if node.kind != NodeKind::Transform {
            continue;
        }
        let Some(family) = node.params.get("family") else {
            continue;
        };
        if normalize_param_value(family) != "js" {
            continue;
        }

        diagnostics.push(diagnostic(
            CODE_CAPABILITY_JS_REQUIRED,
            format!("graph.nodes[{node_index}].params.family"),
            Some(node.id.clone()),
            "使用 transform family=js 时，必须声明 capabilities.supportsJs=true".to_string(),
        ));
    }
}

fn validate_pagination_capability(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) {
    let Some(search_output) = rule.normalized_outputs.get(&LifecyclePhase::Search) else {
        diagnostics.push(diagnostic(
            CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT,
            "capabilities.supportsPagination".to_string(),
            None,
            "声明 supportsPagination=true 时，必须提供 search 阶段的标准化输出".to_string(),
        ));
        return;
    };

    let Some((port, node_entry, _)) = graph_index.port(search_output, PortDirection::Output) else {
        diagnostics.push(diagnostic(
            CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT,
            "capabilities.supportsPagination".to_string(),
            Some(search_output.node_id.clone()),
            "声明 supportsPagination=true 时，search 阶段标准化输出必须引用有效输出端口"
                .to_string(),
        ));
        return;
    };

    if !matches!(port.data_type, DataType::List { .. }) {
        diagnostics.push(diagnostic(
            CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT,
            "capabilities.supportsPagination".to_string(),
            Some(node_entry.node.id.clone()),
            "声明 supportsPagination=true 时，search 阶段标准化输出必须为列表类型".to_string(),
        ));
    }
}
