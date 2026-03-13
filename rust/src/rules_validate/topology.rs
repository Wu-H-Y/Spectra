use std::collections::{BTreeMap, BTreeSet, VecDeque};

use super::{CODE_GRAPH_CYCLE, graph::GraphIndex, utils::diagnostic};
use crate::rules_ir::Diagnostic;

pub(crate) fn validate_topology(
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
