use std::time::{SystemTime, UNIX_EPOCH};

use flutter_rust_bridge::frb;

use crate::{
    rules_engine::{
        EngineContext as RulesEngineContext, EngineError, execute_rule as run_engine_rule,
    },
    rules_ir::{Diagnostic, RuleEnvelope},
    rules_validate::validate_rule as validate_rule_impl,
};

const CODE_INVALID_RULE_JSON: &str = "INVALID_RULE_JSON";
const CODE_INVALID_CHANNEL_CAPACITY: &str = "INVALID_CHANNEL_CAPACITY";
const CODE_VALIDATION_FAILED: &str = "VALIDATION_FAILED";

/// 提供最小 FRB 连通性探针。
#[frb(sync)]
pub fn ping() -> bool {
    true
}

/// Flutter 可消费的结构化诊断。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FfiDiagnostic {
    /// 稳定错误码。
    pub code: String,
    /// 诊断路径。
    pub path: String,
    /// 人类可读信息。
    pub message: String,
    /// 可选节点 ID。
    pub node_id: Option<String>,
}

/// 校验结果。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FfiValidationResult {
    /// 当前规则是否通过校验。
    pub valid: bool,
    /// 结构化诊断列表。
    pub diagnostics: Vec<FfiDiagnostic>,
}

/// 最小执行上下文。
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct FfiExecuteContext {
    /// 可选运行 ID。
    pub run_id: Option<String>,
    /// 可选 trace ID。
    pub trace_id: Option<String>,
    /// 可选边通道容量。
    pub channel_capacity: Option<i32>,
    /// 规则标识，用于 rule 级缓存隔离。
    pub rule_id: Option<String>,
    /// 规则级缓存快照（JSON）。
    pub rule_kv_json: Option<String>,
    /// 规则级 CookieJar 快照（JSON）。
    pub cookie_jar_json: Option<String>,
}

/// 结构化执行错误。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FfiExecuteError {
    /// 稳定错误码。
    pub code: String,
    /// 人类可读信息。
    pub message: String,
    /// 结构化诊断。
    pub diagnostics: Vec<FfiDiagnostic>,
}

/// 执行响应。
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct FfiExecuteResponse {
    /// 运行 ID；解析失败时也会尽量返回。
    pub run_id: Option<String>,
    /// 最终结果的 JSON 文本；若无结果或不可序列化则为 `None`。
    pub initial_result_json: Option<String>,
    /// 结构化错误。
    pub error: Option<FfiExecuteError>,
    /// 规则级缓存快照（JSON）。
    pub rule_kv_json: Option<String>,
    /// 规则级 CookieJar 快照（JSON）。
    pub cookie_jar_json: Option<String>,
}

/// 对规则 JSON 做结构校验。
#[frb(sync)]
pub fn validate_rule(envelope_json: String) -> FfiValidationResult {
    let rule = match parse_rule(&envelope_json) {
        Ok(rule) => rule,
        Err(diagnostic) => return FfiValidationResult::invalid(vec![diagnostic]),
    };

    let diagnostics = validate_rule_impl(&rule)
        .into_iter()
        .map(FfiDiagnostic::from_rules_diagnostic)
        .collect::<Vec<_>>();

    FfiValidationResult {
        valid: diagnostics.is_empty(),
        diagnostics,
    }
}

/// 执行规则并返回运行 ID 与可选结果 JSON。
#[frb]
pub async fn execute_rule(
    envelope_json: String,
    context: Option<FfiExecuteContext>,
) -> FfiExecuteResponse {
    let run_id = context
        .as_ref()
        .and_then(|value| value.run_id.clone())
        .unwrap_or_else(default_run_id);

    let rule = match parse_rule(&envelope_json) {
        Ok(rule) => rule,
        Err(diagnostic) => {
            return FfiExecuteResponse::error(
                Some(run_id),
                diagnostic.code.clone(),
                diagnostic.message.clone(),
                vec![diagnostic],
            );
        }
    };

    let diagnostics = validate_rule_impl(&rule)
        .into_iter()
        .map(FfiDiagnostic::from_rules_diagnostic)
        .collect::<Vec<_>>();
    if !diagnostics.is_empty() {
        return FfiExecuteResponse::error(
            Some(run_id),
            CODE_VALIDATION_FAILED.to_string(),
            "规则校验失败".to_string(),
            diagnostics,
        );
    }

    let engine_context = match build_engine_context(context, &run_id) {
        Ok(engine_context) => engine_context,
        Err(error) => return FfiExecuteResponse::from_error(Some(run_id), error),
    };

    match run_engine_rule(&rule, engine_context).await {
        Ok(result) => FfiExecuteResponse {
            run_id: Some(result.run_id),
            initial_result_json: result
                .final_result
                .as_ref()
                .and_then(|value| serde_json::to_string(value).ok()),
            error: None,
            rule_kv_json: result.rule_kv_json,
            cookie_jar_json: result.cookie_jar_json,
        },
        Err(error) => FfiExecuteResponse::from_error(Some(run_id), map_engine_error(error)),
    }
}

