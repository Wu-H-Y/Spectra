use std::{
    collections::{BTreeMap, HashMap},
    sync::Arc,
    time::{Duration, Instant, SystemTime, UNIX_EPOCH},
};

use tokio::sync::{Mutex, mpsc};

use super::{
    EngineContext, EngineError, EngineRunResult, EventCommand, NodeStats, RuleRateLimiter,
    RuntimeCookieJar, RuntimeKvStore, RuntimeValue,
    events::{preview_payload, send_event},
    graph::{
        NodeOutputs, RuntimeGraph, RuntimeNode, coerce_to_type_for_port, collect_inputs,
        execute_join, execute_passthrough,
    },
    result::{resolve_final_result, resolve_phase_results},
    value::stable_input_hash,
};
use crate::rules_ir::{Node, NodeKind, PortRef, RuleEnvelope};

type SharedNodeExecutionCache = Arc<Mutex<HashMap<NodeCacheKey, NodeOutputs>>>;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
pub(crate) struct NodeCacheKey {
    rule_version: String,
    node_id: String,
    input_hash: String,
}

#[derive(Debug, Clone)]
struct CachedNodeExecution {
    outputs: NodeOutputs,
    cache_hit: bool,
}

#[derive(Clone)]
pub(crate) struct RunNodeContext {
    pub(crate) rule_ir_version: String,
    pub(crate) context: Arc<EngineContext>,
    pub(crate) output_store: Arc<Mutex<HashMap<PortRef, Vec<RuntimeValue>>>>,
    pub(crate) node_stats: Arc<Mutex<BTreeMap<String, NodeStats>>>,
    pub(crate) execution_cache: SharedNodeExecutionCache,
    pub(crate) http_client: Arc<wreq::Client>,
    pub(crate) kv_store: Arc<RuntimeKvStore>,
    pub(crate) cookie_jar: Arc<RuntimeCookieJar>,
    pub(crate) rate_limiter: Option<Arc<RuleRateLimiter>>,
    pub(crate) event_tx: mpsc::Sender<EventCommand>,
}

const DEFAULT_CHANNEL_CAPACITY: usize = 8;

/// 执行已通过结构校验的规则图。
pub async fn execute_rule(
    rule: &RuleEnvelope,
    context: EngineContext,
) -> Result<EngineRunResult, EngineError> {
    let run_id = context.run_id.clone().unwrap_or_else(default_run_id);
    let trace_id = context.trace_id.clone();
    let channel_capacity = context.channel_capacity.unwrap_or(DEFAULT_CHANNEL_CAPACITY);
    let graph = RuntimeGraph::build(rule, channel_capacity);
    let node_stats = Arc::new(Mutex::new(BTreeMap::<String, NodeStats>::new()));
    let output_store = Arc::new(Mutex::new(HashMap::<PortRef, Vec<RuntimeValue>>::new()));
    let execution_cache = Arc::new(Mutex::new(HashMap::<NodeCacheKey, NodeOutputs>::new()));
    let http_client = Arc::new(
        wreq::Client::builder()
            .cookie_store(true)
            .build()
            .map_err(|error| EngineError::TaskJoin(format!("构建 HTTP 客户端失败：{error}")))?,
    );
    let kv_store = Arc::new(RuntimeKvStore::from_persisted_json(
        context.persisted_rule_kv_json.as_deref(),
    ));
    let cookie_jar = Arc::new(RuntimeCookieJar::from_persisted_json(
        context.persisted_cookie_jar_json.as_deref(),
    ));
    cookie_jar.hydrate_client(&http_client).await;
    let rate_limiter = rule
        .rate_limit
        .as_ref()
        .and_then(RuleRateLimiter::from_config)
        .map(Arc::new);
    let (event_tx, event_rx) = mpsc::channel(channel_capacity);

    let event_collector = tokio::spawn(super::events::collect_events(
        run_id.clone(),
        trace_id.clone(),
        event_rx,
    ));
    send_event(&event_tx, EventCommand::RunStarted).await;

    let shared_context = Arc::new(context);
    let run_node_context = RunNodeContext {
        rule_ir_version: rule.ir_version.clone(),
        context: shared_context,
        output_store: output_store.clone(),
        node_stats: node_stats.clone(),
        execution_cache: execution_cache.clone(),
        http_client: http_client.clone(),
        kv_store: kv_store.clone(),
        cookie_jar: cookie_jar.clone(),
        rate_limiter: rate_limiter.clone(),
        event_tx: event_tx.clone(),
    };

    let mut handles = Vec::with_capacity(graph.nodes.len());
    for runtime_node in graph.nodes {
        handles.push(tokio::spawn(run_node(
            runtime_node,
            run_node_context.clone(),
        )));
    }
    drop(run_node_context);

    let mut first_error = None;
    for handle in handles {
        match handle.await {
            Ok(Ok(())) => {}
            Ok(Err(error)) => {
                if first_error.is_none() {
                    first_error = Some(error);
                }
            }
            Err(error) => {
                if first_error.is_none() {
                    first_error = Some(EngineError::TaskJoin(error.to_string()));
                }
            }
        }
    }

    let success = first_error.is_none();
    send_event(&event_tx, EventCommand::RunFinished { success }).await;
    drop(event_tx);

    let events = event_collector
        .await
        .map_err(|error| EngineError::TaskJoin(error.to_string()))?;
    let node_stats = node_stats.lock().await.clone();
    let output_store = output_store.lock().await.clone();

    if let Some(error) = first_error {
        return Err(error);
    }

    let phase_results = resolve_phase_results(rule, &output_store)?;
    let final_result = resolve_final_result(rule, &phase_results, &output_store)?;

    Ok(EngineRunResult {
        run_id,
        final_result,
        phase_results,
        node_stats,
        events,
        rule_kv_json: kv_store.snapshot_rule_scope_json().await,
        cookie_jar_json: cookie_jar.snapshot_json().await,
    })
}

