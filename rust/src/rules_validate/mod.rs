use std::collections::{BTreeMap, BTreeSet, HashMap, VecDeque};

use crate::rules_ir::{
    DataType, Diagnostic, DiagnosticSeverity, LifecyclePhase, Node, Port, PortRef, RuleEnvelope,
};

const CODE_DUPLICATE_NODE_ID: &str = "DUPLICATE_NODE_ID";
const CODE_DUPLICATE_INPUT_PORT: &str = "DUPLICATE_INPUT_PORT";
const CODE_DUPLICATE_OUTPUT_PORT: &str = "DUPLICATE_OUTPUT_PORT";
const CODE_UNKNOWN_NODE: &str = "UNKNOWN_NODE";
const CODE_UNKNOWN_PORT: &str = "UNKNOWN_PORT";
const CODE_INVALID_EDGE_PHASE_ORDER: &str = "INVALID_EDGE_PHASE_ORDER";
const CODE_TYPE_MISMATCH: &str = "TYPE_MISMATCH";
const CODE_GRAPH_CYCLE: &str = "GRAPH_CYCLE";
const CODE_INVALID_PHASE_ENTRYPOINT: &str = "INVALID_PHASE_ENTRYPOINT";
const CODE_INVALID_NORMALIZED_OUTPUT: &str = "INVALID_NORMALIZED_OUTPUT";
const CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT: &str =
    "CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT";

#[derive(Clone, Copy)]
enum PortDirection {
    Input,
    Output,
}

#[derive(Clone, Copy)]
struct NodeEntry<'a> {
    node: &'a Node,
}

struct GraphIndex<'a> {
    nodes: HashMap<&'a str, NodeEntry<'a>>,
}

/// 校验规则 IR 并返回结构化诊断。
pub fn validate_rule(rule: &RuleEnvelope) -> Vec<Diagnostic> {
    let mut diagnostics = Vec::new();
    let graph_index = GraphIndex::build(rule, &mut diagnostics);

    validate_phase_entrypoints(rule, &graph_index, &mut diagnostics);
    validate_normalized_outputs(rule, &graph_index, &mut diagnostics);
    let valid_edges = validate_edges(rule, &graph_index, &mut diagnostics);
    validate_topology(&graph_index, &valid_edges, &mut diagnostics);
    validate_capabilities(rule, &graph_index, &mut diagnostics);

    diagnostics
}

impl<'a> GraphIndex<'a> {
    fn build(rule: &'a RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) -> Self {
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

    fn node(&self, node_id: &str) -> Option<NodeEntry<'a>> {
        self.nodes.get(node_id).copied()
    }

