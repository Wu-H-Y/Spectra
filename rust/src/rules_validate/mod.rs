use std::collections::{BTreeMap, BTreeSet, HashMap, VecDeque};

use crate::rules_ir::{
    DataType, Diagnostic, DiagnosticSeverity, KeyRef, KeyRefProvider, LifecyclePhase, Node,
    NodeKind, Port, PortRef, RuleEnvelope,
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
const CODE_CAPABILITY_JS_REQUIRED: &str = "CAPABILITY_JS_REQUIRED";
const CODE_CAPABILITY_CODEC_REQUIRED: &str = "CAPABILITY_CODEC_REQUIRED";
const CODE_CAPABILITY_CRYPTO_AES_REQUIRED: &str = "CAPABILITY_CRYPTO_AES_REQUIRED";
const CODE_INLINE_SECRET_NOT_ALLOWED: &str = "INLINE_SECRET_NOT_ALLOWED";
const CODE_INVALID_KEY_REF: &str = "INVALID_KEY_REF";
const CODE_CRYPTO_PARAM_REQUIRED: &str = "CRYPTO_PARAM_REQUIRED";
const CODE_CACHE_KEY_REQUIRED: &str = "CACHE_KEY_REQUIRED";
const CODE_CACHE_SCOPE_INVALID: &str = "CACHE_SCOPE_INVALID";
const CODE_CACHE_VALUE_LIMIT_INVALID: &str = "CACHE_VALUE_LIMIT_INVALID";
const CODE_COOKIE_NAME_REQUIRED: &str = "COOKIE_NAME_REQUIRED";
const CODE_COOKIE_DOMAIN_INVALID: &str = "COOKIE_DOMAIN_INVALID";
const CODE_COOKIE_DOMAIN_NOT_ALLOWED: &str = "COOKIE_DOMAIN_NOT_ALLOWED";
const CODE_COOKIE_EXPIRES_INVALID: &str = "COOKIE_EXPIRES_INVALID";

const MAX_CACHE_VALUE_BYTES_LIMIT: usize = 262_144;

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
    validate_cache_nodes(rule, &mut diagnostics);
    validate_cookie_nodes(rule, &mut diagnostics);
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

    validate_js_capability(rule, diagnostics);
    validate_transform_capabilities(rule, diagnostics);
}

fn validate_transform_capabilities(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
    for (node_index, node) in rule.graph.nodes.iter().enumerate() {
        if node.kind != NodeKind::Transform {
            continue;
        }

        let Some(family) = node.params.get("family") else {
            continue;
        };
        let family = normalize_param_value(family);

        match family.as_str() {
            "codec" => {
                if !rule.capabilities.codec {
                    diagnostics.push(diagnostic(
                        CODE_CAPABILITY_CODEC_REQUIRED,
                        format!("graph.nodes[{node_index}].params.family"),
                        Some(node.id.clone()),
                        "使用 transform family=codec 时，必须声明 capabilities.codec=true"
                            .to_string(),
                    ));
                }
            }
            "crypto" => {
                if !rule.capabilities.crypto.aes {
                    diagnostics.push(diagnostic(
                        CODE_CAPABILITY_CRYPTO_AES_REQUIRED,
                        format!("graph.nodes[{node_index}].params.family"),
                        Some(node.id.clone()),
                        "使用 transform family=crypto（AES）时，必须声明 capabilities.crypto.aes=true"
                            .to_string(),
                    ));
                }

                if rule.capabilities.allow_inline_secrets {
                    validate_crypto_key_refs(node, node_index, diagnostics);
                    validate_crypto_required_params(node, node_index, diagnostics);
                    continue;
                }

                if has_inline_secret_param(node, "key") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.key"),
                        Some(node.id.clone()),
                        "默认禁止内联密钥；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_key_ref(node, "keyRef") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.keyRef"),
                        Some(node.id.clone()),
                        "默认禁止内联密钥引用（provider=inline）；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_param(node, "iv") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.iv"),
                        Some(node.id.clone()),
                        "默认禁止内联 IV；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                if has_inline_secret_key_ref(node, "ivRef") {
                    diagnostics.push(diagnostic(
                        CODE_INLINE_SECRET_NOT_ALLOWED,
                        format!("graph.nodes[{node_index}].params.ivRef"),
                        Some(node.id.clone()),
                        "默认禁止内联 IV 引用（provider=inline）；如确需内联，请显式声明 capabilities.allowInlineSecrets=true"
                            .to_string(),
                    ));
                }

                validate_crypto_key_refs(node, node_index, diagnostics);
                validate_crypto_required_params(node, node_index, diagnostics);
            }
            _ => {}
        }
    }
}

