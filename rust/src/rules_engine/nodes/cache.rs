use std::{collections::BTreeMap, sync::Arc};

use tokio::sync::mpsc;

use super::{
    node_failure, optional_param, primary_input_value, reject_unknown_params, required_param,
};
use crate::{
    rules_engine::{
        DEFAULT_CACHE_VALUE_MAX_BYTES, EngineError, EventCommand, MAX_CACHE_VALUE_BYTES_LIMIT,
        RuntimeKvStore, RuntimeValue, emit_node_log, parse_cache_scope,
    },
    rules_ir::Node,
};

pub(crate) async fn execute_put(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
    kv_store: &Arc<RuntimeKvStore>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["key", "scope", "maxValueBytes"])?;

    let key = required_param(node, "key")?.trim();
    if key.is_empty() {
        return Err(node_failure(node, "CachePut 参数 key 不能为空"));
    }

    let scope = parse_scope_param(node)?;
    let max_value_bytes = parse_max_value_bytes(node)?;
    let value = primary_input_value(node, inputs)?;

    let value_bytes = kv_store
        .put(scope, key.to_string(), value.clone(), max_value_bytes)
        .await
        .map_err(|actual_bytes| {
            node_failure(
                node,
                format!("CachePut 存储值大小超限：{actual_bytes} bytes > {max_value_bytes} bytes"),
            )
        })?;

    emit_node_log(
        event_tx,
        &node.id,
        "info",
        format!(
            "缓存写入成功（scope={}, key={}, bytes={value_bytes}）",
            scope_label(scope),
            key
        ),
    )
    .await;

    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        outputs.insert(output.name.clone(), vec![value.clone()]);
    }
    Ok(outputs)
}

pub(crate) async fn execute_get(
    node: &Node,
    _inputs: &BTreeMap<String, Vec<RuntimeValue>>,
    kv_store: &Arc<RuntimeKvStore>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["key", "scope", "default"])?;

    let key = required_param(node, "key")?.trim();
    if key.is_empty() {
        return Err(node_failure(node, "CacheGet 参数 key 不能为空"));
    }

    let scope = parse_scope_param(node)?;

    if let Some(value) = kv_store.get(scope, key).await {
        emit_node_log(
            event_tx,
            &node.id,
            "info",
            format!("缓存命中（scope={}, key={}）", scope_label(scope), key),
        )
        .await;

        let mut outputs = BTreeMap::new();
        for output in &node.outputs {
            outputs.insert(output.name.clone(), vec![value.clone()]);
        }
        return Ok(outputs);
    }

    emit_node_log(
        event_tx,
        &node.id,
        "info",
        format!("缓存未命中（scope={}, key={}）", scope_label(scope), key),
    )
    .await;

    if let Some(default_value) = optional_param(node, "default") {
        let mut outputs = BTreeMap::new();
        for output in &node.outputs {
            outputs.insert(
                output.name.clone(),
                vec![RuntimeValue::Text(default_value.to_string())],
            );
        }
        return Ok(outputs);
    }

    Ok(BTreeMap::new())
}

fn parse_scope_param(node: &Node) -> Result<crate::rules_engine::CacheScope, EngineError> {
    let scope = optional_param(node, "scope").unwrap_or("run");
    parse_cache_scope(scope).ok_or_else(|| {
        node_failure(
            node,
            format!("Cache 节点参数 scope=`{scope}` 无效，仅支持 run/rule"),
        )
    })
}

fn parse_max_value_bytes(node: &Node) -> Result<usize, EngineError> {
    let Some(raw) = optional_param(node, "maxValueBytes") else {
        return Ok(DEFAULT_CACHE_VALUE_MAX_BYTES);
    };

    let parsed = raw
        .trim()
        .parse::<usize>()
        .map_err(|_| node_failure(node, "CachePut 参数 maxValueBytes 必须是整数"))?;
    if parsed == 0 || parsed > MAX_CACHE_VALUE_BYTES_LIMIT {
        return Err(node_failure(
            node,
            format!("CachePut 参数 maxValueBytes 必须在 1..={MAX_CACHE_VALUE_BYTES_LIMIT}"),
        ));
    }

    Ok(parsed)
}

fn scope_label(scope: crate::rules_engine::CacheScope) -> &'static str {
    match scope {
        crate::rules_engine::CacheScope::Run => "run",
        crate::rules_engine::CacheScope::Rule => "rule",
    }
}
