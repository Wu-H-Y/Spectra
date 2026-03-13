use std::collections::BTreeMap;

use tokio::{sync::mpsc, time::sleep};
use wreq::{StatusCode, header::HeaderMap};

use super::{
    map_single_value_to_outputs, node_failure, normalize_param_value, optional_param,
    primary_input_value, reject_unknown_params,
};
use crate::{
    rules_engine::{
        EngineError, EventCommand, RuleRateLimiter, RuntimeCookieJar, RuntimeValue, emit_node_log,
        extract_domain_from_url,
    },
    rules_ir::{DataType, Node},
};

const CHALLENGE_REQUIRED_CODE: &str = "CHALLENGE_REQUIRED";

pub(crate) async fn execute(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
    http_client: &std::sync::Arc<wreq::Client>,
    cookie_jar: &std::sync::Arc<RuntimeCookieJar>,
    rate_limiter: Option<&RuleRateLimiter>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["method", "response", "url"])?;

    let method = optional_param(node, "method")
        .map(normalize_param_value)
        .unwrap_or_else(|| "get".to_string());
    if method != "get" {
        return Err(node_failure(
            node,
            format!("暂仅支持 GET，请求方法 `{method}` 无效"),
        ));
    }

    let url = if let Some(url) = optional_param(node, "url") {
        url.to_string()
    } else {
        match primary_input_value(node, inputs)? {
            RuntimeValue::Url(url) | RuntimeValue::Text(url) => url,
            other => {
                return Err(node_failure(
                    node,
                    format!(
                        "Fetch 节点需要 url/text 输入，实际为 `{}`",
                        other.type_label()
                    ),
                ));
            }
        }
    };

    let response_mode = optional_param(node, "response")
        .map(normalize_param_value)
        .unwrap_or_else(|| infer_response_mode(node));

    if let Some(limiter) = rate_limiter {
        while let Some(delay) = limiter.poll_delay().await {
            let wait_ms = delay.wait.as_millis();
            let period_ms = delay.period.as_millis();
            emit_node_log(
                event_tx,
                &node.id,
                "info",
                format!(
                    "触发规则限速，延迟请求 {wait_ms} ms（count={}, periodMs={period_ms}）",
                    delay.count
                ),
            )
            .await;
            sleep(delay.wait).await;
        }
    }

    cookie_jar
        .set_current_request_domain(extract_domain_from_url(&url))
        .await;

    if cookie_jar.cookie_header_for_url(&url).await.is_some() {
        emit_node_log(
            event_tx,
            &node.id,
            "info",
            format!("Fetch 自动附带 Cookie（url={url}）"),
        )
        .await;
    }

    let response = http_client
        .get(&url)
        .send()
        .await
        .map_err(|error| node_failure(node, format!("请求失败：{error}")))?;
    let status = response.status();
    let headers = response.headers().clone();
    cookie_jar.absorb_set_cookie_headers(&url, &headers).await;
    if !status.is_success() {
        let body = response.text().await.unwrap_or_default();
        if is_challenge_response(status, &headers, &body) {
            return Err(challenge_required_failure(node, status));
        }
        return Err(node_failure(node, format!("HTTP 状态码异常：{status}")));
    }

    let value = match response_mode.as_str() {
        "text" => RuntimeValue::Text(
            response
                .text()
                .await
                .map_err(|error| node_failure(node, format!("读取文本响应失败：{error}")))?,
        ),
        "html" => RuntimeValue::Html(
            response
                .text()
                .await
                .map_err(|error| node_failure(node, format!("读取 HTML 响应失败：{error}")))?,
        ),
        "json" => RuntimeValue::Json(
            response
                .json()
                .await
                .map_err(|error| node_failure(node, format!("读取 JSON 响应失败：{error}")))?,
        ),
        other => {
            return Err(node_failure(
                node,
                format!("不支持 response=`{other}`，仅支持 text/html/json"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn infer_response_mode(node: &Node) -> String {
    match node.outputs.first().map(|port| &port.data_type) {
        Some(DataType::Html) => "html".to_string(),
        Some(DataType::Json) => "json".to_string(),
        _ => "text".to_string(),
    }
}

fn challenge_required_failure(node: &Node, status: StatusCode) -> EngineError {
    EngineError::NodeFailed {
        node_id: node.id.clone(),
        message: format!(
            "检测到目标站点返回验证/挑战页面（HTTP {status}），已中止当前请求。当前版本暂不支持交互式会话处理，请先在浏览器确认站点可访问后再重试。"
        ),
        code: Some(CHALLENGE_REQUIRED_CODE.to_string()),
    }
}

fn is_challenge_response(status: StatusCode, headers: &HeaderMap, body: &str) -> bool {
    let has_challenge_status = matches!(
        status,
        StatusCode::FORBIDDEN | StatusCode::SERVICE_UNAVAILABLE
    );
    if !has_challenge_status {
        return false;
    }

    has_cf_mitigated_challenge(headers)
        || (body_contains_challenge_marker(body)
            && (has_header(headers, "cf-ray") || has_server_cloudflare(headers)))
}

fn has_cf_mitigated_challenge(headers: &HeaderMap) -> bool {
    headers
        .get("cf-mitigated")
        .and_then(|value| value.to_str().ok())
        .map(|value| value.eq_ignore_ascii_case("challenge"))
        .unwrap_or(false)
}

fn has_header(headers: &HeaderMap, name: &str) -> bool {
    headers.contains_key(name)
}

fn has_server_cloudflare(headers: &HeaderMap) -> bool {
    headers
        .get("server")
        .and_then(|value| value.to_str().ok())
        .map(|server| server.to_ascii_lowercase().contains("cloudflare"))
        .unwrap_or(false)
}

fn body_contains_challenge_marker(body: &str) -> bool {
    let normalized = body.to_ascii_lowercase();
    [
        "attention required",
        "attention-required",
        "captcha",
        "challenge",
        "checking your browser",
        "verify you are human",
        "cf-chl",
    ]
    .iter()
    .any(|marker| normalized.contains(marker))
}
