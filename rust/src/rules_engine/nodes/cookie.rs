use std::{collections::BTreeMap, sync::Arc};

use tokio::sync::mpsc;

use super::{
    map_single_value_to_outputs, node_failure, optional_param, primary_input_value,
    reject_unknown_params, required_param,
};
use crate::{
    rules_engine::{
        EngineError, EventCommand, RuntimeCookieJar, RuntimeValue, current_unix_timestamp_secs,
        emit_node_log,
        normalize_cookie_domain, normalize_cookie_path,
    },
    rules_ir::Node,
};

pub(crate) async fn execute_put(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
    http_client: &Arc<wreq::Client>,
    cookie_jar: &Arc<RuntimeCookieJar>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(
        node,
        &[
            "name",
            "value",
            "domain",
            "path",
            "secure",
            "httpOnly",
            "allowDomains",
            "expires",
        ],
    )?;

    let name = required_param(node, "name")?.trim();
    if name.is_empty() {
        return Err(node_failure(node, "CookiePut 参数 name 不能为空"));
    }

    let value = match optional_param(node, "value") {
        Some(value) => value.to_string(),
        None => runtime_value_to_cookie_string(primary_input_value(node, inputs)?),
    };

    let domain = resolve_cookie_domain_for_put(node, cookie_jar).await?;
    let path = normalize_cookie_path(optional_param(node, "path").unwrap_or("/"));
    let secure = parse_bool_param(node, "secure")?.unwrap_or(false);
    let http_only = parse_bool_param(node, "httpOnly")?.unwrap_or(false);
    let expires_at_unix = parse_expires_param(node)?;

    cookie_jar
        .put_entry(crate::rules_engine::PersistedCookieEntry {
            name: name.to_string(),
            value: value.clone(),
            domain: domain.clone(),
            path: path.clone(),
            secure,
            http_only,
            expires_at_unix,
        })
        .await;
    let scheme = if secure { "https" } else { "http" };
    let target_url = format!("{scheme}://{domain}{path}");
    let parsed_url = target_url
        .parse::<wreq::Url>()
        .map_err(|error| node_failure(node, format!("CookiePut 目标 URL 非法：{error}")))?;
    let mut raw_cookie = format!("{name}={value}; Domain={domain}; Path={path}");
    if let Some(expires_at_unix) = expires_at_unix {
        let max_age = expires_at_unix.saturating_sub(current_unix_timestamp_secs());
        raw_cookie.push_str(format!("; Max-Age={max_age}").as_str());
    }
    if secure {
        raw_cookie.push_str("; Secure");
    }
    if http_only {
        raw_cookie.push_str("; HttpOnly");
    }
    let header = wreq::header::HeaderValue::from_str(raw_cookie.as_str())
        .map_err(|error| node_failure(node, format!("CookiePut 头部构造失败：{error}")))?;
    http_client.set_cookies(&parsed_url, [header]);

    emit_node_log(
        event_tx,
        &node.id,
        "info",
        format!("Cookie 写入成功（name={name}, domain={domain}, path={path}）"),
    )
    .await;

    let passthrough = node
        .inputs
        .first()
        .and_then(|port| inputs.get(&port.name))
        .and_then(|values| values.last())
        .cloned();
    Ok(map_single_value_to_outputs(
        node,
        passthrough.unwrap_or(RuntimeValue::Text(value)),
    ))
}

pub(crate) async fn execute_get(
    node: &Node,
    _inputs: &BTreeMap<String, Vec<RuntimeValue>>,
    cookie_jar: &Arc<RuntimeCookieJar>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["name", "domain", "path", "default"])?;

    let name = required_param(node, "name")?.trim();
    if name.is_empty() {
        return Err(node_failure(node, "CookieGet 参数 name 不能为空"));
    }

    let domain = resolve_cookie_domain_for_get(node, cookie_jar).await?;
    let path = optional_param(node, "path").map(normalize_cookie_path);

    if let Some(value) = cookie_jar
        .get_cookie_value(name, domain.as_deref(), path.as_deref())
        .await
    {
        emit_node_log(
            event_tx,
            &node.id,
            "info",
            format!("Cookie 命中（name={name}）"),
        )
        .await;
        return Ok(map_single_value_to_outputs(node, RuntimeValue::Text(value)));
    }

    emit_node_log(
        event_tx,
        &node.id,
        "info",
        format!("Cookie 未命中（name={name}）"),
    )
    .await;

    if let Some(default_value) = optional_param(node, "default") {
        return Ok(map_single_value_to_outputs(
            node,
            RuntimeValue::Text(default_value.to_string()),
        ));
    }

    Ok(BTreeMap::new())
}