impl FfiDiagnostic {
    fn from_rules_diagnostic(diagnostic: Diagnostic) -> Self {
        Self {
            code: diagnostic.code,
            path: diagnostic.path.unwrap_or_default(),
            message: diagnostic.message,
            node_id: diagnostic.node_id,
        }
    }

    fn new(code: impl Into<String>, path: impl Into<String>, message: impl Into<String>) -> Self {
        Self {
            code: code.into(),
            path: path.into(),
            message: message.into(),
            node_id: None,
        }
    }
}

impl FfiValidationResult {
    fn invalid(diagnostics: Vec<FfiDiagnostic>) -> Self {
        Self {
            valid: false,
            diagnostics,
        }
    }
}

impl FfiExecuteResponse {
    fn error(
        run_id: Option<String>,
        code: String,
        message: String,
        diagnostics: Vec<FfiDiagnostic>,
    ) -> Self {
        Self {
            run_id,
            initial_result_json: None,
            error: Some(FfiExecuteError {
                code,
                message,
                diagnostics,
            }),
            rule_kv_json: None,
            cookie_jar_json: None,
        }
    }

    fn from_error(run_id: Option<String>, error: FfiExecuteError) -> Self {
        Self {
            run_id,
            initial_result_json: None,
            error: Some(error),
            rule_kv_json: None,
            cookie_jar_json: None,
        }
    }
}

fn parse_rule(envelope_json: &str) -> Result<RuleEnvelope, FfiDiagnostic> {
    serde_json::from_str(envelope_json).map_err(|error| {
        FfiDiagnostic::new(
            CODE_INVALID_RULE_JSON,
            "envelopeJson",
            format!("规则 JSON 解析失败: {error}"),
        )
    })
}

fn build_engine_context(
    context: Option<FfiExecuteContext>,
    run_id: &str,
) -> Result<RulesEngineContext, FfiExecuteError> {
    let mut engine_context = RulesEngineContext {
        run_id: Some(run_id.to_string()),
        ..RulesEngineContext::default()
    };

    if let Some(context) = context {
        engine_context.trace_id = context.trace_id;
        engine_context.rule_id = context.rule_id;
        engine_context.persisted_rule_kv_json = context.rule_kv_json;
        engine_context.persisted_cookie_jar_json = context.cookie_jar_json;

        if let Some(channel_capacity) = context.channel_capacity {
            if channel_capacity <= 0 {
                return Err(FfiExecuteError {
                    code: CODE_INVALID_CHANNEL_CAPACITY.to_string(),
                    message: "channelCapacity 必须大于 0".to_string(),
                    diagnostics: vec![FfiDiagnostic::new(
                        CODE_INVALID_CHANNEL_CAPACITY,
                        "context.channelCapacity",
                        "channelCapacity 必须大于 0",
                    )],
                });
            }

            engine_context.channel_capacity = Some(channel_capacity as usize);
        }
    }

    Ok(engine_context)
}

fn map_engine_error(error: EngineError) -> FfiExecuteError {
    let code = engine_error_code(&error);
    FfiExecuteError {
        code: code.clone(),
        message: error.to_string(),
        diagnostics: engine_error_diagnostics(&error, &code),
    }
}

fn engine_error_code(error: &EngineError) -> String {
    error.code().to_string()
}

fn engine_error_diagnostics(error: &EngineError, code: &str) -> Vec<FfiDiagnostic> {
    let node_id = match error {
        EngineError::MissingInput { node_id, .. }
        | EngineError::TypeMismatch { node_id, .. }
        | EngineError::JoinWithoutInputs { node_id }
        | EngineError::NodeFailed { node_id, .. }
        | EngineError::JsTimeout { node_id, .. } => Some(node_id.clone()),
        EngineError::MissingFinalResult | EngineError::TaskJoin(_) => None,
    };

    vec![FfiDiagnostic {
        code: code.to_string(),
        path: String::new(),
        message: error.to_string(),
        node_id,
    }]
}

