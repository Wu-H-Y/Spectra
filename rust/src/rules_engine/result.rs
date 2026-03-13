use std::collections::{BTreeMap, HashMap};

use super::{EngineError, RuntimeValue, graph::collapse_values};
use crate::rules_ir::{LifecyclePhase, PortRef, RuleEnvelope};

pub(crate) fn resolve_phase_results(
    rule: &RuleEnvelope,
    output_store: &HashMap<PortRef, Vec<RuntimeValue>>,
) -> Result<BTreeMap<LifecyclePhase, RuntimeValue>, EngineError> {
    let mut results = BTreeMap::new();

    for (phase, port_ref) in &rule.normalized_outputs {
        let values = output_store
            .get(port_ref)
            .ok_or(EngineError::MissingFinalResult)?;
        results.insert(*phase, collapse_values(values));
    }

    Ok(results)
}

pub(crate) fn resolve_final_result(
    rule: &RuleEnvelope,
    phase_results: &BTreeMap<LifecyclePhase, RuntimeValue>,
    output_store: &HashMap<PortRef, Vec<RuntimeValue>>,
) -> Result<Option<RuntimeValue>, EngineError> {
    if let Some((_, value)) = phase_results.iter().next_back() {
        return Ok(Some(value.clone()));
    }

    let Some(last_node) = rule.graph.nodes.last() else {
        return Ok(None);
    };
    let Some(last_port) = last_node.outputs.first() else {
        return Ok(None);
    };
    let port_ref = PortRef {
        node_id: last_node.id.clone(),
        port_name: last_port.name.clone(),
    };
    let values = output_store
        .get(&port_ref)
        .ok_or(EngineError::MissingFinalResult)?;
    Ok(Some(collapse_values(values)))
}
