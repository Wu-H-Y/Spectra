use super::{
    CODE_INVALID_EDGE_PHASE_ORDER, CODE_TYPE_MISMATCH, CODE_UNKNOWN_NODE, CODE_UNKNOWN_PORT,
    graph::{GraphIndex, NodeEntry},
    types::PortDirection,
    utils::{data_type_compatible, data_type_label, diagnostic, port_direction_label},
};
use crate::rules_ir::{Diagnostic, Port, PortRef, RuleEnvelope};

pub(crate) fn validate_edges(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) -> Vec<(String, String)> {
    let mut valid_edges = Vec::new();

    for (edge_index, edge) in rule.graph.edges.iter().enumerate() {
        let Some((from_port, from_node, _)) = validate_port_reference(
            graph_index,
            &edge.from,
            PortDirection::Output,
            &format!("graph.edges[{edge_index}].from"),
            CODE_UNKNOWN_PORT,
            diagnostics,
        ) else {
            continue;
        };

        let Some((to_port, to_node, _)) = validate_port_reference(
            graph_index,
            &edge.to,
            PortDirection::Input,
            &format!("graph.edges[{edge_index}].to"),
            CODE_UNKNOWN_PORT,
            diagnostics,
        ) else {
            continue;
        };

        if from_node.node.phase > to_node.node.phase {
            diagnostics.push(diagnostic(
                CODE_INVALID_EDGE_PHASE_ORDER,
                format!("graph.edges[{edge_index}]"),
                Some(to_node.node.id.clone()),
                format!(
                    "边 `{}` -> `{}` 违反阶段顺序：`{:?}` 不能指向更早阶段 `{:?}`",
                    from_node.node.id, to_node.node.id, from_node.node.phase, to_node.node.phase,
                ),
            ));
        }

        if !data_type_compatible(&from_port.data_type, &to_port.data_type) {
            diagnostics.push(diagnostic(
                CODE_TYPE_MISMATCH,
                format!("graph.edges[{edge_index}]"),
                Some(to_node.node.id.clone()),
                format!(
                    "边 `{}`.{} -> `{}`.{} 的数据类型不兼容：上游为 `{}`，下游需要 `{}`",
                    from_node.node.id,
                    from_port.name,
                    to_node.node.id,
                    to_port.name,
                    data_type_label(&from_port.data_type),
                    data_type_label(&to_port.data_type),
                ),
            ));
        }

        valid_edges.push((edge.from.node_id.clone(), edge.to.node_id.clone()));
    }

    valid_edges
}

pub(crate) fn validate_port_reference<'a>(
    graph_index: &'a GraphIndex<'a>,
    port_ref: &PortRef,
    direction: PortDirection,
    path_prefix: &str,
    missing_port_code: &str,
    diagnostics: &mut Vec<Diagnostic>,
) -> Option<(&'a Port, NodeEntry<'a>, usize)> {
    let node_entry = match graph_index.node(&port_ref.node_id) {
        Some(node_entry) => node_entry,
        None => {
            diagnostics.push(diagnostic(
                CODE_UNKNOWN_NODE,
                format!("{path_prefix}.nodeId"),
                Some(port_ref.node_id.clone()),
                format!("引用了不存在的节点 `{}`", port_ref.node_id),
            ));
            return None;
        }
    };

    let ports = match direction {
        PortDirection::Input => &node_entry.node.inputs,
        PortDirection::Output => &node_entry.node.outputs,
    };

    match ports
        .iter()
        .enumerate()
        .find(|(_, port)| port.name == port_ref.port_name)
    {
        Some((index, port)) => Some((port, node_entry, index)),
        None => {
            diagnostics.push(diagnostic(
                missing_port_code,
                format!("{path_prefix}.portName"),
                Some(node_entry.node.id.clone()),
                format!(
                    "节点 `{}` 不存在{}端口 `{}`",
                    node_entry.node.id,
                    port_direction_label(direction),
                    port_ref.port_name,
                ),
            ));
            None
        }
    }
}