async fn resolve_cookie_domain_for_put(
    node: &Node,
    cookie_jar: &Arc<RuntimeCookieJar>,
) -> Result<String, EngineError> {
    let requested_domain = optional_param(node, "domain")
        .map(normalize_cookie_domain)
        .unwrap_or_default();

    if requested_domain.is_empty() || requested_domain == "$current" {
        return cookie_jar
            .current_request_domain()
            .await
            .ok_or_else(|| node_failure(node, "CookiePut 默认域依赖当前请求域，但当前运行还没有 Fetch 域上下文"));
    }

    if !is_valid_cookie_domain(&requested_domain) {
        return Err(node_failure(
            node,
            format!("CookiePut 参数 domain=`{requested_domain}` 非法"),
        ));
    }

    let allowlist = parse_allow_domains(optional_param(node, "allowDomains"));
    if !allowlist.iter().any(|domain| domain == &requested_domain) {
        return Err(node_failure(
            node,
            "CookiePut 跨域写入默认禁止；仅允许当前请求域（domain 省略或 $current）或 allowDomains 白名单",
        ));
    }

    Ok(requested_domain)
}

async fn resolve_cookie_domain_for_get(
    node: &Node,
    cookie_jar: &Arc<RuntimeCookieJar>,
) -> Result<Option<String>, EngineError> {
    let requested_domain = optional_param(node, "domain")
        .map(normalize_cookie_domain)
        .unwrap_or_default();
    if requested_domain.is_empty() || requested_domain == "$current" {
        return Ok(cookie_jar.current_request_domain().await);
    }
    if !is_valid_cookie_domain(&requested_domain) {
        return Err(node_failure(
            node,
            format!("CookieGet 参数 domain=`{requested_domain}` 非法"),
        ));
    }
    Ok(Some(requested_domain))
}

fn parse_allow_domains(value: Option<&str>) -> Vec<String> {
    value
        .unwrap_or_default()
        .split(',')
        .map(normalize_cookie_domain)
        .filter(|item| !item.is_empty())
        .collect::<Vec<_>>()
}

fn parse_bool_param(node: &Node, key: &str) -> Result<Option<bool>, EngineError> {
    let Some(raw) = optional_param(node, key) else {
        return Ok(None);
    };

    match raw.trim().to_ascii_lowercase().as_str() {
        "true" | "1" | "yes" => Ok(Some(true)),
        "false" | "0" | "no" => Ok(Some(false)),
        _ => Err(node_failure(
            node,
            format!("{key} 仅支持 true/false（可选 1/0/yes/no）"),
        )),
    }
}

fn parse_expires_param(node: &Node) -> Result<Option<i64>, EngineError> {
    let Some(raw) = optional_param(node, "expires") else {
        return Ok(None);
    };

    let expires_at_unix = raw
        .trim()
        .parse::<i64>()
        .map_err(|_| node_failure(node, "expires 必须是 Unix 秒级时间戳（整数）"))?;
    if expires_at_unix <= 0 {
        return Err(node_failure(node, "expires 必须是 Unix 秒级时间戳（> 0）"));
    }

    Ok(Some(expires_at_unix))
}

fn runtime_value_to_cookie_string(value: RuntimeValue) -> String {
    match value {
        RuntimeValue::Text(text) | RuntimeValue::Html(text) | RuntimeValue::Url(text) => text,
        RuntimeValue::Json(value) => value.to_string(),
        RuntimeValue::List(values) => values
            .into_iter()
            .map(runtime_value_to_cookie_string)
            .collect::<Vec<_>>()
            .join(","),
        RuntimeValue::Record(fields) => serde_json::to_string(&fields).unwrap_or_default(),
        RuntimeValue::NormalizedModel(model) => serde_json::to_string(&model).unwrap_or_default(),
    }
}

fn is_valid_cookie_domain(domain: &str) -> bool {
    if domain.is_empty() || domain.len() > 253 {
        return false;
    }
    if domain.contains(['/', ':', ' ']) {
        return false;
    }

    domain.split('.').all(|label| {
        !label.is_empty()
            && label.len() <= 63
            && !label.starts_with('-')
            && !label.ends_with('-')
            && label.chars().all(|char| char.is_ascii_alphanumeric() || char == '-')
    })
}
