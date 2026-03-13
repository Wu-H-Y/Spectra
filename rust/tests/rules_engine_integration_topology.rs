use std::collections::BTreeMap;

use spectra_native::{
    rules_engine::{EngineContext, RuntimeValue, execute_rule},
    rules_ir::{Edge, LifecyclePhase, Node, NodeKind, PortRef},
};

mod rules_engine_support;

use rules_engine_support::{build_rule, list_text_port, text_port};

#[tokio::test]
async fn empty_graph_returns_none() {
    let rule = build_rule(vec![], vec![], BTreeMap::new());

    let result = execute_rule(&rule, EngineContext::default())
        .await
        .expect("空图应返回成功");

    assert_eq!(result.final_result, None);
    assert!(result.node_stats.is_empty());
}

#[tokio::test]
async fn complex_fan_out_join_graph_succeeds() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "left".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "right".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "join".to_string(),
            kind: NodeKind::Join,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("left"), text_port("right")],
            outputs: vec![list_text_port("joined")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "left".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "right".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "left".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "left".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "right".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "right".to_string(),
            },
        },
    ];
    let normalized_outputs = BTreeMap::from([(
        LifecyclePhase::Search,
        PortRef {
            node_id: "join".to_string(),
            port_name: "joined".to_string(),
        },
    )]);
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("topology".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("复杂拓扑应执行成功");

    assert!(matches!(
        result.final_result,
        Some(RuntimeValue::List(ref items)) if items.len() == 2
    ));
    assert!(result.node_stats["join"].success);
}
