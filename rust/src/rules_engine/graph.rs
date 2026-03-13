use std::collections::{BTreeMap, HashMap};

use tokio::sync::mpsc;

use super::{EngineContext, EngineError, RuntimeValue};
use crate::rules_ir::{DataType, Node, NodeKind, PortRef, RuleEnvelope};

pub(crate) type NodeOutputs = BTreeMap<String, Vec<RuntimeValue>>;

#[derive(Debug)]
pub(crate) struct RuntimeGraph {
    pub(crate) nodes: Vec<RuntimeNode>,
}

#[derive(Debug)]
pub(crate) struct RuntimeNode {
    pub(crate) node: Node,
    pub(crate) input_receivers: HashMap<String, Vec<mpsc::Receiver<RuntimeValue>>>,
    pub(crate) output_senders: HashMap<String, Vec<mpsc::Sender<RuntimeValue>>>,
}

impl RuntimeGraph {
    pub(crate) fn build(rule: &RuleEnvelope, channel_capacity: usize) -> Self {
        let mut nodes = rule
            .graph
            .nodes
            .iter()
            .cloned()
            .map(|node| {
                (
                    node.id.clone(),
                    RuntimeNode {
                        node,
                        input_receivers: HashMap::new(),
                        output_senders: HashMap::new(),
                    },
                )
            })
            .collect::<HashMap<_, _>>();

        for edge in &rule.graph.edges {
            let (sender, receiver) = mpsc::channel(channel_capacity);
            if let Some(source) = nodes.get_mut(&edge.from.node_id) {
                source
                    .output_senders
                    .entry(edge.from.port_name.clone())
                    .or_default()
                    .push(sender);
            }
            if let Some(target) = nodes.get_mut(&edge.to.node_id) {
                target
                    .input_receivers
                    .entry(edge.to.port_name.clone())
                    .or_default()
                    .push(receiver);
            }
        }

        let ordered_nodes = rule
            .graph
            .nodes
            .iter()
            .filter_map(|node| nodes.remove(&node.id))
            .collect();

        Self {
            nodes: ordered_nodes,
        }
    }
}

pub(crate) async fn collect_inputs(
    node: &Node,
    mut input_receivers: HashMap<String, Vec<mpsc::Receiver<RuntimeValue>>>,
    context: &EngineContext,
) -> Result<NodeOutputs, EngineError> {
    if matches!(node.kind, NodeKind::Input) {
        return resolve_input_node_outputs(node, context);
    }

    let mut collected = BTreeMap::new();
    for input in &node.inputs {
        let mut values = Vec::new();
        if let Some(receivers) = input_receivers.remove(&input.name) {
            for mut receiver in receivers {
                while let Some(value) = receiver.recv().await {
                    values.push(value);
                }
            }
        }

        if values.is_empty() && !input.optional {
            return Err(EngineError::MissingInput {
                node_id: node.id.clone(),
                port_name: input.name.clone(),
            });
        }

        collected.insert(input.name.clone(), values);
    }

    Ok(collected)
}

fn resolve_input_node_outputs(
    node: &Node,
    context: &EngineContext,
) -> Result<NodeOutputs, EngineError> {
    let mut outputs = BTreeMap::new();

    for output in &node.outputs {
        let port_ref = PortRef {
            node_id: node.id.clone(),
            port_name: output.name.clone(),
        };
        let value = context
            .port_inputs
            .get(&port_ref)
            .cloned()
            .or_else(|| context.phase_inputs.get(&node.phase).cloned())
            .ok_or_else(|| EngineError::MissingInput {
                node_id: node.id.clone(),
                port_name: output.name.clone(),
            })?;

        outputs.insert(
            output.name.clone(),
            vec![coerce_to_type(value, &output.data_type)?],
        );
    }

    Ok(outputs)
}

pub(crate) fn execute_passthrough(
    node: &Node,
    inputs: &NodeOutputs,
) -> Result<NodeOutputs, EngineError> {
    let primary_input = node
        .inputs
        .iter()
        .find_map(|input| inputs.get(&input.name))
        .and_then(|values| values.last())
        .cloned()
        .ok_or_else(|| EngineError::MissingInput {
            node_id: node.id.clone(),
            port_name: node
                .inputs
                .first()
                .map(|port| port.name.clone())
                .unwrap_or_else(|| "input".to_string()),
        })?;

    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        outputs.insert(output.name.clone(), vec![primary_input.clone()]);
    }
    Ok(outputs)
}

pub(crate) fn execute_join(node: &Node, inputs: &NodeOutputs) -> Result<NodeOutputs, EngineError> {
    let mut collected = Vec::new();
    for input in &node.inputs {
        if let Some(values) = inputs.get(&input.name) {
            collected.extend(values.iter().cloned());
        }
    }

    if collected.is_empty() {
        return Err(EngineError::JoinWithoutInputs {
            node_id: node.id.clone(),
        });
    }

    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        let value = match &output.data_type {
            DataType::List { .. } => RuntimeValue::List(collected.clone()),
            _ => collected
                .last()
                .cloned()
                .ok_or_else(|| EngineError::JoinWithoutInputs {
                    node_id: node.id.clone(),
                })?,
        };
        outputs.insert(output.name.clone(), vec![value]);
    }

    Ok(outputs)
}

pub(crate) fn collapse_values(values: &[RuntimeValue]) -> RuntimeValue {
    if values.len() == 1 {
        values[0].clone()
    } else {
        RuntimeValue::List(values.to_vec())
    }
}

fn coerce_to_type(value: RuntimeValue, data_type: &DataType) -> Result<RuntimeValue, EngineError> {
    coerce_to_type_for_port("runtime", "runtime", value, data_type)
}

pub(crate) fn coerce_to_type_for_port(
    node_id: &str,
    port_name: &str,
    value: RuntimeValue,
    data_type: &DataType,
) -> Result<RuntimeValue, EngineError> {
    if value.matches_type(data_type) {
        return Ok(value);
    }

    match data_type {
        DataType::List { item } if value.matches_type(item) => Ok(RuntimeValue::List(vec![value])),
        _ => Err(EngineError::TypeMismatch {
            node_id: node_id.to_string(),
            port_name: port_name.to_string(),
            expected: data_type_label(data_type),
            actual: value.type_label().to_string(),
        }),
    }
}

fn data_type_label(data_type: &DataType) -> String {
    match data_type {
        DataType::Text => "text".to_string(),
        DataType::Html => "html".to_string(),
        DataType::Json => "json".to_string(),
        DataType::Url => "url".to_string(),
        DataType::List { item } => format!("list<{}>", data_type_label(item)),
        DataType::Record { fields } => format!("record({})", fields.len()),
        DataType::NormalizedModel => "normalizedModel".to_string(),
    }
}