fn validate_crypto_required_params(node: &Node, node_index: usize, diagnostics: &mut Vec<Diagnostic>) {
    let op = node
        .params
        .get("op")
        .map(|value| normalize_param_value(value))
        .unwrap_or_default();
    let transformation = node
        .params
        .get("transformation")
        .map(|value| normalize_param_value(value).replace([' ', '_'], ""));

    if !has_inline_secret_param(node, "key") && !has_inline_secret_param(node, "keyRef") {
        diagnostics.push(diagnostic(
            CODE_CRYPTO_PARAM_REQUIRED,
            format!("graph.nodes[{node_index}].params.key"),
            Some(node.id.clone()),
            "crypto 节点必须提供 key 或 keyRef".to_string(),
        ));
    }

    let requires_iv = matches!(op.as_str(), "aescbcencode" | "aescbcdecode")
        || matches!(
            transformation.as_deref(),
            Some("aes/cbc/pkcs7padding") | Some("aes/cbc/pkcs7")
        );

    if requires_iv && !has_inline_secret_param(node, "iv") && !has_inline_secret_param(node, "ivRef") {
        diagnostics.push(diagnostic(
            CODE_CRYPTO_PARAM_REQUIRED,
            format!("graph.nodes[{node_index}].params.iv"),
            Some(node.id.clone()),
            "CBC 模式必须提供 iv 或 ivRef".to_string(),
        ));
    }
}

fn validate_crypto_key_refs(node: &Node, node_index: usize, diagnostics: &mut Vec<Diagnostic>) {
    for (param_name, path_key) in [("keyRef", "keyRef"), ("ivRef", "ivRef")] {
        let Some(raw_value) = node.params.get(param_name) else {
            continue;
        };
        let trimmed = raw_value.trim();
        if trimmed.is_empty() {
            continue;
        }

        let parsed = serde_json::from_str::<KeyRef>(trimmed);
        let key_ref = match parsed {
            Ok(value) => value,
            Err(error) => {
                diagnostics.push(diagnostic(
                    CODE_INVALID_KEY_REF,
                    format!("graph.nodes[{node_index}].params.{path_key}"),
                    Some(node.id.clone()),
                    format!("{param_name} 必须是合法 KeyRef JSON：{error}"),
                ));
                continue;
            }
        };

        match key_ref.provider {
            KeyRefProvider::Inline => {
                if key_ref.value.as_deref().unwrap_or_default().trim().is_empty() {
                    diagnostics.push(diagnostic(
                        CODE_INVALID_KEY_REF,
                        format!("graph.nodes[{node_index}].params.{path_key}"),
                        Some(node.id.clone()),
                        format!("{param_name} provider=inline 时必须提供非空 value"),
                    ));
                }
            }
            KeyRefProvider::Variable => {
                if key_ref.name.as_deref().unwrap_or_default().trim().is_empty() {
                    diagnostics.push(diagnostic(
                        CODE_INVALID_KEY_REF,
                        format!("graph.nodes[{node_index}].params.{path_key}"),
                        Some(node.id.clone()),
                        format!("{param_name} provider=variable 时必须提供非空 name"),
                    ));
                }
            }
            KeyRefProvider::SecureStore => {
                if key_ref.name.as_deref().unwrap_or_default().trim().is_empty() {
                    diagnostics.push(diagnostic(
                        CODE_INVALID_KEY_REF,
                        format!("graph.nodes[{node_index}].params.{path_key}"),
                        Some(node.id.clone()),
                        format!("{param_name} provider=secureStore 时必须提供非空 name"),
                    ));
                }
            }
        }
    }
}