fn default_run_id() -> String {
    let millis = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis();
    format!("run-{millis}")
}

#[cfg(test)]
mod tests {
    use super::{
        CODE_INVALID_RULE_JSON, CODE_VALIDATION_FAILED, FfiExecuteContext,
        engine_error_diagnostics, execute_rule, map_engine_error, validate_rule,
    };
    use crate::{
        rules_engine::EngineError,
        rules_ir::{Capabilities, Graph, Metadata, RuleEnvelope},
    };

    fn empty_rule_json() -> String {
        serde_json::to_string(&RuleEnvelope {
            ir_version: "1.0.0".to_string(),
            metadata: Metadata {
                rule_id: "ffi.empty".to_string(),
                name: "空规则".to_string(),
                description: Some("用于验证最小 execute 路径".to_string()),
            },
            graph: Graph {
                nodes: Vec::new(),
                edges: Vec::new(),
                phase_entrypoints: Default::default(),
                metadata: None,
                layout: None,
            },
            normalized_outputs: Default::default(),
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
        })
        .expect("空规则应可序列化")
    }

    #[test]
    fn validate_rule_returns_structured_parse_error() {
        let result = validate_rule("{invalid json".to_string());

        assert!(!result.valid);
        assert_eq!(result.diagnostics.len(), 1);
        assert_eq!(result.diagnostics[0].code, CODE_INVALID_RULE_JSON);
        assert_eq!(result.diagnostics[0].path, "envelopeJson");
    }

    #[test]
    fn validate_rule_returns_fixture_diagnostics() {
        let result =
            validate_rule(include_str!("../../../fixtures/ir_v1_invalid_edge.json").to_string());

        assert!(!result.valid);
        assert!(result.diagnostics.iter().any(|diagnostic| {
            diagnostic.code == "UNKNOWN_NODE"
                && diagnostic.path == "graph.edges[1].from.nodeId"
                && diagnostic.node_id.as_deref() == Some("ghost_node")
        }));
    }

    #[tokio::test]
    async fn execute_rule_returns_run_id_for_empty_rule() {
        let response = execute_rule(
            empty_rule_json(),
            Some(FfiExecuteContext {
                run_id: Some("ffi-run-empty".to_string()),
                ..FfiExecuteContext::default()
            }),
        )
        .await;

        assert_eq!(response.run_id.as_deref(), Some("ffi-run-empty"));
        assert!(response.error.is_none());
        assert!(response.initial_result_json.is_none());
        assert!(response.rule_kv_json.is_none());
        assert!(response.cookie_jar_json.is_none());
    }

    #[tokio::test]
    async fn execute_rule_returns_structured_validation_error() {
        let response = execute_rule(
            include_str!("../../../fixtures/ir_v1_invalid_edge.json").to_string(),
            None,
        )
        .await;

        let error = response.error.expect("校验失败应返回结构化错误");
        assert_eq!(error.code, CODE_VALIDATION_FAILED);
        assert!(response.run_id.is_some());
        assert!(error.diagnostics.iter().any(|diagnostic| {
            diagnostic.code == "UNKNOWN_NODE" && diagnostic.path == "graph.edges[1].from.nodeId"
        }));
    }

    #[test]
    fn map_engine_error_preserves_custom_node_code_and_diagnostic() {
        let error = map_engine_error(EngineError::NodeFailed {
            node_id: "fetch".to_string(),
            message: "检测到目标站点返回验证/挑战页面，已中止当前请求。".to_string(),
            code: Some("CHALLENGE_REQUIRED".to_string()),
        });

        assert_eq!(error.code, "CHALLENGE_REQUIRED");
        assert!(error.message.contains("节点 `fetch` 执行失败"));
        assert_eq!(error.diagnostics.len(), 1);
        assert_eq!(error.diagnostics[0].code, "CHALLENGE_REQUIRED");
        assert_eq!(error.diagnostics[0].node_id.as_deref(), Some("fetch"));
    }

    #[test]
    fn engine_error_diagnostics_include_node_id_when_available() {
        let diagnostics = engine_error_diagnostics(
            &EngineError::JsTimeout {
                node_id: "js".to_string(),
                message: "timeout".to_string(),
            },
            "JS_TIMEOUT",
        );

        assert_eq!(diagnostics.len(), 1);
        assert_eq!(diagnostics[0].code, "JS_TIMEOUT");
        assert_eq!(diagnostics[0].node_id.as_deref(), Some("js"));
    }
}
