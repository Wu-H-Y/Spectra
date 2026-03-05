use std::collections::BTreeMap;

use serde::{Deserialize, Serialize};
use ts_rs::TS;

pub mod diagnostic;
pub mod normalized_model;
pub mod ws_protocol;

pub use diagnostic::{Diagnostic, DiagnosticSeverity};
pub use normalized_model::{
    ChapterItem, ContentModel, DetailModel, MediaAsset, MediaExtension, MediaSpec, MediaType,
    NormalizedModel, SearchItem, SearchModel, TocModel,
};
pub use ws_protocol::{
    ClientMessageEnvelopeV1, ClientMessageV1, NodeEvent, ProtocolVersionV1, SubscriptionFilter,
    WsMessageV1,
};

/// 规则 IR 顶层版本封套。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
#[ts(export)]
#[ts(export_to = "rule.ts")]
pub struct RuleEnvelope {
    /// IR 版本号，破坏性变更需升级主版本。
    pub ir_version: String,
    /// 规则元信息。
    pub metadata: Metadata,
    /// 有向图结构定义。
    pub graph: Graph,
    /// 从生命周期阶段到标准化输出端口的映射。
    #[serde(default)]
    pub normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
    /// 规则能力声明。
    pub capabilities: Capabilities,
}

/// 规则元信息。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Metadata {
    /// 规则唯一标识。
    pub rule_id: String,
    /// 规则展示名称。
    pub name: String,
    /// 可选说明。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
}

/// 规则执行图。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Graph {
    /// 节点集合。
    #[serde(default)]
    pub nodes: Vec<Node>,
    /// 边集合。
    #[serde(default)]
    pub edges: Vec<Edge>,
    /// 阶段入口端口映射。
    #[serde(default)]
    pub phase_entrypoints: BTreeMap<LifecyclePhase, PortRef>,
    /// 图元信息。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub metadata: Option<GraphMetadata>,
    /// 图布局信息。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub layout: Option<GraphLayout>,
}

/// 图元信息。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct GraphMetadata {
    /// 图名称。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub name: Option<String>,
    /// 图描述。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    /// 任意标签。
    #[serde(default)]
    pub tags: Vec<String>,
}

/// 图布局信息。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct GraphLayout {
    /// 节点布局信息。
    #[serde(default)]
    pub nodes: BTreeMap<String, NodeLayout>,
}

/// 节点布局信息。
#[derive(Debug, Clone, PartialEq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct NodeLayout {
    /// X 轴坐标。
    pub x: f64,
    /// Y 轴坐标。
    pub y: f64,
}

/// 执行节点。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Node {
    /// 节点 ID。
    pub id: String,
    /// 节点类型。
    pub kind: NodeKind,
    /// 所属生命周期阶段。
    pub phase: LifecyclePhase,
    /// 输入端口定义。
    #[serde(default)]
    pub inputs: Vec<Port>,
    /// 输出端口定义。
    #[serde(default)]
    pub outputs: Vec<Port>,
}

/// 节点类别。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(tag = "type", rename_all = "camelCase")]
pub enum NodeKind {
    Fetch,
    Parse,
    Select,
    Transform,
    Join,
    Branch,
    MapToModel,
    Loop,
    Filter,
    Assert,
    Input,
    Extract,
    Normalize,
    Output,
}

/// 端口定义。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Port {
    /// 端口名称。
    pub name: String,
    /// 端口数据类型。
    pub data_type: DataType,
    /// 是否可选。
    pub optional: bool,
}

/// 边定义。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Edge {
    /// 起点端口。
    pub from: PortRef,
    /// 终点端口。
    pub to: PortRef,
}

/// 端口引用。
#[derive(Debug, Clone, PartialEq, Eq, Hash, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct PortRef {
    /// 节点 ID。
    pub node_id: String,
    /// 端口名称。
    pub port_name: String,
}

/// 生命周期阶段。
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub enum LifecyclePhase {
    Explore,
    Search,
    Detail,
    Toc,
    Content,
}

/// 数据类型系统。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(tag = "type", rename_all = "camelCase")]
pub enum DataType {
    Text,
    Html,
    Json,
    Url,
    List { item: Box<DataType> },
    Record { fields: Vec<RecordField> },
    NormalizedModel,
}

/// 记录类型字段定义。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct RecordField {
    /// 字段名。
    pub name: String,
    /// 字段类型。
    pub data_type: DataType,
    /// 是否可选。
    pub optional: bool,
}

/// 规则能力声明。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Capabilities {
    /// 是否支持分页。
    pub supports_pagination: bool,
    /// 是否支持并发抓取。
    pub supports_concurrency: bool,
    /// 是否需要认证。
    pub requires_auth: bool,
}

#[cfg(test)]
mod tests {
    use super::RuleEnvelope;

    #[test]
    fn deserialize_min_fixture_success() {
        let fixture = include_str!("../../../../fixtures/ir_v1_min.json");
        let envelope: RuleEnvelope =
            serde_json::from_str(fixture).expect("最小 IR fixture 应可成功反序列化");

        assert_eq!(envelope.ir_version, "1.0.0");
        assert!(envelope.graph.metadata.is_none());
        assert!(envelope.graph.layout.is_none());
    }

    #[test]
    fn deserialize_invalid_edge_fixture_success() {
        let fixture = include_str!("../../../../fixtures/ir_v1_invalid_edge.json");
        let envelope: RuleEnvelope =
            serde_json::from_str(fixture).expect("无效边 fixture 在本任务中仅要求可解析");

        assert_eq!(envelope.ir_version, "1.0.0");
        assert!(envelope.graph.metadata.is_none());
        assert!(envelope.graph.layout.is_none());
    }
}