pub(crate) async fn run_node(
    runtime_node: RuntimeNode,
    shared: RunNodeContext,
) -> Result<(), EngineError> {
    send_event(
        &shared.event_tx,
        EventCommand::NodeStarted {
            node_id: runtime_node.node.id.clone(),
        },
    )
    .await;

    let started_at = Instant::now();
    let node_id = runtime_node.node.id.clone();
    let inputs: NodeOutputs = match collect_inputs(
        &runtime_node.node,
        runtime_node.input_receivers,
        &shared.context,
    )
    .await
    {
        Ok(inputs) => inputs,
        Err(error) => {
            emit_node_failure(
                &shared.event_tx,
                &shared.node_stats,
                &node_id,
                &error,
                started_at.elapsed(),
            )
            .await;
            return Err(error);
        }
    };

    let input_messages = inputs.values().map(Vec::len).sum();
    let cached_execution = match execute_node_with_cache(
        &shared.rule_ir_version,
        &runtime_node.node,
        &inputs,
        &shared.http_client,
        &shared.kv_store,
        &shared.cookie_jar,
        shared.rate_limiter.as_deref(),
        &shared.execution_cache,
        &shared.event_tx,
    )
    .await
    {
        Ok(execution) => execution,
        Err(error) => {
            emit_node_failure(
                &shared.event_tx,
                &shared.node_stats,
                &node_id,
                &error,
                started_at.elapsed(),
            )
            .await;
            return Err(error);
        }
    };

    let mut output_messages = 0;
    for output in &runtime_node.node.outputs {
        let Some(values) = cached_execution.outputs.get(&output.name) else {
            continue;
        };

        for value in values {
            store_output_value(
                &shared.output_store,
                &runtime_node.node.id,
                &output.name,
                value,
            )
            .await;
            output_messages += 1;

            let (payload_preview, payload_truncated) = preview_payload(value);
            send_event(
                &shared.event_tx,
                EventCommand::PortEmit {
                    node_id: runtime_node.node.id.clone(),
                    port: output.name.clone(),
                    payload_preview: Some(payload_preview),
                    payload_truncated,
                    cache_hit: cached_execution.cache_hit,
                },
            )
            .await;

            if let Some(senders) = runtime_node.output_senders.get(&output.name) {
                for sender in senders {
                    let _ = sender.send(value.clone()).await;
                }
            }
        }
    }

    let stats = NodeStats {
        input_messages,
        output_messages,
        error_count: 0,
        success: true,
        elapsed: started_at.elapsed(),
    };
    update_node_stats(&shared.node_stats, &runtime_node.node.id, stats).await;
    send_event(
        &shared.event_tx,
        EventCommand::NodeFinished {
            node_id: runtime_node.node.id.clone(),
            success: true,
        },
    )
    .await;

    Ok(())
}

