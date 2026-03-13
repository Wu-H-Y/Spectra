use super::{
    CODE_INVALID_NORMALIZED_OUTPUT, CODE_INVALID_PHASE_ENTRYPOINT,
    edges::validate_port_reference,
    graph::GraphIndex,
    types::PortDirection,
    utils::{diagnostic, is_normalized_output_type, phase_key},
};
use crate::rules_ir::{Diagnostic, RuleEnvelope};

pub(crate) fn validate_phase_entrypoints(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) {
    for (phase, port_ref) in &rule.graph.phase_entrypoints {
        let path = format!("graph.phaseEntrypoints.{}", phase_key(*phase));
        validate_port_reference(
            graph_index,
            port_ref,
            PortDirection::Output,
            &path,
            CODE_INVALID_PHASE_ENTRYPOINT,
            diagnostics,
        );
    }
}

pub(crate) fn validate_normalized_outputs(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) {
    for (phase, port_ref) in &rule.normalized_outputs {
        let path = format!("normalizedOutputs.{}", phase_key(*phase));
        let Some((port, node_entry, _)) = validate_port_reference(
            graph_index,
            port_ref,
            PortDirection::Output,
            &path,
            CODE_INVALID_NORMALIZED_OUTPUT,
            diagnostics,
        ) else {
            continue;
        };

        if !is_normalized_output_type(&port.data_type) {
            diagnostics.push(diagnostic(
                CODE_INVALID_NORMALIZED_OUTPUT,
                path,
                Some(node_entry.node.id.clone()),
                format!(
                    "阶段 `{}` 的标准化输出端口 `{}` 类型无效，必须为 normalizedModel 或 list<normalizedModel>",
                    phase_key(*phase),
                    port.name,
                ),
            ));
        }
    }
}
