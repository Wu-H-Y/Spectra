use serde::{Deserialize, Serialize};
use ts_rs::TS;

/// 诊断相关的字符串类型定义。
pub type DiagnosticCode = String;
pub type DiagnosticPath = String;
pub type DiagnosticNodeId = String;
pub type DiagnosticMessage = String;

/// 结构化诊断信息。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct Diagnostic {
    /// 稳定错误码。
    pub code: DiagnosticCode,
    /// 诊断严重级别。
    pub severity: DiagnosticSeverity,
    /// 可选定位路径。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub path: Option<DiagnosticPath>,
    /// 可选节点 ID。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub node_id: Option<DiagnosticNodeId>,
    /// 人类可读信息。
    pub message: DiagnosticMessage,
}

/// 诊断严重级别。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub enum DiagnosticSeverity {
    Error,
    Warning,
    Info,
}
