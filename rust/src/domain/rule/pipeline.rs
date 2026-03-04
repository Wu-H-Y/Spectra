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
