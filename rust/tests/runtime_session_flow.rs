use std::collections::BTreeMap;

use spectra_native::{
    rules_engine::{EngineContext, RuntimeValue, execute_rule},
    rules_ir::{
        Capabilities, ClientMessageEnvelopeV1, ClientMessageV1, DataType, Edge, Graph,
        LifecyclePhase, Metadata, Node, NodeEvent, NodeKind, Port, PortRef, RuleEnvelope,
        SubscriptionFilter,
    },
};

const SESSION_ID: &str = "session_runtime_001";
const PREVIEW_SESSION_ID: &str = "preview_runtime_001";
const RUN_ID: &str = "run_runtime_001";

fn text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Text,
        optional: false,
    }
}

fn build_runtime_rule() -> RuleEnvelope {
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );

    RuleEnvelope {
        ir_version: "1.0.0".to_string(),
        metadata: Metadata {
            rule_id: "runtime.session.flow".to_string(),
            name: "运行时会话链路集成测试".to_string(),
            description: Some(
                "验证 runtime 事件与 canonical session/preview/run 链路的一致性".to_string(),
            ),
        },
        graph: Graph {
            nodes: vec![
                Node {
                    id: "input".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![text_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "passthrough".to_string(),
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
            ],
            edges: vec![
                Edge {
                    from: PortRef {
                        node_id: "input".to_string(),
                        port_name: "out".to_string(),
                    },
                    to: PortRef {
                        node_id: "passthrough".to_string(),
                        port_name: "in".to_string(),
                    },
                },
                Edge {
                    from: PortRef {
                        node_id: "passthrough".to_string(),
                        port_name: "out".to_string(),
                    },
                    to: PortRef {
                        node_id: "sink".to_string(),
                        port_name: "in".to_string(),
                    },
                },
            ],
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

fn event_seq(event: &NodeEvent) -> u64 {
    match event {
        NodeEvent::RunStarted { seq, .. }
        | NodeEvent::NodeStarted { seq, .. }
        | NodeEvent::PortEmit { seq, .. }
        | NodeEvent::NodeLog { seq, .. }
        | NodeEvent::NodeError { seq, .. }
        | NodeEvent::NodeFinished { seq, .. }
        | NodeEvent::RunFinished { seq, .. } => *seq,
    }
}

fn event_run_id(event: &NodeEvent) -> &str {
    match event {
        NodeEvent::RunStarted { run_id, .. }
        | NodeEvent::NodeStarted { run_id, .. }
        | NodeEvent::PortEmit { run_id, .. }
        | NodeEvent::NodeLog { run_id, .. }
        | NodeEvent::NodeError { run_id, .. }
        | NodeEvent::NodeFinished { run_id, .. }
        | NodeEvent::RunFinished { run_id, .. } => run_id,
    }
}

#[tokio::test]
async fn runtime_events_correlate_with_canonical_session_chain() {
    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("hello-engine".to_string()),
    );
    context.run_id = Some(RUN_ID.to_string());

    let result = execute_rule(&build_runtime_rule(), context)
        .await
        .expect("链式 runtime 图应执行成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("hello-engine".to_string()))
    );
    assert_eq!(
        result.phase_results.get(&LifecyclePhase::Search),
        Some(&RuntimeValue::Text("hello-engine".to_string()))
    );
    assert_eq!(result.events.first().map(event_seq), Some(1));
    assert!(matches!(
        result.events.first(),
        Some(NodeEvent::RunStarted { .. })
    ));
    assert!(matches!(
        result.events.last(),
        Some(NodeEvent::RunFinished { success: true, .. })
    ));
    assert!(
        result
            .events
            .windows(2)
            .all(|pair| event_seq(&pair[1]) > event_seq(&pair[0]))
    );
    assert!(
        result
            .events
            .iter()
            .all(|event| event_run_id(event) == RUN_ID)
    );
    assert_eq!(result.node_stats.len(), 3);
    assert!(result.node_stats.values().all(|stats| stats.success));
    assert_eq!(result.node_stats["input"].output_messages, 1);
    assert_eq!(result.node_stats["passthrough"].input_messages, 1);
    assert_eq!(result.node_stats["sink"].input_messages, 1);

    let envelope = ClientMessageEnvelopeV1 {
        v: None,
        message: ClientMessageV1::Subscribe(SubscriptionFilter {
            run_id: Some(RUN_ID.to_string()),
            session_id: Some(SESSION_ID.to_string()),
            preview_session_id: Some(PREVIEW_SESSION_ID.to_string()),
        }),
    };
    let decoded: ClientMessageEnvelopeV1 = serde_json::from_str(
        &serde_json::to_string(&envelope).expect("canonical 订阅消息应可序列化"),
    )
    .expect("canonical 订阅消息应可反序列化");

    match decoded.message {
        ClientMessageV1::Subscribe(filter) => {
            assert_eq!(filter.session_id.as_deref(), Some(SESSION_ID));
            assert_eq!(
                filter.preview_session_id.as_deref(),
                Some(PREVIEW_SESSION_ID)
            );
            assert_eq!(filter.run_id.as_deref(), Some(RUN_ID));
            assert_eq!(
                filter.run_id.as_deref(),
                Some(event_run_id(&result.events[0]))
            );
        }
        other => panic!("应解析为 subscribe 消息，实际为 {other:?}"),
    }
}