async fn execute_node_semantics(
    node: &Node,
    inputs: &NodeOutputs,
    http_client: &Arc<wreq::Client>,
    kv_store: &Arc<RuntimeKvStore>,
    cookie_jar: &Arc<RuntimeCookieJar>,
    rate_limiter: Option<&RuleRateLimiter>,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<NodeOutputs, EngineError> {
    match node.kind {
        NodeKind::Input => Ok(inputs.clone()),
        NodeKind::Join => execute_join(node, inputs),
        NodeKind::Fetch => {
            super::nodes::fetch::execute(
                node,
                inputs,
                http_client,
                cookie_jar,
                rate_limiter,
                event_tx,
            )
            .await
        }
        NodeKind::Parse => super::nodes::parse::execute(node, inputs),
        NodeKind::Select => super::nodes::select::execute(node, inputs),
        NodeKind::Transform => super::nodes::transform::execute(node, inputs),
        NodeKind::MapToModel => super::nodes::map_to_model::execute(node, inputs),
        NodeKind::CachePut => {
            super::nodes::cache::execute_put(node, inputs, kv_store, event_tx).await
        }
        NodeKind::CacheGet => {
            super::nodes::cache::execute_get(node, inputs, kv_store, event_tx).await
        }
        NodeKind::CookiePut => {
            super::nodes::cookie::execute_put(node, inputs, http_client, cookie_jar, event_tx).await
        }
        NodeKind::CookieGet => {
            super::nodes::cookie::execute_get(node, inputs, cookie_jar, event_tx).await
        }
        _ => execute_passthrough(node, inputs),
    }
}

#[allow(clippy::too_many_arguments)]
async fn execute_node_with_cache(
    rule_ir_version: &str,
    node: &Node,
    inputs: &NodeOutputs,
    http_client: &Arc<wreq::Client>,
    kv_store: &Arc<RuntimeKvStore>,
    cookie_jar: &Arc<RuntimeCookieJar>,
    rate_limiter: Option<&RuleRateLimiter>,
    execution_cache: &SharedNodeExecutionCache,
    event_tx: &mpsc::Sender<EventCommand>,
) -> Result<CachedNodeExecution, EngineError> {
    let cache_key = build_node_cache_key(rule_ir_version, node, inputs);

    if let Some(key) = cache_key.as_ref()
        && let Some(outputs) = execution_cache.lock().await.get(key).cloned()
    {
        return Ok(CachedNodeExecution {
            outputs,
            cache_hit: true,
        });
    }

    let emitted_outputs = execute_node_semantics(
        node,
        inputs,
        http_client,
        kv_store,
        cookie_jar,
        rate_limiter,
        event_tx,
    )
    .await?;
    let outputs = finalize_node_outputs(node, emitted_outputs)?;

    if let Some(key) = cache_key {
        execution_cache.lock().await.insert(key, outputs.clone());
    }

    Ok(CachedNodeExecution {
        outputs,
        cache_hit: false,
    })
}

fn finalize_node_outputs(
    node: &Node,
    emitted_outputs: NodeOutputs,
) -> Result<NodeOutputs, EngineError> {
    let mut outputs = BTreeMap::new();

    for output in &node.outputs {
        let Some(values) = emitted_outputs.get(&output.name) else {
            continue;
        };

        let mut coerced_values = Vec::with_capacity(values.len());
        for value in values {
            coerced_values.push(coerce_to_type_for_port(
                &node.id,
                &output.name,
                value.clone(),
                &output.data_type,
            )?);
        }

        outputs.insert(output.name.clone(), coerced_values);
    }

    Ok(outputs)
}

fn build_node_cache_key(
    rule_ir_version: &str,
    node: &Node,
    inputs: &NodeOutputs,
) -> Option<NodeCacheKey> {
    if matches!(
        node.kind,
        NodeKind::CachePut
            | NodeKind::CacheGet
            | NodeKind::Fetch
            | NodeKind::CookiePut
            | NodeKind::CookieGet
    ) {
        return None;
    }

    let input_hash = stable_input_hash(inputs)?;
    Some(NodeCacheKey {
        rule_version: rule_ir_version.to_string(),
        node_id: node.id.clone(),
        input_hash,
    })
}

async fn emit_node_failure(
    event_tx: &mpsc::Sender<EventCommand>,
    node_stats: &Arc<Mutex<BTreeMap<String, NodeStats>>>,
    node_id: &str,
    error: &EngineError,
    elapsed: Duration,
) {
    update_node_stats(
        node_stats,
        node_id,
        NodeStats {
            input_messages: 0,
            output_messages: 0,
            error_count: 1,
            success: false,
            elapsed,
        },
    )
    .await;
    send_event(
        event_tx,
        EventCommand::NodeError {
            node_id: node_id.to_string(),
            port: None,
            message: error.to_string(),
            code: Some(error.code().to_string()),
        },
    )
    .await;
    send_event(
        event_tx,
        EventCommand::NodeFinished {
            node_id: node_id.to_string(),
            success: false,
        },
    )
    .await;
}

async fn store_output_value(
    output_store: &Arc<Mutex<HashMap<PortRef, Vec<RuntimeValue>>>>,
    node_id: &str,
    port_name: &str,
    value: &RuntimeValue,
) {
    let mut guard = output_store.lock().await;
    guard
        .entry(PortRef {
            node_id: node_id.to_string(),
            port_name: port_name.to_string(),
        })
        .or_default()
        .push(value.clone());
}

async fn update_node_stats(
    node_stats: &Arc<Mutex<BTreeMap<String, NodeStats>>>,
    node_id: &str,
    stats: NodeStats,
) {
    node_stats.lock().await.insert(node_id.to_string(), stats);
}

fn default_run_id() -> String {
    let millis = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis();
    format!("run-{millis}")
}
