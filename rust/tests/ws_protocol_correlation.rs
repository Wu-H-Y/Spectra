use spectra_native::rules_ir::{
    ClientMessageEnvelopeV1, ClientMessageV1, NodeEvent, SubscriptionFilter, WsMessageV1,
};

const SESSION_ID: &str = "session_runtime_001";
const PREVIEW_SESSION_ID: &str = "preview_runtime_001";
const RUN_ID: &str = "run_runtime_001";

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

#[test]
fn subscribe_message_preserves_canonical_runtime_chain() {
    let json = format!(
        r#"{{
          "v": 1,
          "type": "subscribe",
          "data": {{
            "runId": "{RUN_ID}",
            "sessionId": "{SESSION_ID}",
            "previewSessionId": "{PREVIEW_SESSION_ID}"
          }}
        }}"#
    );

    let message: ClientMessageEnvelopeV1 =
        serde_json::from_str(&json).expect("subscribe 消息应可成功反序列化");

    match message.message {
        ClientMessageV1::Subscribe(filter) => {
            assert_eq!(filter.run_id.as_deref(), Some(RUN_ID));
            assert_eq!(filter.session_id.as_deref(), Some(SESSION_ID));
            assert_eq!(
                filter.preview_session_id.as_deref(),
                Some(PREVIEW_SESSION_ID)
            );
        }
        other => panic!("应解析为 subscribe 消息，实际为 {other:?}"),
    }
}

#[test]
fn node_event_envelope_round_trips_with_canonical_run_id() {
    let json = format!(
        r#"{{
          "v": 1,
          "type": "node_event",
          "data": {{
            "event": "port_emit",
            "runId": "{RUN_ID}",
            "seq": 7,
            "traceId": "trace-runtime-001",
            "spanId": "span-runtime-001",
            "nodeId": "node-a",
            "port": "items",
            "payloadPreview": "[{{\"id\":1}}]",
            "payloadTruncated": false
          }}
        }}"#
    );

    let message: WsMessageV1<NodeEvent> =
        serde_json::from_str(&json).expect("WsMessageV1 与 NodeEvent 应可成功反序列化");

    assert_eq!(message.message_type, "node_event");
    match message.data {
        Some(NodeEvent::PortEmit {
            seq,
            node_id,
            cache_hit,
            ..
        }) => {
            assert_eq!(seq, 7);
            assert_eq!(node_id, "node-a");
            assert!(!cache_hit);
        }
        other => panic!("应解析为 PortEmit 事件，实际为 {other:?}"),
    }
}

#[test]
fn subscription_filter_and_runtime_event_share_same_run_id() {
    let filter = SubscriptionFilter {
        run_id: Some(RUN_ID.to_string()),
        session_id: Some(SESSION_ID.to_string()),
        preview_session_id: Some(PREVIEW_SESSION_ID.to_string()),
    };
    let event = NodeEvent::RunFinished {
        run_id: RUN_ID.to_string(),
        seq: 9,
        trace_id: None,
        span_id: None,
        success: true,
    };

    let envelope = ClientMessageEnvelopeV1 {
        v: None,
        message: ClientMessageV1::Subscribe(filter.clone()),
    };
    let decoded: ClientMessageEnvelopeV1 =
        serde_json::from_str(&serde_json::to_string(&envelope).expect("订阅过滤器应可序列化"))
            .expect("订阅过滤器应可反序列化");

    match decoded.message {
        ClientMessageV1::Subscribe(actual_filter) => {
            assert_eq!(actual_filter.session_id, filter.session_id);
            assert_eq!(actual_filter.preview_session_id, filter.preview_session_id);
            assert_eq!(actual_filter.run_id.as_deref(), Some(event_run_id(&event)));
        }
        other => panic!("应解析为 subscribe 消息，实际为 {other:?}"),
    }
}
