use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
#[cfg(feature = "ts-rs")]
use ts_rs::TS;

#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct PipelineGraph {
    pub nodes: Vec<FlowNode>,
    pub edges: Vec<FlowEdge>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct FlowNode {
    pub id: String,
    pub x: f64,
    pub y: f64,
    pub data: NodePayload,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "type", content = "config")]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub enum NodePayload {
    Selector(SelectorDef),
    Transform(TransformDef),
    Aggregation(AggregationDef),
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "method")]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub enum SelectorDef {
    Css { selector: String },
    XPath { query: String },
    JsonPath { path: String },
    Regex { pattern: String },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "method")]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub enum TransformDef {
    Trim,
    Lower,
    Upper,
    RegexReplace { pattern: String, replace: String },
    Text,
    Attr { name: String },
    Url,
    Js { script: String },
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[serde(tag = "method")]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub enum AggregationDef {
    First,
    Last,
    Join { separator: String },
    Array,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct FlowEdge {
    pub id: String,
    pub source: String,
    pub target: String,
}

/// Pipeline 执行请求
///
/// 包含执行 Pipeline 所需的所有输入数据
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct PipelineExecuteRequest {
    /// 输入内容 (HTML/JSON/XML 字符串)
    pub content: String,
    /// 基础 URL (用于 URL 拼接)
    pub base_url: Option<String>,
    /// 上下文变量 (JSON 对象，用于 JS 执行)
    pub vars: Option<String>,
    /// 要执行的操作序列 (简化格式)
    pub operations: Vec<PipelineOperation>,
}

/// Pipeline 操作定义 (简化格式，用于 FFI 传输)
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct PipelineOperation {
    /// 操作类型: "xpath", "css", "jsonpath", "regex", "trim", "lower", "upper", "replace", "url",
    /// "js", "attr", "text"
    #[serde(rename = "type")]
    pub op_type: String,
    /// 操作参数
    pub param: Option<String>,
    /// 第二个参数 (用于 replace 等需要两个参数的操作)
    pub param2: Option<String>,
}

/// Pipeline 执行结果
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct PipelineExecuteResult {
    /// 执行是否成功
    pub success: bool,
    /// 结果数据
    pub data: Vec<String>,
    /// 错误信息 (如果有)
    pub error: Option<String>,
}
