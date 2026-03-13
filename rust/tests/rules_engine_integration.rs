use std::collections::BTreeMap;

use spectra_native::{
    rules_engine::{EngineContext, RuntimeValue, execute_rule},
    rules_ir::{Edge, LifecyclePhase, Node, NodeKind, PortRef},
};

mod rules_engine_support;

use rules_engine_support::{build_rule, list_text_port, text_port};

#[tokio::test]
async fn chain_execution_succeeds_with_correct_events_and_stats() {
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
            id: "filter".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
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
                node_id: "filter".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "filter".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let normalized_outputs = BTreeMap::from([(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    )]);
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("chain".to_string()),
    );

    let result = execute_rule(&rule, context).await.expect("链式执行应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("chain".to_string()))
    );
    assert_eq!(result.node_stats["filter"].input_messages, 1);
    assert_eq!(result.node_stats["sink"].output_messages, 1);
    assert!(!result.events.is_empty());
}

#[tokio::test]
async fn fan_out_execution_reaches_all_branches() {
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
    ];
    let rule = build_rule(nodes, edges, BTreeMap::new());

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("fanout".to_string()),
    );

    let result = execute_rule(&rule, context).await.expect("扇出执行应成功");

    assert_eq!(result.node_stats["left"].input_messages, 1);
    assert_eq!(result.node_stats["right"].input_messages, 1);
}

#[tokio::test]
async fn join_node_collects_and_aggregates_inputs() {
    let nodes = vec![
        Node {
            id: "left_input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "right_input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
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
                node_id: "left_input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "left".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "right_input".to_string(),
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
            node_id: "left_input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("L".to_string()),
    );
    context.port_inputs.insert(
        PortRef {
            node_id: "right_input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("R".to_string()),
    );

    let result = execute_rule(&rule, context).await.expect("Join 聚合应成功");

    assert!(matches!(
        result.final_result,
        Some(RuntimeValue::List(ref items))
            if items == &vec![
                RuntimeValue::Text("L".to_string()),
                RuntimeValue::Text("R".to_string())
            ]
    ));
}