    fn port(
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

fn validate_phase_entrypoints(
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

fn validate_normalized_outputs(
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

fn validate_edges(
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

fn validate_topology(
    graph_index: &GraphIndex<'_>,
    valid_edges: &[(String, String)],
    diagnostics: &mut Vec<Diagnostic>,
) {
    let mut indegree: BTreeMap<&str, usize> = graph_index
        .nodes
        .keys()
        .copied()
        .map(|node_id| (node_id, 0_usize))
        .collect();
    let mut adjacency: BTreeMap<&str, Vec<&str>> = graph_index
        .nodes
        .keys()
        .copied()
        .map(|node_id| (node_id, Vec::new()))
        .collect();

    for (from, to) in valid_edges {
        if let Some(edges) = adjacency.get_mut(from.as_str()) {
            edges.push(to.as_str());
        }

        if let Some(degree) = indegree.get_mut(to.as_str()) {
            *degree += 1;
        }
    }

    let mut queue = VecDeque::new();
    for (node_id, degree) in &indegree {
        if *degree == 0 {
            queue.push_back(*node_id);
        }
    }

    let mut visited_count = 0_usize;
    while let Some(node_id) = queue.pop_front() {
        visited_count += 1;

        if let Some(next_nodes) = adjacency.get(node_id) {
            for next_node in next_nodes {
                if let Some(degree) = indegree.get_mut(next_node) {
                    *degree -= 1;
                    if *degree == 0 {
                        queue.push_back(*next_node);
                    }
                }
            }
        }
    }

    if visited_count == graph_index.nodes.len() {
        return;
    }

    let cycle_nodes = find_cycle_nodes(graph_index, valid_edges);
    let cycle_path = cycle_nodes.join(" -> ");
    let node_id = cycle_nodes.first().cloned();
    diagnostics.push(diagnostic(
        CODE_GRAPH_CYCLE,
        "graph.edges".to_string(),
        node_id,
        format!("规则图存在环路，涉及节点：{cycle_path}"),
    ));
}

fn find_cycle_nodes(graph_index: &GraphIndex<'_>, valid_edges: &[(String, String)]) -> Vec<String> {
    let mut adjacency: BTreeMap<&str, Vec<&str>> = graph_index
        .nodes
        .keys()
        .copied()
        .map(|node_id| (node_id, Vec::new()))
        .collect();

    for (from, to) in valid_edges {
        if let Some(next_nodes) = adjacency.get_mut(from.as_str()) {
            next_nodes.push(to.as_str());
        }
    }

    let mut visited = BTreeSet::new();
    let mut stack = Vec::new();
    let mut stack_index = BTreeMap::new();

    for node_id in adjacency.keys().copied() {
        if let Some(cycle) = dfs_cycle(
            node_id,
            &adjacency,
            &mut visited,
            &mut stack,
            &mut stack_index,
        ) {
            return cycle;
        }
    }

    Vec::new()
}

fn dfs_cycle(
    node_id: &str,
    adjacency: &BTreeMap<&str, Vec<&str>>,
    visited: &mut BTreeSet<String>,
    stack: &mut Vec<String>,
    stack_index: &mut BTreeMap<String, usize>,
) -> Option<Vec<String>> {
    if let Some(index) = stack_index.get(node_id).copied() {
        let mut cycle = stack[index..].to_vec();
        cycle.push(node_id.to_string());
        return Some(cycle);
    }

    if !visited.insert(node_id.to_string()) {
        return None;
    }

    stack.push(node_id.to_string());
    stack_index.insert(node_id.to_string(), stack.len() - 1);

    if let Some(next_nodes) = adjacency.get(node_id) {
        for next_node in next_nodes {
            if let Some(cycle) = dfs_cycle(next_node, adjacency, visited, stack, stack_index) {
                return Some(cycle);
            }
        }
    }

    stack.pop();
    stack_index.remove(node_id);
    None
}

fn validate_capabilities(
    rule: &RuleEnvelope,
    graph_index: &GraphIndex<'_>,
    diagnostics: &mut Vec<Diagnostic>,
) {
    let capabilities = &rule.capabilities;

    if capabilities.supports_pagination {
        validate_pagination_capability(rule, graph_index, diagnostics);
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

fn validate_port_reference<'a>(
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

fn data_type_compatible(from: &DataType, to: &DataType) -> bool {
    from == to
}

fn is_normalized_output_type(data_type: &DataType) -> bool {
    match data_type {
        DataType::NormalizedModel => true,
        DataType::List { item } => matches!(item.as_ref(), DataType::NormalizedModel),
        _ => false,
    }
}

fn data_type_label(data_type: &DataType) -> String {
    match data_type {
        DataType::Text => "text".to_string(),
        DataType::Html => "html".to_string(),
        DataType::Json => "json".to_string(),
        DataType::Url => "url".to_string(),
        DataType::List { item } => format!("list<{}>", data_type_label(item)),
        DataType::Record { fields } => {
            let labels = fields
                .iter()
                .map(|field| format!("{}:{}", field.name, data_type_label(&field.data_type)))
                .collect::<Vec<_>>()
                .join(", ");
            format!("record{{{labels}}}")
        }
        DataType::NormalizedModel => "normalizedModel".to_string(),
    }
}

fn port_direction_label(direction: PortDirection) -> &'static str {
    match direction {
        PortDirection::Input => "输入",
        PortDirection::Output => "输出",
    }
}

fn phase_key(phase: LifecyclePhase) -> &'static str {
    match phase {
        LifecyclePhase::Explore => "explore",
        LifecyclePhase::Search => "search",
        LifecyclePhase::Detail => "detail",
        LifecyclePhase::Toc => "toc",
        LifecyclePhase::Content => "content",
    }
}

fn diagnostic(code: &str, path: String, node_id: Option<String>, message: String) -> Diagnostic {
    Diagnostic {
        code: code.to_string(),
        severity: DiagnosticSeverity::Error,
        path: Some(path),
        node_id,
        message,
    }
}

#[cfg(test)]
mod tests {
    use super::{
        CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT, CODE_DUPLICATE_NODE_ID,
        CODE_GRAPH_CYCLE, CODE_TYPE_MISMATCH, CODE_UNKNOWN_NODE, validate_rule,
    };
    use crate::rules_ir::RuleEnvelope;

    fn load_fixture(path: &str) -> RuleEnvelope {
        serde_json::from_str(path).expect("fixture 应该可成功反序列化")
    }

    #[test]
    fn validate_min_fixture_success() {
        let rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.is_empty(),
            "最小规则不应产生诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_invalid_edge_fixture_reports_unknown_node() {
        let rule = load_fixture(include_str!("../../../fixtures/ir_v1_invalid_edge.json"));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_UNKNOWN_NODE
                    && diagnostic.path.as_deref() == Some("graph.edges[1].from.nodeId")
                    && diagnostic.node_id.as_deref() == Some("ghost_node")
            }),
            "无效边 fixture 应包含 UNKNOWN_NODE 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_type_mismatch_fixture_reports_type_mismatch() {
        let rule = load_fixture(include_str!("../../../fixtures/ir_v1_type_mismatch.json"));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_TYPE_MISMATCH),
            "类型不匹配 fixture 应包含 TYPE_MISMATCH 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_cycle_fixture_reports_cycle() {
        let rule = load_fixture(include_str!("../../../fixtures/ir_v1_cycle.json"));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_GRAPH_CYCLE),
            "环路 fixture 应包含 GRAPH_CYCLE 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_pagination_capability_requires_search_output() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        rule.normalized_outputs.clear();

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT
                    && diagnostic.path.as_deref() == Some("capabilities.supportsPagination")
            }),
            "分页能力缺少 search 输出时应产生 capability 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_duplicate_node_without_cycle_does_not_report_graph_cycle() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        let duplicate_node = rule.graph.nodes[0].clone();
        rule.graph.nodes.push(duplicate_node);

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_DUPLICATE_NODE_ID),
            "重复节点应保留 DUPLICATE_NODE_ID 诊断: {diagnostics:#?}"
        );
        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_GRAPH_CYCLE),
            "重复节点但无环时不应误报 GRAPH_CYCLE: {diagnostics:#?}"
        );
    }
}
