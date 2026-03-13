use std::collections::BTreeMap;

use spectra_native::rules_ir::{
    Capabilities, DataType, Edge, Graph, LifecyclePhase, Metadata, Node, Port, PortRef,
    RuleEnvelope,
};

pub fn text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Text,
        optional: false,
    }
}

pub fn list_text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::List {
            item: Box::new(DataType::Text),
        },
        optional: false,
    }
}

pub fn build_rule(
    nodes: Vec<Node>,
    edges: Vec<Edge>,
    normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
) -> RuleEnvelope {
    RuleEnvelope {
        ir_version: "1.0.0".to_string(),
        metadata: Metadata {
            rule_id: "test.rule".to_string(),
            name: "规则引擎集成测试".to_string(),
            description: Some("用于验证 rules_engine 拆分后的公开行为".to_string()),
        },
        graph: Graph {
            nodes,
            edges,
            phase_entrypoints: BTreeMap::new(),
            metadata: None,
            layout: None,
        },
        normalized_outputs,
        capabilities: Capabilities {
            supports_pagination: false,
            supports_concurrency: false,
            requires_auth: false,
            supports_js: false,
            codec: false,
            crypto: Default::default(),
            allow_inline_secrets: false,
        },
        rate_limit: None,
    }
}