fn has_inline_secret_param(node: &Node, key: &str) -> bool {
    node.params
        .get(key)
        .map(|value| !value.trim().is_empty())
        .unwrap_or(false)
}

fn has_inline_secret_key_ref(node: &Node, key: &str) -> bool {
    let Some(raw_ref) = node.params.get(key) else {
        return false;
    };

    serde_json::from_str::<KeyRef>(raw_ref)
        .map(|value| {
            matches!(value.provider, KeyRefProvider::Inline)
                && !value.value.as_deref().unwrap_or_default().trim().is_empty()
        })
        .unwrap_or(false)
}

fn validate_cache_nodes(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
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

fn validate_cookie_nodes(rule: &RuleEnvelope, diagnostics: &mut Vec<Diagnostic>) {
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

fn normalize_cookie_domain(value: &str) -> String {
    value
        .trim()
        .to_ascii_lowercase()
        .trim_start_matches('.')
        .to_string()
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
            && label.chars().all(|char| char.is_ascii_alphanumeric() || char == '-')
    })
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

fn normalize_param_value(value: &str) -> String {
    value.trim().to_ascii_lowercase()
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
        CODE_CACHE_KEY_REQUIRED, CODE_CACHE_SCOPE_INVALID, CODE_CACHE_VALUE_LIMIT_INVALID,
        CODE_CAPABILITY_CODEC_REQUIRED, CODE_CAPABILITY_CRYPTO_AES_REQUIRED,
        CODE_CAPABILITY_JS_REQUIRED, CODE_CAPABILITY_PAGINATION_REQUIRES_SEARCH_OUTPUT,
        CODE_COOKIE_DOMAIN_NOT_ALLOWED, CODE_COOKIE_EXPIRES_INVALID, CODE_DUPLICATE_NODE_ID,
        CODE_GRAPH_CYCLE, CODE_INLINE_SECRET_NOT_ALLOWED, CODE_INVALID_KEY_REF,
        CODE_TYPE_MISMATCH, CODE_UNKNOWN_NODE, MAX_CACHE_VALUE_BYTES_LIMIT, validate_rule,
    };
    use crate::rules_ir::{DataType, LifecyclePhase, Node, NodeKind, Port, RuleEnvelope};

    fn text_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Text,
            optional: false,
        }
    }

    fn append_js_transform_node(rule: &mut RuleEnvelope) {
        rule.graph.nodes.push(Node {
            id: "js_transform".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("family".to_string(), "js".to_string()),
                (
                    "script".to_string(),
                    "return input.toLowerCase();".to_string(),
                ),
            ]
            .into_iter()
            .collect(),
        });
    }

    fn append_codec_transform_node(rule: &mut RuleEnvelope) {
        rule.graph.nodes.push(Node {
            id: "codec_transform".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("family".to_string(), "codec".to_string()),
                ("op".to_string(), "base64Encode".to_string()),
            ]
            .into_iter()
            .collect(),
        });
    }

    fn append_crypto_transform_with_inline_secret_node(rule: &mut RuleEnvelope) {
        rule.graph.nodes.push(Node {
            id: "crypto_transform".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("family".to_string(), "crypto".to_string()),
                ("op".to_string(), "aesEncode".to_string()),
                (
                    "transformation".to_string(),
                    "AES/CBC/PKCS7Padding".to_string(),
                ),
                ("key".to_string(), "1234567890abcdef".to_string()),
                ("iv".to_string(), "fedcba0987654321".to_string()),
            ]
            .into_iter()
            .collect(),
        });
    }

    fn append_crypto_transform_with_key_ref_node(rule: &mut RuleEnvelope) {
        rule.graph.nodes.push(Node {
            id: "crypto_ref_transform".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("family".to_string(), "crypto".to_string()),
                ("op".to_string(), "aesEncode".to_string()),
                (
                    "transformation".to_string(),
                    "AES/CBC/PKCS7Padding".to_string(),
                ),
                (
                    "keyRef".to_string(),
                    r#"{"provider":"variable","name":"SPECTRA_AES_KEY"}"#.to_string(),
                ),
                (
                    "ivRef".to_string(),
                    r#"{"provider":"variable","name":"SPECTRA_AES_IV"}"#.to_string(),
                ),
            ]
            .into_iter()
            .collect(),
        });
    }

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
    fn validate_html_story_fixture_success() {
        let rule = load_fixture(include_str!(
            "../../../fixtures/ir_v1_html_story_bundle.json"
        ));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.is_empty(),
            "HTML 示例 fixture 不应产生诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_json_api_fixture_success() {
        let rule = load_fixture(include_str!("../../../fixtures/ir_v1_json_api_bundle.json"));

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.is_empty(),
            "JSON API 示例 fixture 不应产生诊断: {diagnostics:#?}"
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

    #[test]
    fn validate_js_transform_requires_js_capability() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_js_transform_node(&mut rule);
        rule.capabilities.supports_js = false;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_CAPABILITY_JS_REQUIRED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
                    && diagnostic.node_id.as_deref() == Some("js_transform")
            }),
            "未声明 JS 能力时应拒绝 js transform: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_js_transform_passes_when_js_capability_enabled() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_js_transform_node(&mut rule);
        rule.capabilities.supports_js = true;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_CAPABILITY_JS_REQUIRED),
            "声明 supportsJs=true 后不应再报 JS capability 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_codec_transform_requires_codec_capability() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_codec_transform_node(&mut rule);
        rule.capabilities.codec = false;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_CAPABILITY_CODEC_REQUIRED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
                    && diagnostic.node_id.as_deref() == Some("codec_transform")
            }),
            "未声明 codec 能力时应拒绝 codec transform: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_requires_aes_capability_and_rejects_inline_secret_by_default() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_inline_secret_node(&mut rule);
        rule.capabilities.crypto.aes = false;
        rule.capabilities.allow_inline_secrets = false;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_CAPABILITY_CRYPTO_AES_REQUIRED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.family")
                    && diagnostic.node_id.as_deref() == Some("crypto_transform")
            }),
            "未声明 crypto.aes 能力时应拒绝 crypto transform: {diagnostics:#?}"
        );
        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.key")
                    && diagnostic.node_id.as_deref() == Some("crypto_transform")
            }),
            "默认不允许内联 key，应产生拒绝诊断: {diagnostics:#?}"
        );
        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.iv")
                    && diagnostic.node_id.as_deref() == Some("crypto_transform")
            }),
            "默认不允许内联 iv，应产生拒绝诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_allows_inline_secret_when_capability_enabled() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_inline_secret_node(&mut rule);
        rule.capabilities.crypto.aes = true;
        rule.capabilities.allow_inline_secrets = true;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_INLINE_SECRET_NOT_ALLOWED),
            "声明 allowInlineSecrets=true 后不应再报内联密钥诊断: {diagnostics:#?}"
        );
        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_CAPABILITY_CRYPTO_AES_REQUIRED),
            "声明 capabilities.crypto.aes=true 后不应再报 AES 能力诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_key_ref_is_accepted_when_inline_secret_disabled() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_key_ref_node(&mut rule);
        rule.capabilities.crypto.aes = true;
        rule.capabilities.allow_inline_secrets = false;

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_INLINE_SECRET_NOT_ALLOWED),
            "仅使用 KeyRef 时不应触发 inline secret 拒绝: {diagnostics:#?}"
        );
        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_INVALID_KEY_REF),
            "合法 env KeyRef 不应触发 INVALID_KEY_REF: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_rejects_invalid_or_unsupported_key_ref() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_key_ref_node(&mut rule);
        rule.capabilities.crypto.aes = true;
        rule.capabilities.allow_inline_secrets = false;
        let target = rule
            .graph
            .nodes
            .iter_mut()
            .find(|node| node.id == "crypto_ref_transform")
            .expect("应存在 crypto_ref_transform");
        target.params.insert(
            "keyRef".to_string(),
            r#"{"provider":"secureStore","name":""}"#.to_string(),
        );
        target
            .params
            .insert("ivRef".to_string(), "{not-json".to_string());

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_INVALID_KEY_REF),
            "无效/不支持的 KeyRef 应触发 INVALID_KEY_REF: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_rejects_inline_key_ref_when_inline_secret_disabled() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_key_ref_node(&mut rule);
        rule.capabilities.crypto.aes = true;
        rule.capabilities.allow_inline_secrets = false;
        let target = rule
            .graph
            .nodes
            .iter_mut()
            .find(|node| node.id == "crypto_ref_transform")
            .expect("应存在 crypto_ref_transform");
        target.params.insert(
            "keyRef".to_string(),
            r#"{"provider":"inline","value":"1234567890abcdef"}"#.to_string(),
        );

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics.iter().any(|diagnostic| {
                diagnostic.code == CODE_INLINE_SECRET_NOT_ALLOWED
                    && diagnostic.path.as_deref() == Some("graph.nodes[2].params.keyRef")
            }),
            "allowInlineSecrets=false 时应拒绝 provider=inline 的 KeyRef: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_crypto_transform_accepts_secure_store_key_ref_shape() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        append_crypto_transform_with_key_ref_node(&mut rule);
        rule.capabilities.crypto.aes = true;
        rule.capabilities.allow_inline_secrets = false;
        let target = rule
            .graph
            .nodes
            .iter_mut()
            .find(|node| node.id == "crypto_ref_transform")
            .expect("应存在 crypto_ref_transform");
        target.params.insert(
            "keyRef".to_string(),
            r#"{"provider":"secureStore","name":"vault/aes/key"}"#.to_string(),
        );
        target.params.insert(
            "ivRef".to_string(),
            r#"{"provider":"secureStore","name":"vault/aes/iv"}"#.to_string(),
        );

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .all(|diagnostic| diagnostic.code != CODE_INVALID_KEY_REF),
            "secureStore KeyRef 的结构在 validator 应被接受（运行时适配另行处理）: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_cache_put_rejects_empty_key_invalid_scope_and_bad_value_limit() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        rule.graph.nodes.push(Node {
            id: "cache_put".to_string(),
            kind: NodeKind::CachePut,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("key".to_string(), "   ".to_string()),
                ("scope".to_string(), "global".to_string()),
                (
                    "maxValueBytes".to_string(),
                    (MAX_CACHE_VALUE_BYTES_LIMIT + 1).to_string(),
                ),
            ]
            .into_iter()
            .collect(),
        });

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_CACHE_KEY_REQUIRED),
            "CachePut key 为空应产生 CACHE_KEY_REQUIRED 诊断: {diagnostics:#?}"
        );
        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_CACHE_SCOPE_INVALID),
            "CachePut scope 非法应产生 CACHE_SCOPE_INVALID 诊断: {diagnostics:#?}"
        );
        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_CACHE_VALUE_LIMIT_INVALID),
            "CachePut maxValueBytes 超限应产生 CACHE_VALUE_LIMIT_INVALID 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_cache_get_rejects_empty_key() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        rule.graph.nodes.push(Node {
            id: "cache_get".to_string(),
            kind: NodeKind::CacheGet,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: [("scope".to_string(), "run".to_string())]
                .into_iter()
                .collect(),
        });

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_CACHE_KEY_REQUIRED),
            "CacheGet 缺失 key 应产生 CACHE_KEY_REQUIRED 诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_cookie_put_rejects_domain_outside_allowlist() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        rule.graph.nodes.push(Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("name".to_string(), "session".to_string()),
                ("domain".to_string(), "cross-domain.example".to_string()),
            ]
            .into_iter()
            .collect(),
        });

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_COOKIE_DOMAIN_NOT_ALLOWED),
            "CookiePut 跨域且不在 allowDomains 时应产生拒绝诊断: {diagnostics:#?}"
        );
    }

    #[test]
    fn validate_cookie_put_rejects_invalid_expires() {
        let mut rule = load_fixture(include_str!("../../../fixtures/ir_v1_min.json"));
        rule.graph.nodes.push(Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: [
                ("name".to_string(), "session".to_string()),
                ("expires".to_string(), "not-a-timestamp".to_string()),
            ]
            .into_iter()
            .collect(),
        });

        let diagnostics = validate_rule(&rule);

        assert!(
            diagnostics
                .iter()
                .any(|diagnostic| diagnostic.code == CODE_COOKIE_EXPIRES_INVALID),
            "CookiePut 非法 expires 应产生拒绝诊断: {diagnostics:#?}"
        );
    }
}
