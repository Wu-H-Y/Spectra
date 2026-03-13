use std::collections::{BTreeSet, HashMap};

use super::{
    CODE_DUPLICATE_INPUT_PORT, CODE_DUPLICATE_NODE_ID, CODE_DUPLICATE_OUTPUT_PORT,
    types::PortDirection, utils::diagnostic,
};
use crate::rules_ir::{Diagnostic, Node, Port, PortRef, RuleEnvelope};

#[derive(Clone, Copy)]
pub(crate) struct NodeEntry<'a> {
    pub(crate) node: &'a Node,
}

pub(crate) struct GraphIndex<'a> {
    pub(crate) nodes: HashMap<&'a str, NodeEntry<'a>>,
}

impl<'a> GraphIndex<'a> {
    pub(crate) fn build(rule: &'a RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) -> Self {
        let mut nodes = HashMap::new();

        for (node_index, node) in rule.graph.nodes.iter().enumerate() {
            if nodes.contains_key(node.id.as_str()) {
                diagnostics.push(diagnostic(
                    CODE_DUPLICATE_NODE_ID,
                    format!("graph.nodes[{node_index}].id"),
                    Some(node.id.clone()),
                    format!("节点 ID `{}` 重复定义", node.id),
                ));
                continue;
            }

            validate_duplicate_ports(node, node_index, diagnostics);
            nodes.insert(node.id.as_str(), NodeEntry { node });
        }

        Self { nodes }
    }

    pub(crate) fn node(&self, node_id: &str) -> Option<NodeEntry<'a>> {
        self.nodes.get(node_id).copied()
    }

    pub(crate) fn port(
        &self,
        port_ref: &PortRef,
        direction: PortDirection,
    ) -> Option<(&'a Port, NodeEntry<'a>, usize)> {
        let node_entry = self.node(&port_ref.node_id)?;
        let ports = match direction {
            PortDirection::Input => &node_entry.node.inputs,
            PortDirection::Output => &node_entry.node.outputs,
        };

        ports
            .iter()
            .enumerate()
            .find(|(_, port)| port.name == port_ref.port_name)
            .map(|(index, port)| (port, node_entry, index))
    }
}

fn validate_duplicate_ports(node: &Node, node_index: usize, diagnostics: &mut Vec<Diagnostic>) {
    let mut input_names = BTreeSet::new();
    for (port_index, port) in node.inputs.iter().enumerate() {
        if !input_names.insert(port.name.as_str()) {
            diagnostics.push(diagnostic(
                CODE_DUPLICATE_INPUT_PORT,
                format!("graph.nodes[{node_index}].inputs[{port_index}].name"),
                Some(node.id.clone()),
                format!("节点 `{}` 的输入端口 `{}` 重复定义", node.id, port.name),
            ));
        }
    }

    let mut output_names = BTreeSet::new();
    for (port_index, port) in node.outputs.iter().enumerate() {
        if !output_names.insert(port.name.as_str()) {
            diagnostics.push(diagnostic(
                CODE_DUPLICATE_OUTPUT_PORT,
                format!("graph.nodes[{node_index}].outputs[{port_index}].name"),
                Some(node.id.clone()),
                format!("节点 `{}` 的输出端口 `{}` 重复定义", node.id, port.name),
            ));
        }
    }
}
