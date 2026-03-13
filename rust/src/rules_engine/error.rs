use std::fmt;

/// 引擎错误。
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum EngineError {
    MissingInput {
        node_id: String,
        port_name: String,
    },
    TypeMismatch {
        node_id: String,
        port_name: String,
        expected: String,
        actual: String,
    },
    JoinWithoutInputs {
        node_id: String,
    },
    MissingFinalResult,
    NodeFailed {
        node_id: String,
        message: String,
        code: Option<String>,
    },
    JsTimeout {
        node_id: String,
        message: String,
    },
    TaskJoin(String),
}

impl fmt::Display for EngineError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::MissingInput { node_id, port_name } => {
                write!(
                    formatter,
                    "节点 `{node_id}` 缺少输入端口 `{port_name}` 的数据"
                )
            }
            Self::TypeMismatch {
                node_id,
                port_name,
                expected,
                actual,
            } => write!(
                formatter,
                "节点 `{node_id}` 的端口 `{port_name}` 类型不匹配，期望 `{expected}`，实际 `{actual}`"
            ),
            Self::JoinWithoutInputs { node_id } => {
                write!(formatter, "Join 节点 `{node_id}` 至少需要一个输入值")
            }
            Self::MissingFinalResult => write!(formatter, "运行结束后未生成最终结果"),
            Self::NodeFailed {
                node_id, message, ..
            } => {
                write!(formatter, "节点 `{node_id}` 执行失败：{message}")
            }
            Self::JsTimeout { node_id, message } => {
                write!(formatter, "节点 `{node_id}` JS 执行超时：{message}")
            }
            Self::TaskJoin(message) => write!(formatter, "异步任务执行失败：{message}"),
        }
    }
}

impl std::error::Error for EngineError {}

impl EngineError {
    pub(crate) fn code(&self) -> &str {
        match self {
            Self::MissingInput { .. } => "MISSING_INPUT",
            Self::TypeMismatch { .. } => "TYPE_MISMATCH",
            Self::JoinWithoutInputs { .. } => "JOIN_WITHOUT_INPUTS",
            Self::MissingFinalResult => "MISSING_FINAL_RESULT",
            Self::NodeFailed { code, .. } => code.as_deref().unwrap_or("NODE_FAILED"),
            Self::JsTimeout { .. } => "JS_TIMEOUT",
            Self::TaskJoin(_) => "TASK_JOIN",
        }
    }
}
