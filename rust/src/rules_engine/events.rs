use tokio::sync::mpsc;

use super::RuntimeValue;
use crate::rules_ir::NodeEvent;

const PAYLOAD_PREVIEW_LIMIT_BYTES: usize = 1024;

#[derive(Debug, Clone)]
pub(crate) enum EventCommand {
    RunStarted,
    NodeStarted {
        node_id: String,
    },
    PortEmit {
        node_id: String,
        port: String,
        payload_preview: Option<String>,
        payload_truncated: bool,
        cache_hit: bool,
    },
    NodeLog {
        node_id: String,
        level: String,
        message: String,
    },
    NodeError {
        node_id: String,
        port: Option<String>,
        message: String,
        code: Option<String>,
    },
    NodeFinished {
        node_id: String,
        success: bool,
    },
    RunFinished {
        success: bool,
    },
}

pub(crate) async fn collect_events(
    run_id: String,
    trace_id: Option<String>,
    mut receiver: mpsc::Receiver<EventCommand>,
) -> Vec<NodeEvent> {
    let mut seq = 0_u64;
    let mut events = Vec::new();

    while let Some(command) = receiver.recv().await {
        seq += 1;
        if let Some(event) = build_event(command, &run_id, trace_id.clone(), seq) {
            events.push(event);
        }
    }

    events
}

fn build_event(
    command: EventCommand,
    run_id: &str,
    trace_id: Option<String>,
    seq: u64,
) -> Option<NodeEvent> {
    match command {
        EventCommand::RunStarted => Some(NodeEvent::RunStarted {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
        }),
        EventCommand::NodeStarted { node_id } => Some(NodeEvent::NodeStarted {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
        }),
        EventCommand::PortEmit {
            node_id,
            port,
            payload_preview,
            payload_truncated,
            cache_hit,
        } => Some(NodeEvent::PortEmit {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            port,
            payload_preview,
            payload_truncated,
            cache_hit,
        }),
        EventCommand::NodeLog {
            node_id,
            level,
            message,
        } => Some(NodeEvent::NodeLog {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            level,
            message,
        }),
        EventCommand::NodeError {
            node_id,
            port,
            message,
            code,
        } => Some(NodeEvent::NodeError {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            port,
            message,
            code,
        }),
        EventCommand::NodeFinished { node_id, success } => Some(NodeEvent::NodeFinished {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            success,
        }),
        EventCommand::RunFinished { success } => Some(NodeEvent::RunFinished {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            success,
        }),
    }
}

pub(crate) async fn send_event(sender: &mpsc::Sender<EventCommand>, command: EventCommand) {
    let _ = sender.send(command).await;
}

pub(crate) async fn emit_node_log(
    sender: &mpsc::Sender<EventCommand>,
    node_id: &str,
    level: &str,
    message: String,
) {
    send_event(
        sender,
        EventCommand::NodeLog {
            node_id: node_id.to_string(),
            level: level.to_string(),
            message,
        },
    )
    .await;
}

pub(crate) fn preview_payload(value: &RuntimeValue) -> (String, bool) {
    let serialized = serde_json::to_string(value).unwrap_or_else(|_| "\"序列化失败\"".to_string());
    truncate_utf8(serialized, PAYLOAD_PREVIEW_LIMIT_BYTES)
}

pub(crate) fn truncate_utf8(value: String, max_bytes: usize) -> (String, bool) {
    if value.len() <= max_bytes {
        return (value, false);
    }

    let mut boundary = max_bytes.min(value.len());
    while boundary > 0 && !value.is_char_boundary(boundary) {
        boundary -= 1;
    }

    (value[..boundary].to_string(), true)
}
