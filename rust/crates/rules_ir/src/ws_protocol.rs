use serde::{Deserialize, Serialize};

/// WebSocket 协议版本 v1 标记。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize, Default)]
#[serde(try_from = "u8", into = "u8")]
pub struct ProtocolVersionV1;

impl TryFrom<u8> for ProtocolVersionV1 {
    type Error = String;

    fn try_from(value: u8) -> Result<Self, Self::Error> {
        if value == 1 {
            Ok(Self)
        } else {
            Err(format!("仅支持 WebSocket 协议版本 1, 实际收到 {value}"))
        }
    }
}

impl From<ProtocolVersionV1> for u8 {
    fn from(_: ProtocolVersionV1) -> Self {
        1
    }
}

/// v1 协议消息外层封套。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(bound(deserialize = "T: Deserialize<'de>", serialize = "T: Serialize"))]
pub struct WsMessageV1<T = ()> {
    /// 协议版本，服务端消息固定为 1。
    pub v: ProtocolVersionV1,
    /// 消息类型。
    #[serde(rename = "type")]
    pub message_type: String,
    /// 可选消息负载。
    #[serde(skip_serializing_if = "Option::is_none")]
    pub data: Option<T>,
}

/// 客户端发往服务端的 v1 消息封套，允许省略版本字段。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
pub struct ClientMessageEnvelopeV1 {
    /// 可选协议版本，客户端可以不传。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub v: Option<ProtocolVersionV1>,
    /// 客户端消息体。
    #[serde(flatten)]
    pub message: ClientMessageV1,
}

/// 客户端消息。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(tag = "type", content = "data", rename_all = "snake_case")]
pub enum ClientMessageV1 {
    /// 鉴权握手消息。
    Auth(AuthData),
    /// 订阅消息。
    Subscribe(SubscriptionFilter),
    /// 取消订阅消息。
    Unsubscribe(SubscriptionFilter),
    /// 心跳请求。
    Ping,
    /// 心跳响应。
    Pong,
}

/// 鉴权消息数据。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct AuthData {
    /// 访问令牌。
    pub token: String,
}

/// 订阅过滤条件。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, Default)]
#[serde(rename_all = "camelCase")]
pub struct SubscriptionFilter {
    /// 运行实例 ID。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    /// 会话 ID。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub session_id: Option<String>,
    /// 预览会话 ID。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub preview_session_id: Option<String>,
}

/// 节点事件。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize)]
#[serde(
    tag = "event",
    rename_all = "snake_case",
    rename_all_fields = "camelCase"
)]
pub enum NodeEvent {
    /// 运行开始事件。
    RunStarted {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
    },
    /// 节点开始执行事件。
    NodeStarted {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        node_id: String,
    },
    /// 端口输出事件。
    PortEmit {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        node_id: String,
        port: String,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        payload_preview: Option<String>,
        payload_truncated: bool,
    },
    /// 节点日志事件。
    NodeLog {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        node_id: String,
        level: String,
        message: String,
    },
    /// 节点错误事件。
    NodeError {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        node_id: String,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        port: Option<String>,
        message: String,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        code: Option<String>,
    },
    /// 节点完成事件。
    NodeFinished {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        node_id: String,
        success: bool,
    },
    /// 运行完成事件。
    RunFinished {
        run_id: String,
        seq: u64,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        trace_id: Option<String>,
        #[serde(default, skip_serializing_if = "Option::is_none")]
        span_id: Option<String>,
        success: bool,
    },
}

#[cfg(test)]
mod tests {
    use super::{ClientMessageEnvelopeV1, ClientMessageV1, NodeEvent, WsMessageV1};

    #[test]
    fn deserialize_ws_message_with_node_event_success() {
        let json = r#"
        {
          "v": 1,
          "type": "node_event",
          "data": {
            "event": "port_emit",
            "runId": "run-1",
            "seq": 7,
            "traceId": "trace-1",
            "spanId": "span-1",
            "nodeId": "node-a",
            "port": "items",
            "payloadPreview": "[{\"id\":1}]",
            "payloadTruncated": false
          }
        }
        "#;

        let message: WsMessageV1<NodeEvent> =
            serde_json::from_str(json).expect("WsMessageV1 与 NodeEvent 应可成功反序列化");

        assert_eq!(message.message_type, "node_event");
        match message.data {
            Some(NodeEvent::PortEmit { seq, node_id, .. }) => {
                assert_eq!(seq, 7);
                assert_eq!(node_id, "node-a");
            }
            _ => panic!("应解析为 PortEmit 事件"),
        }
    }

    #[test]
    fn deserialize_node_error_event_success() {
        let json = r#"
        {
          "event": "node_error",
          "runId": "run-1",
          "seq": 9,
          "traceId": "trace-1",
          "spanId": "span-1",
          "nodeId": "node-b",
          "port": "detail",
          "message": "下游接口响应超时",
          "code": "UPSTREAM_TIMEOUT"
        }
        "#;

        let event: NodeEvent = serde_json::from_str(json).expect("NodeError 事件应可成功反序列化");

        match event {
            NodeEvent::NodeError { seq, code, .. } => {
                assert_eq!(seq, 9);
                assert_eq!(code.as_deref(), Some("UPSTREAM_TIMEOUT"));
            }
            _ => panic!("应解析为 NodeError 事件"),
        }
    }

    #[test]
    fn deserialize_auth_message_without_version_success() {
        let json = r#"
        {
          "type": "auth",
          "data": {
            "token": "token-abc"
          }
        }
        "#;

        let message: ClientMessageEnvelopeV1 =
            serde_json::from_str(json).expect("客户端 auth 消息允许缺省 v 字段");

        assert!(message.v.is_none());
        match message.message {
            ClientMessageV1::Auth(data) => assert_eq!(data.token, "token-abc"),
            _ => panic!("应解析为 auth 消息"),
        }
    }

    #[test]
    fn deserialize_subscribe_message_success() {
        let json = r#"
        {
          "v": 1,
          "type": "subscribe",
          "data": {
            "runId": "run-1",
            "sessionId": "session-1",
            "previewSessionId": "preview-1"
          }
        }
        "#;

        let message: ClientMessageEnvelopeV1 =
            serde_json::from_str(json).expect("subscribe 消息应可成功反序列化");

        match message.message {
            ClientMessageV1::Subscribe(filter) => {
                assert_eq!(filter.run_id.as_deref(), Some("run-1"));
                assert_eq!(filter.session_id.as_deref(), Some("session-1"));
                assert_eq!(filter.preview_session_id.as_deref(), Some("preview-1"));
            }
            _ => panic!("应解析为 subscribe 消息"),
        }
    }
}
