use std::{
    collections::{BTreeMap, HashMap, VecDeque},
    fmt,
    sync::Arc,
    time::{Duration, Instant, SystemTime, UNIX_EPOCH},
};

use serde_json::{Value as JsonValue, json};
use tokio::sync::{Mutex, mpsc};

use crate::rules_ir::{
    DataType, LifecyclePhase, Node, NodeEvent, NodeKind, NormalizedModel, PortRef, RuleEnvelope,
    RuleRateLimit,
};

mod nodes;

const DEFAULT_CHANNEL_CAPACITY: usize = 8;
const PAYLOAD_PREVIEW_LIMIT_BYTES: usize = 1024;
pub(crate) const DEFAULT_CACHE_VALUE_MAX_BYTES: usize = 65_536;
pub(crate) const MAX_CACHE_VALUE_BYTES_LIMIT: usize = 262_144;

#[derive(Debug)]
struct RuleRateLimiter {
    count: usize,
    period: Duration,
    timestamps: Mutex<VecDeque<Instant>>,
}

#[derive(Debug, Clone, Copy)]
struct RateLimitDelayInfo {
    wait: Duration,
    count: usize,
    period: Duration,
}

impl RuleRateLimiter {
    fn from_config(config: &RuleRateLimit) -> Option<Self> {
        if config.count == 0 || config.period_ms == 0 {
            return None;
        }

        Some(Self {
            count: config.count as usize,
            period: Duration::from_millis(config.period_ms),
            timestamps: Mutex::new(VecDeque::new()),
        })
    }

    async fn poll_delay(&self) -> Option<RateLimitDelayInfo> {
        loop {
            let wait = {
                let mut guard = self.timestamps.lock().await;
                let now = Instant::now();

                while let Some(timestamp) = guard.front().copied() {
                    if now.duration_since(timestamp) >= self.period {
                        guard.pop_front();
                    } else {
                        break;
                    }
                }

                if guard.len() < self.count {
                    guard.push_back(now);
                    return None;
                }

                let Some(oldest) = guard.front().copied() else {
                    continue;
                };
                self.period.saturating_sub(now.duration_since(oldest))
            };

            if wait.is_zero() {
                tokio::task::yield_now().await;
                continue;
            }

            return Some(RateLimitDelayInfo {
                wait,
                count: self.count,
                period: self.period,
            });
        }
    }
}

/// 规则运行输入。
#[derive(Debug, Clone, Default)]
pub struct EngineContext {
    /// 按阶段注入的默认输入。
    pub phase_inputs: BTreeMap<LifecyclePhase, RuntimeValue>,
    /// 按端口注入的精确输入。
    pub port_inputs: HashMap<PortRef, RuntimeValue>,
    /// 可选运行 ID。
    pub run_id: Option<String>,
    /// 可选 trace ID。
    pub trace_id: Option<String>,
    /// 边通道容量，未设置时使用默认值。
    pub channel_capacity: Option<usize>,
    /// 规则标识，用于 rule 级缓存隔离。
    pub rule_id: Option<String>,
    /// 规则级缓存的持久化快照（JSON 字符串）。
    pub persisted_rule_kv_json: Option<String>,
    /// 规则级 CookieJar 的持久化快照（JSON 字符串）。
    pub persisted_cookie_jar_json: Option<String>,
}

/// 规则运行结果。
#[derive(Debug, Clone, PartialEq)]
pub struct EngineRunResult {
    /// 运行 ID。
    pub run_id: String,
    /// 运行的最终结果。
    pub final_result: Option<RuntimeValue>,
    /// 按阶段聚合的结果。
    pub phase_results: BTreeMap<LifecyclePhase, RuntimeValue>,
    /// 每个节点的运行统计。
    pub node_stats: BTreeMap<String, NodeStats>,
    /// 运行过程中产生的事件。
    pub events: Vec<NodeEvent>,
    /// rule 级缓存快照（JSON 字符串，可用于持久化）。
    pub rule_kv_json: Option<String>,
    /// 规则级 CookieJar 快照（JSON 字符串，可用于持久化）。
    pub cookie_jar_json: Option<String>,
}

/// 节点运行统计。
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct NodeStats {
    /// 输入消息条数。
    pub input_messages: usize,
    /// 输出消息条数。
    pub output_messages: usize,
    /// 错误条数。
    pub error_count: usize,
    /// 节点是否成功结束。
    pub success: bool,
    /// 节点耗时。
    pub elapsed: Duration,
}

type NodeOutputs = BTreeMap<String, Vec<RuntimeValue>>;
type SharedNodeExecutionCache = Arc<Mutex<HashMap<NodeCacheKey, NodeOutputs>>>;

#[derive(Debug, Clone, PartialEq, Eq, Hash)]
struct NodeCacheKey {
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
struct RunNodeContext {
    rule_ir_version: String,
    context: Arc<EngineContext>,
    output_store: Arc<Mutex<HashMap<PortRef, Vec<RuntimeValue>>>>,
    node_stats: Arc<Mutex<BTreeMap<String, NodeStats>>>,
    execution_cache: SharedNodeExecutionCache,
    http_client: Arc<wreq::Client>,
    kv_store: Arc<RuntimeKvStore>,
    cookie_jar: Arc<RuntimeCookieJar>,
    rate_limiter: Option<Arc<RuleRateLimiter>>,
    event_tx: mpsc::Sender<EventCommand>,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum CacheScope {
    Run,
    Rule,
}

#[derive(Debug)]
pub(crate) struct RuntimeKvStore {
    run_scope: Mutex<HashMap<String, RuntimeValue>>,
    rule_scope: Mutex<HashMap<String, RuntimeValue>>,
}

#[derive(Debug)]
pub(crate) struct RuntimeCookieJar {
    current_request_domain: Mutex<Option<String>>,
    entries: Mutex<Vec<PersistedCookieEntry>>,
}

#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize, serde::Deserialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct PersistedCookieEntry {
    name: String,
    value: String,
    domain: String,
    path: String,
    secure: bool,
    http_only: bool,
    #[serde(default)]
    expires_at_unix: Option<i64>,
}

/// 运行时负载值。
#[derive(Debug, Clone, PartialEq)]
pub enum RuntimeValue {
    Text(String),
    Html(String),
    Json(JsonValue),
    Url(String),
    List(Vec<RuntimeValue>),
    Record(BTreeMap<String, RuntimeValue>),
    NormalizedModel(Box<NormalizedModel>),
}

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

    let event_collector = tokio::spawn(collect_events(run_id.clone(), trace_id.clone(), event_rx));
    send_event(&event_tx, EventCommand::RunStarted).await;

    let shared_context = Arc::new(context);
    let run_node_context = RunNodeContext {
        rule_ir_version: rule.ir_version.clone(),
        context: shared_context.clone(),
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

async fn run_node(runtime_node: RuntimeNode, shared: RunNodeContext) -> Result<(), EngineError> {
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

async fn collect_inputs(
    node: &Node,
    mut input_receivers: HashMap<String, Vec<mpsc::Receiver<RuntimeValue>>>,
    context: &EngineContext,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    if matches!(node.kind, NodeKind::Input) {
        return resolve_input_node_outputs(node, context);
    }

    let mut collected = BTreeMap::new();
    for input in &node.inputs {
        let mut values = Vec::new();
        if let Some(receivers) = input_receivers.remove(&input.name) {
            for mut receiver in receivers {
                while let Some(value) = receiver.recv().await {
                    values.push(value);
                }
            }
        }

        if values.is_empty() && !input.optional {
            return Err(EngineError::MissingInput {
                node_id: node.id.clone(),
                port_name: input.name.clone(),
            });
        }

        collected.insert(input.name.clone(), values);
    }

    Ok(collected)
}

fn resolve_input_node_outputs(
    node: &Node,
    context: &EngineContext,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let mut outputs = BTreeMap::new();

    for output in &node.outputs {
        let port_ref = PortRef {
            node_id: node.id.clone(),
            port_name: output.name.clone(),
        };
        let value = context
            .port_inputs
            .get(&port_ref)
            .cloned()
            .or_else(|| context.phase_inputs.get(&node.phase).cloned())
            .ok_or_else(|| EngineError::MissingInput {
                node_id: node.id.clone(),
                port_name: output.name.clone(),
            })?;

        let coerced = coerce_to_type(value, &output.data_type)?;
        outputs.insert(output.name.clone(), vec![coerced]);
    }

    Ok(outputs)
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
            nodes::fetch::execute(
                node,
                inputs,
                http_client,
                cookie_jar,
                rate_limiter,
                event_tx,
            )
            .await
        }
        NodeKind::Parse => nodes::parse::execute(node, inputs),
        NodeKind::Select => nodes::select::execute(node, inputs),
        NodeKind::Transform => nodes::transform::execute(node, inputs),
        NodeKind::MapToModel => nodes::map_to_model::execute(node, inputs),
        NodeKind::CachePut => nodes::cache::execute_put(node, inputs, kv_store, event_tx).await,
        NodeKind::CacheGet => nodes::cache::execute_get(node, inputs, kv_store, event_tx).await,
        NodeKind::CookiePut => {
            nodes::cookie::execute_put(node, inputs, http_client, cookie_jar, event_tx).await
        }
        NodeKind::CookieGet => nodes::cookie::execute_get(node, inputs, cookie_jar, event_tx).await,
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

    if let Some(key) = cache_key.as_ref() {
        if let Some(outputs) = execution_cache.lock().await.get(key).cloned() {
            return Ok(CachedNodeExecution {
                outputs,
                cache_hit: true,
            });
        }
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

fn stable_input_hash(inputs: &NodeOutputs) -> Option<String> {
    let payload = serde_json::to_string(&runtime_values_hash_repr(inputs)).ok()?;
    Some(stable_hash_hex(payload.as_bytes()))
}

fn runtime_values_hash_repr(inputs: &NodeOutputs) -> JsonValue {
    json!(
        inputs
            .iter()
            .map(|(port_name, values)| {
                (
                    port_name.clone(),
                    values
                        .iter()
                        .map(runtime_value_hash_repr)
                        .collect::<Vec<_>>(),
                )
            })
            .collect::<BTreeMap<_, _>>()
    )
}

fn runtime_value_hash_repr(value: &RuntimeValue) -> JsonValue {
    match value {
        RuntimeValue::Text(value) => json!({ "type": "text", "value": value }),
        RuntimeValue::Html(value) => json!({ "type": "html", "value": value }),
        RuntimeValue::Json(value) => json!({ "type": "json", "value": value }),
        RuntimeValue::Url(value) => json!({ "type": "url", "value": value }),
        RuntimeValue::List(values) => json!({
            "type": "list",
            "items": values.iter().map(runtime_value_hash_repr).collect::<Vec<_>>(),
        }),
        RuntimeValue::Record(fields) => json!({
            "type": "record",
            "fields": fields
                .iter()
                .map(|(key, value)| (key.clone(), runtime_value_hash_repr(value)))
                .collect::<BTreeMap<_, _>>(),
        }),
        RuntimeValue::NormalizedModel(model) => {
            json!({ "type": "normalizedModel", "value": model })
        }
    }
}

fn stable_hash_hex(bytes: &[u8]) -> String {
    const FNV_OFFSET_BASIS: u64 = 0xcbf29ce484222325;
    const FNV_PRIME: u64 = 0x100000001b3;

    let mut hash = FNV_OFFSET_BASIS;
    for byte in bytes {
        hash ^= u64::from(*byte);
        hash = hash.wrapping_mul(FNV_PRIME);
    }

    format!("{hash:016x}")
}

impl RuntimeKvStore {
    fn from_persisted_json(persisted_rule_kv_json: Option<&str>) -> Self {
        let mut rule_scope = HashMap::new();

        if let Some(payload) = persisted_rule_kv_json
            && let Ok(map) = serde_json::from_str::<HashMap<String, JsonValue>>(payload)
        {
            for (key, value_repr) in map {
                if let Some(value) = runtime_value_from_repr(&value_repr) {
                    rule_scope.insert(key, value);
                }
            }
        }

        Self {
            run_scope: Mutex::new(HashMap::new()),
            rule_scope: Mutex::new(rule_scope),
        }
    }

    pub(crate) async fn get(&self, scope: CacheScope, key: &str) -> Option<RuntimeValue> {
        match scope {
            CacheScope::Run => self.run_scope.lock().await.get(key).cloned(),
            CacheScope::Rule => self.rule_scope.lock().await.get(key).cloned(),
        }
    }

    pub(crate) async fn put(
        &self,
        scope: CacheScope,
        key: String,
        value: RuntimeValue,
        max_value_bytes: usize,
    ) -> Result<usize, usize> {
        let value_bytes = serde_json::to_vec(&runtime_value_hash_repr(&value))
            .map(|bytes| bytes.len())
            .unwrap_or(0);
        if value_bytes > max_value_bytes {
            return Err(value_bytes);
        }

        match scope {
            CacheScope::Run => {
                self.run_scope.lock().await.insert(key, value);
            }
            CacheScope::Rule => {
                self.rule_scope.lock().await.insert(key, value);
            }
        }

        Ok(value_bytes)
    }

    async fn snapshot_rule_scope_json(&self) -> Option<String> {
        let guard = self.rule_scope.lock().await;
        if guard.is_empty() {
            return None;
        }

        let map = guard
            .iter()
            .map(|(key, value)| (key.clone(), runtime_value_hash_repr(value)))
            .collect::<HashMap<_, _>>();
        serde_json::to_string(&map).ok()
    }
}

impl RuntimeCookieJar {
    fn from_persisted_json(persisted_cookie_jar_json: Option<&str>) -> Self {
        let entries = persisted_cookie_jar_json
            .and_then(|payload| serde_json::from_str::<Vec<PersistedCookieEntry>>(payload).ok())
            .unwrap_or_default();
        Self {
            current_request_domain: Mutex::new(None),
            entries: Mutex::new(entries),
        }
    }

    pub(crate) async fn snapshot_json(&self) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let mut guard = self.entries.lock().await;
        guard.retain(|entry| !cookie_is_expired(entry, now));
        if guard.is_empty() {
            return None;
        }
        serde_json::to_string(&*guard).ok()
    }

    pub(crate) async fn set_current_request_domain(&self, domain: Option<String>) {
        *self.current_request_domain.lock().await = domain;
    }

    pub(crate) async fn current_request_domain(&self) -> Option<String> {
        self.current_request_domain.lock().await.clone()
    }

    pub(crate) async fn put_entry(&self, entry: PersistedCookieEntry) {
        let now = current_unix_timestamp_secs();
        let mut guard = self.entries.lock().await;
        guard.retain(|candidate| {
            !(candidate.name == entry.name
                && candidate.domain == entry.domain
                && candidate.path == entry.path)
        });
        if cookie_is_expired(&entry, now) {
            return;
        }
        guard.push(entry);
    }

    pub(crate) async fn hydrate_client(&self, client: &wreq::Client) {
        let now = current_unix_timestamp_secs();
        let entries = self.entries.lock().await.clone();
        for entry in entries {
            if cookie_is_expired(&entry, now) {
                continue;
            }
            let scheme = if entry.secure { "https" } else { "http" };
            let target_url = format!("{scheme}://{}{}", entry.domain, entry.path);
            let Ok(url) = target_url.parse::<wreq::Url>() else {
                continue;
            };

            let mut cookie = format!("{}={}; Path={}", entry.name, entry.value, entry.path);
            if let Some(expires_at_unix) = entry.expires_at_unix {
                let max_age = expires_at_unix.saturating_sub(now);
                cookie.push_str(format!("; Max-Age={max_age}").as_str());
            }
            if entry.secure {
                cookie.push_str("; Secure");
            }
            if entry.http_only {
                cookie.push_str("; HttpOnly");
            }
            if let Ok(header) = wreq::header::HeaderValue::from_str(cookie.as_str()) {
                client.set_cookies(&url, [header]);
            }
        }
    }

    pub(crate) async fn get_cookie_value(
        &self,
        name: &str,
        domain: Option<&str>,
        path: Option<&str>,
    ) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let requested_domain = domain.map(normalize_cookie_domain);
        let requested_path = path.unwrap_or("/");

        let mut guard = self.entries.lock().await;
        guard.retain(|cookie| !cookie_is_expired(cookie, now));
        guard.iter().find_map(|cookie| {
            if cookie.name != name {
                return None;
            }
            if let Some(domain) = requested_domain.as_ref()
                && !cookie_domain_matches(&cookie.domain, domain)
            {
                return None;
            }
            if !requested_path.starts_with(cookie.path.as_str()) {
                return None;
            }
            Some(cookie.value.clone())
        })
    }

    pub(crate) async fn cookie_header_for_url(&self, url: &str) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let parsed = url::Url::parse(url).ok()?;
        let host = normalize_cookie_domain(parsed.host_str()?);
        let request_path = parsed.path();
        let is_https = parsed.scheme().eq_ignore_ascii_case("https");

        let mut guard = self.entries.lock().await;
        guard.retain(|cookie| !cookie_is_expired(cookie, now));
        let cookie_pairs = guard
            .iter()
            .filter(|cookie| {
                cookie_domain_matches(&cookie.domain, &host)
                    && request_path.starts_with(cookie.path.as_str())
                    && (!cookie.secure || is_https)
            })
            .map(|cookie| format!("{}={}", cookie.name, cookie.value))
            .collect::<Vec<_>>();

        if cookie_pairs.is_empty() {
            None
        } else {
            Some(cookie_pairs.join("; "))
        }
    }

    pub(crate) async fn absorb_set_cookie_headers(
        &self,
        response_url: &str,
        headers: &wreq::header::HeaderMap,
    ) {
        let Some(default_domain) = extract_domain_from_url(response_url) else {
            return;
        };

        for header in headers.get_all(wreq::header::SET_COOKIE) {
            let Ok(raw_cookie) = header.to_str() else {
                continue;
            };
            if let Some(entry) = parse_set_cookie_entry(raw_cookie, &default_domain) {
                self.put_entry(entry).await;
            }
        }
    }
}

fn parse_set_cookie_entry(raw_cookie: &str, default_domain: &str) -> Option<PersistedCookieEntry> {
    let mut segments = raw_cookie.split(';');
    let first = segments.next()?.trim();
    let (name, value) = first.split_once('=')?;
    let mut entry = PersistedCookieEntry {
        name: name.trim().to_string(),
        value: value.trim().to_string(),
        domain: default_domain.to_string(),
        path: "/".to_string(),
        secure: false,
        http_only: false,
        expires_at_unix: None,
    };
    if entry.name.is_empty() {
        return None;
    }

    for segment in segments {
        let token = segment.trim();
        if token.eq_ignore_ascii_case("secure") {
            entry.secure = true;
            continue;
        }
        if token.eq_ignore_ascii_case("httponly") {
            entry.http_only = true;
            continue;
        }

        let Some((key, value)) = token.split_once('=') else {
            continue;
        };
        let key = key.trim().to_ascii_lowercase();
        let value = value.trim();
        match key.as_str() {
            "domain" => {
                let normalized = normalize_cookie_domain(value);
                if !normalized.is_empty() {
                    entry.domain = normalized;
                }
            }
            "path" => {
                if !value.is_empty() {
                    entry.path = normalize_cookie_path(value);
                }
            }
            "max-age" => {
                if let Ok(seconds) = value.parse::<i64>() {
                    entry.expires_at_unix =
                        Some(current_unix_timestamp_secs().saturating_add(seconds));
                }
            }
            _ => {}
        }
    }

    Some(entry)
}

fn cookie_is_expired(entry: &PersistedCookieEntry, now_unix: i64) -> bool {
    entry
        .expires_at_unix
        .map(|expires_at| expires_at <= now_unix)
        .unwrap_or(false)
}

pub(crate) fn current_unix_timestamp_secs() -> i64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs() as i64
}

pub(crate) fn normalize_cookie_domain(domain: &str) -> String {
    domain
        .trim()
        .to_ascii_lowercase()
        .trim_start_matches('.')
        .to_string()
}

pub(crate) fn normalize_cookie_path(path: &str) -> String {
    let trimmed = path.trim();
    if trimmed.is_empty() {
        return "/".to_string();
    }
    if trimmed.starts_with('/') {
        trimmed.to_string()
    } else {
        format!("/{trimmed}")
    }
}

pub(crate) fn extract_domain_from_url(url: &str) -> Option<String> {
    let parsed = url::Url::parse(url).ok()?;
    parsed.host_str().map(normalize_cookie_domain)
}

pub(crate) fn cookie_domain_matches(cookie_domain: &str, request_domain: &str) -> bool {
    if cookie_domain == request_domain {
        return true;
    }
    request_domain.ends_with(format!(".{cookie_domain}").as_str())
}

pub(crate) fn parse_cache_scope(value: &str) -> Option<CacheScope> {
    match value.trim().to_ascii_lowercase().as_str() {
        "run" => Some(CacheScope::Run),
        "rule" => Some(CacheScope::Rule),
        _ => None,
    }
}

fn runtime_value_from_repr(value: &JsonValue) -> Option<RuntimeValue> {
    let JsonValue::Object(map) = value else {
        return None;
    };

    let kind = map.get("type")?.as_str()?;
    match kind {
        "text" => Some(RuntimeValue::Text(map.get("value")?.as_str()?.to_string())),
        "html" => Some(RuntimeValue::Html(map.get("value")?.as_str()?.to_string())),
        "url" => Some(RuntimeValue::Url(map.get("value")?.as_str()?.to_string())),
        "json" => Some(RuntimeValue::Json(map.get("value")?.clone())),
        "list" => {
            let items = map
                .get("items")?
                .as_array()?
                .iter()
                .filter_map(runtime_value_from_repr)
                .collect::<Vec<_>>();
            Some(RuntimeValue::List(items))
        }
        "record" => {
            let fields = map
                .get("fields")?
                .as_object()?
                .iter()
                .filter_map(|(key, value)| {
                    runtime_value_from_repr(value).map(|runtime| (key.clone(), runtime))
                })
                .collect::<BTreeMap<_, _>>();
            Some(RuntimeValue::Record(fields))
        }
        "normalizedModel" => serde_json::from_value::<NormalizedModel>(map.get("value")?.clone())
            .ok()
            .map(|model| RuntimeValue::NormalizedModel(Box::new(model))),
        _ => None,
    }
}

fn execute_passthrough(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let primary_input = node
        .inputs
        .iter()
        .find_map(|input| inputs.get(&input.name))
        .and_then(|values| values.last())
        .cloned()
        .ok_or_else(|| EngineError::MissingInput {
            node_id: node.id.clone(),
            port_name: node
                .inputs
                .first()
                .map(|port| port.name.clone())
                .unwrap_or_else(|| "input".to_string()),
        })?;

    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        outputs.insert(output.name.clone(), vec![primary_input.clone()]);
    }
    Ok(outputs)
}

fn execute_join(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    // 当前 Join 采用最小 barrier 语义：按输入端口声明顺序收集全部消息。
    // 当输出端口是 list<T> 时输出聚合列表，否则输出最后一条消息。
    let mut collected = Vec::new();
    for input in &node.inputs {
        if let Some(values) = inputs.get(&input.name) {
            collected.extend(values.iter().cloned());
        }
    }

    if collected.is_empty() {
        return Err(EngineError::JoinWithoutInputs {
            node_id: node.id.clone(),
        });
    }

    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        let value = match &output.data_type {
            DataType::List { .. } => RuntimeValue::List(collected.clone()),
            _ => collected
                .last()
                .cloned()
                .ok_or_else(|| EngineError::JoinWithoutInputs {
                    node_id: node.id.clone(),
                })?,
        };
        outputs.insert(output.name.clone(), vec![value]);
    }

    Ok(outputs)
}

fn resolve_phase_results(
    rule: &RuleEnvelope,
    output_store: &HashMap<PortRef, Vec<RuntimeValue>>,
) -> Result<BTreeMap<LifecyclePhase, RuntimeValue>, EngineError> {
    let mut results = BTreeMap::new();

    for (phase, port_ref) in &rule.normalized_outputs {
        let values = output_store
            .get(port_ref)
            .ok_or(EngineError::MissingFinalResult)?;
        let value = collapse_values(values);
        results.insert(*phase, value);
    }

    Ok(results)
}

fn resolve_final_result(
    rule: &RuleEnvelope,
    phase_results: &BTreeMap<LifecyclePhase, RuntimeValue>,
    output_store: &HashMap<PortRef, Vec<RuntimeValue>>,
) -> Result<Option<RuntimeValue>, EngineError> {
    if let Some((_, value)) = phase_results.iter().next_back() {
        return Ok(Some(value.clone()));
    }

    let Some(last_node) = rule.graph.nodes.last() else {
        return Ok(None);
    };
    let Some(last_port) = last_node.outputs.first() else {
        return Ok(None);
    };
    let port_ref = PortRef {
        node_id: last_node.id.clone(),
        port_name: last_port.name.clone(),
    };
    let values = output_store
        .get(&port_ref)
        .ok_or(EngineError::MissingFinalResult)?;
    Ok(Some(collapse_values(values)))
}

fn collapse_values(values: &[RuntimeValue]) -> RuntimeValue {
    if values.len() == 1 {
        values[0].clone()
    } else {
        RuntimeValue::List(values.to_vec())
    }
}

fn coerce_to_type(value: RuntimeValue, data_type: &DataType) -> Result<RuntimeValue, EngineError> {
    coerce_to_type_for_port("runtime", "runtime", value, data_type)
}

fn coerce_to_type_for_port(
    node_id: &str,
    port_name: &str,
    value: RuntimeValue,
    data_type: &DataType,
) -> Result<RuntimeValue, EngineError> {
    if value.matches_type(data_type) {
        return Ok(value);
    }

    match data_type {
        DataType::List { item } if value.matches_type(item) => Ok(RuntimeValue::List(vec![value])),
        _ => Err(EngineError::TypeMismatch {
            node_id: node_id.to_string(),
            port_name: port_name.to_string(),
            expected: data_type_label(data_type),
            actual: value.type_label().to_string(),
        }),
    }
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

async fn collect_events(
    run_id: String,
    trace_id: Option<String>,
    mut receiver: mpsc::Receiver<EventCommand>,
) -> Vec<NodeEvent> {
    let mut seq = 0_u64;
    let mut events = Vec::new();

    while let Some(command) = receiver.recv().await {
        seq += 1;
        if let Some(event) = build_event(command, &run_id, trace_id.clone(), seq) {
            events.push(event);
        }
    }

    events
}

fn build_event(
    command: EventCommand,
    run_id: &str,
    trace_id: Option<String>,
    seq: u64,
) -> Option<NodeEvent> {
    match command {
        EventCommand::RunStarted => Some(NodeEvent::RunStarted {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
        }),
        EventCommand::NodeStarted { node_id } => Some(NodeEvent::NodeStarted {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
        }),
        EventCommand::PortEmit {
            node_id,
            port,
            payload_preview,
            payload_truncated,
            cache_hit,
        } => Some(NodeEvent::PortEmit {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            port,
            payload_preview,
            payload_truncated,
            cache_hit,
        }),
        EventCommand::NodeLog {
            node_id,
            level,
            message,
        } => Some(NodeEvent::NodeLog {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            level,
            message,
        }),
        EventCommand::NodeError {
            node_id,
            port,
            message,
            code,
        } => Some(NodeEvent::NodeError {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            port,
            message,
            code,
        }),
        EventCommand::NodeFinished { node_id, success } => Some(NodeEvent::NodeFinished {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            success,
        }),
        EventCommand::RunFinished { success } => Some(NodeEvent::RunFinished {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            success,
        }),
    }
}

async fn send_event(sender: &mpsc::Sender<EventCommand>, command: EventCommand) {
    let _ = sender.send(command).await;
}

async fn emit_node_log(
    sender: &mpsc::Sender<EventCommand>,
    node_id: &str,
    level: &str,
    message: String,
) {
    send_event(
        sender,
        EventCommand::NodeLog {
            node_id: node_id.to_string(),
            level: level.to_string(),
            message,
        },
    )
    .await;
}

fn preview_payload(value: &RuntimeValue) -> (String, bool) {
    let serialized = serde_json::to_string(value).unwrap_or_else(|_| "\"序列化失败\"".to_string());
    truncate_utf8(serialized, PAYLOAD_PREVIEW_LIMIT_BYTES)
}

fn truncate_utf8(value: String, max_bytes: usize) -> (String, bool) {
    if value.len() <= max_bytes {
        return (value, false);
    }

    let mut boundary = max_bytes.min(value.len());
    while boundary > 0 && !value.is_char_boundary(boundary) {
        boundary -= 1;
    }

    (value[..boundary].to_string(), true)
}

fn default_run_id() -> String {
    let millis = SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_millis();
    format!("run-{millis}")
}

fn data_type_label(data_type: &DataType) -> String {
    match data_type {
        DataType::Text => "text".to_string(),
        DataType::Html => "html".to_string(),
        DataType::Json => "json".to_string(),
        DataType::Url => "url".to_string(),
        DataType::List { item } => format!("list<{}>", data_type_label(item)),
        DataType::Record { fields } => format!("record({})", fields.len()),
        DataType::NormalizedModel => "normalizedModel".to_string(),
    }
}

impl RuntimeValue {
    fn matches_type(&self, data_type: &DataType) -> bool {
        match (self, data_type) {
            (Self::Text(_), DataType::Text) => true,
            (Self::Html(_), DataType::Html) => true,
            (Self::Json(_), DataType::Json) => true,
            (Self::Url(_), DataType::Url) => true,
            (Self::NormalizedModel(_), DataType::NormalizedModel) => true,
            (Self::List(items), DataType::List { item }) => {
                items.iter().all(|value| value.matches_type(item))
            }
            (Self::Record(fields), DataType::Record { fields: expected }) => {
                expected.iter().all(|field| {
                    fields
                        .get(&field.name)
                        .map(|value| value.matches_type(&field.data_type))
                        .unwrap_or(field.optional)
                })
            }
            _ => false,
        }
    }

    fn type_label(&self) -> &'static str {
        match self {
            Self::Text(_) => "text",
            Self::Html(_) => "html",
            Self::Json(_) => "json",
            Self::Url(_) => "url",
            Self::List(_) => "list",
            Self::Record(_) => "record",
            Self::NormalizedModel(_) => "normalizedModel",
        }
    }
}

impl serde::Serialize for RuntimeValue {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        match self {
            Self::Text(value) | Self::Html(value) | Self::Url(value) => {
                serializer.serialize_str(value)
            }
            Self::Json(value) => value.serialize(serializer),
            Self::List(values) => values.serialize(serializer),
            Self::Record(fields) => fields.serialize(serializer),
            Self::NormalizedModel(model) => model.serialize(serializer),
        }
    }
}

#[derive(Debug)]
struct RuntimeGraph {
    nodes: Vec<RuntimeNode>,
}

#[derive(Debug)]
struct RuntimeNode {
    node: Node,
    input_receivers: HashMap<String, Vec<mpsc::Receiver<RuntimeValue>>>,
    output_senders: HashMap<String, Vec<mpsc::Sender<RuntimeValue>>>,
}

impl RuntimeGraph {
    fn build(rule: &RuleEnvelope, channel_capacity: usize) -> Self {
        let mut nodes = rule
            .graph
            .nodes
            .iter()
            .cloned()
            .map(|node| {
                (
                    node.id.clone(),
                    RuntimeNode {
                        node,
                        input_receivers: HashMap::new(),
                        output_senders: HashMap::new(),
                    },
                )
            })
            .collect::<HashMap<_, _>>();

        for edge in &rule.graph.edges {
            let (sender, receiver) = mpsc::channel(channel_capacity);
            if let Some(source) = nodes.get_mut(&edge.from.node_id) {
                source
                    .output_senders
                    .entry(edge.from.port_name.clone())
                    .or_default()
                    .push(sender);
            }
            if let Some(target) = nodes.get_mut(&edge.to.node_id) {
                target
                    .input_receivers
                    .entry(edge.to.port_name.clone())
                    .or_default()
                    .push(receiver);
            }
        }

        let ordered_nodes = rule
            .graph
            .nodes
            .iter()
            .filter_map(|node| nodes.remove(&node.id))
            .collect();

        Self {
            nodes: ordered_nodes,
        }
    }
}

#[derive(Debug, Clone)]
enum EventCommand {
    RunStarted,
    NodeStarted {
        node_id: String,
    },
    PortEmit {
        node_id: String,
        port: String,
        payload_preview: Option<String>,
        payload_truncated: bool,
        cache_hit: bool,
    },
    NodeLog {
        node_id: String,
        level: String,
        message: String,
    },
    NodeError {
        node_id: String,
        port: Option<String>,
        message: String,
        code: Option<String>,
    },
    NodeFinished {
        node_id: String,
        success: bool,
    },
    RunFinished {
        success: bool,
    },
}

#[cfg(test)]
mod tests {
    use std::{
        collections::{BTreeMap, HashMap},
        io::{Read, Write},
        net::TcpListener,
        sync::{Arc, Mutex as StdMutex},
        thread,
        time::{Duration, Instant},
    };

    use tokio::sync::{Mutex, mpsc};

    use super::{EngineContext, EngineError, RuntimeValue, execute_rule};
    use crate::rules_ir::{
        Capabilities, DataType, Edge, Graph, LifecyclePhase, Metadata, Node, NodeEvent, NodeKind,
        Port, PortRef, RuleEnvelope, RuleRateLimit,
    };

    fn text_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Text,
            optional: false,
        }
    }

    fn list_text_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::List {
                item: Box::new(DataType::Text),
            },
            optional: false,
        }
    }

    fn html_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Html,
            optional: false,
        }
    }

    fn json_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Json,
            optional: false,
        }
    }

    fn url_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Url,
            optional: false,
        }
    }

    fn params(entries: &[(&str, &str)]) -> BTreeMap<String, String> {
        entries
            .iter()
            .map(|(key, value)| ((*key).to_string(), (*value).to_string()))
            .collect()
    }

    fn spawn_single_response_http_server(body: &str, content_type: &str) -> String {
        spawn_single_response_http_server_with_status(
            "HTTP/1.1 200 OK",
            body,
            &[("Content-Type", content_type)],
        )
    }

    fn spawn_single_response_http_server_with_status(
        status_line: &str,
        body: &str,
        headers: &[(&str, &str)],
    ) -> String {
        let listener = TcpListener::bind("127.0.0.1:0").expect("应可绑定本地测试端口");
        let address = listener.local_addr().expect("应可读取监听地址");
        let status_line = status_line.to_string();
        let body = body.to_string();
        let headers = headers
            .iter()
            .map(|(name, value)| ((*name).to_string(), (*value).to_string()))
            .collect::<Vec<_>>();

        thread::spawn(move || {
            if let Ok((mut stream, _)) = listener.accept() {
                let mut request_buffer = [0_u8; 1024];
                let _ = stream.read(&mut request_buffer);
                let header_lines = headers
                    .iter()
                    .map(|(name, value)| format!("{name}: {value}\r\n"))
                    .collect::<String>();
                let response = format!(
                    "{status_line}\r\n{header_lines}Content-Length: {}\r\nConnection: close\r\n\r\n{body}",
                    body.len()
                );
                let _ = stream.write_all(response.as_bytes());
                let _ = stream.flush();
            }
        });

        format!("http://{address}/")
    }

    fn spawn_cookie_capture_http_server(
        responses: Vec<(&'static str, Vec<(&'static str, &'static str)>)>,
    ) -> (String, Arc<StdMutex<Vec<Option<String>>>>) {
        let listener = TcpListener::bind("127.0.0.1:0").expect("应可绑定本地测试端口");
        let address = listener.local_addr().expect("应可读取监听地址");
        let observed_cookies = Arc::new(StdMutex::new(Vec::<Option<String>>::new()));
        let observed_cookies_for_thread = Arc::clone(&observed_cookies);

        thread::spawn(move || {
            for (body, headers) in responses {
                let Ok((mut stream, _)) = listener.accept() else {
                    break;
                };

                let mut request_bytes = Vec::new();
                let mut buffer = [0_u8; 1024];
                loop {
                    let Ok(read) = stream.read(&mut buffer) else {
                        break;
                    };
                    if read == 0 {
                        break;
                    }
                    request_bytes.extend_from_slice(&buffer[..read]);
                    if request_bytes.windows(4).any(|window| window == b"\r\n\r\n") {
                        break;
                    }
                }

                let request_text = String::from_utf8_lossy(&request_bytes);
                let cookie_header = request_text.lines().find_map(|line| {
                    let lower = line.to_ascii_lowercase();
                    if lower.starts_with("cookie:") {
                        Some(line[7..].trim().to_string())
                    } else {
                        None
                    }
                });
                observed_cookies_for_thread
                    .lock()
                    .expect("应可写入观察到的 Cookie")
                    .push(cookie_header);

                let header_lines = headers
                    .iter()
                    .map(|(name, value)| format!("{name}: {value}\r\n"))
                    .collect::<String>();
                let response = format!(
                    "HTTP/1.1 200 OK\r\n{header_lines}Content-Type: text/plain; charset=utf-8\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
                    body.len()
                );
                let _ = stream.write_all(response.as_bytes());
                let _ = stream.flush();
            }
        });

        (format!("http://{address}/"), observed_cookies)
    }

    fn build_rule(
        nodes: Vec<Node>,
        edges: Vec<Edge>,
        normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
    ) -> RuleEnvelope {
        RuleEnvelope {
            ir_version: "1.0.0".to_string(),
            metadata: Metadata {
                rule_id: "test.rule".to_string(),
                name: "测试规则".to_string(),
                description: Some("用于 rules_engine 单测".to_string()),
            },
            graph: Graph {
                nodes,
                edges,
                phase_entrypoints: BTreeMap::new(),
                metadata: None,
                layout: None,
            },
            normalized_outputs,
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
        }
    }

    fn build_rule_with_rate_limit(
        nodes: Vec<Node>,
        edges: Vec<Edge>,
        normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
        rate_limit: RuleRateLimit,
    ) -> RuleEnvelope {
        let mut rule = build_rule(nodes, edges, normalized_outputs);
        rule.rate_limit = Some(rate_limit);
        rule
    }

    fn build_single_fetch_rule(url: &str, response: &str, output: Port) -> RuleEnvelope {
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "fetch".to_string(),
                port_name: output.name.clone(),
            },
        );

        build_rule(
            vec![Node {
                id: "fetch".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![output],
                params: params(&[("method", "get"), ("response", response), ("url", url)]),
            }],
            vec![],
            normalized_outputs,
        )
    }

    fn runtime_node_with_single_input(node: Node, value: RuntimeValue) -> super::RuntimeNode {
        let input_name = node
            .inputs
            .first()
            .expect("测试节点应至少包含一个输入端口")
            .name
            .clone();
        let (sender, receiver) = mpsc::channel(1);
        sender.try_send(value).expect("测试输入应可写入单节点通道");
        drop(sender);

        let mut input_receivers = HashMap::new();
        input_receivers.insert(input_name, vec![receiver]);

        super::RuntimeNode {
            node,
            input_receivers,
            output_senders: HashMap::new(),
        }
    }

    #[tokio::test]
    async fn fan_out_execution_reaches_each_branch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "left".to_string(),
                kind: NodeKind::Filter,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "right".to_string(),
                kind: NodeKind::Filter,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "left".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "right".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let rule = build_rule(nodes, edges, BTreeMap::new());
        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("fanout".to_string()),
        );
        context.run_id = Some("run-fanout".to_string());

        let result = execute_rule(&rule, context)
            .await
            .expect("fan-out 图应执行成功");

        let port_emit_count = result
            .events
            .iter()
            .filter(|event| matches!(event, crate::rules_ir::NodeEvent::PortEmit { .. }))
            .count();
        assert_eq!(port_emit_count, 3);
        assert_eq!(result.node_stats["left"].input_messages, 1);
        assert_eq!(result.node_stats["right"].input_messages, 1);
    }

    #[tokio::test]
    async fn join_collects_inputs_and_truncates_preview() {
        let nodes = vec![
            Node {
                id: "left_input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "right_input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "join".to_string(),
                kind: NodeKind::Join,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("left"), text_port("right")],
                outputs: vec![list_text_port("joined")],
                params: BTreeMap::new(),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![list_text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "left_input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "join".to_string(),
                    port_name: "left".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "right_input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "join".to_string(),
                    port_name: "right".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "join".to_string(),
                    port_name: "joined".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let rule = build_rule(nodes, edges, BTreeMap::new());
        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "left_input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("L".repeat(900)),
        );
        context.port_inputs.insert(
            PortRef {
                node_id: "right_input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("R".repeat(900)),
        );
        context.run_id = Some("run-join".to_string());

        let result = execute_rule(&rule, context)
            .await
            .expect("join 图应执行成功");

        assert!(matches!(
            result.final_result,
            Some(RuntimeValue::List(ref items)) if items.len() == 2
        ));
        let join_emit = result
            .events
            .iter()
            .find(|event| matches!(event, crate::rules_ir::NodeEvent::PortEmit { node_id, .. } if node_id == "join"))
            .expect("join 节点应发出 PortEmit");
        match join_emit {
            crate::rules_ir::NodeEvent::PortEmit {
                payload_preview,
                payload_truncated,
                ..
            } => {
                assert!(*payload_truncated);
                assert!(payload_preview.as_ref().expect("应有预览").len() <= 1024);
            }
            _ => unreachable!(),
        }
        assert_eq!(result.node_stats["join"].input_messages, 2);
        assert_eq!(result.node_stats["join"].output_messages, 1);
    }

    #[tokio::test]
    async fn fetch_parse_css_select_and_transform_nodes_execute_in_runtime_dispatch() {
        let html = r#"<html><body><a class="item" href="/detail/42">详情</a></body></html>"#;
        let url = spawn_single_response_http_server(html, "text/html; charset=utf-8");

        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "fetch".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![html_port("body")],
                params: params(&[("method", "get"), ("response", "html")]),
            },
            Node {
                id: "parse".to_string(),
                kind: NodeKind::Parse,
                phase: LifecyclePhase::Search,
                inputs: vec![html_port("in")],
                outputs: vec![html_port("doc")],
                params: params(&[("format", "html")]),
            },
            Node {
                id: "select".to_string(),
                kind: NodeKind::Select,
                phase: LifecyclePhase::Search,
                inputs: vec![html_port("in")],
                outputs: vec![list_text_port("links")],
                params: params(&[
                    ("engine", "css"),
                    ("query", "a.item"),
                    ("extract", "attr"),
                    ("attr", "href"),
                ]),
            },
            Node {
                id: "pick_first".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![text_port("first")],
                params: params(&[("family", "list"), ("op", "first")]),
            },
            Node {
                id: "join_url".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![url_port("abs")],
                params: params(&[
                    ("family", "url"),
                    ("op", "join"),
                    ("base", "https://example.com"),
                ]),
            },
            Node {
                id: "convert_text".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![text_port("text")],
                params: params(&[("family", "convert"), ("op", "text")]),
            },
            Node {
                id: "normalize_url".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[("family", "url"), ("op", "normalize")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "body".to_string(),
                },
                to: PortRef {
                    node_id: "parse".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "parse".to_string(),
                    port_name: "doc".to_string(),
                },
                to: PortRef {
                    node_id: "select".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "select".to_string(),
                    port_name: "links".to_string(),
                },
                to: PortRef {
                    node_id: "pick_first".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "pick_first".to_string(),
                    port_name: "first".to_string(),
                },
                to: PortRef {
                    node_id: "join_url".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "join_url".to_string(),
                    port_name: "abs".to_string(),
                },
                to: PortRef {
                    node_id: "convert_text".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "convert_text".to_string(),
                    port_name: "text".to_string(),
                },
                to: PortRef {
                    node_id: "normalize_url".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "normalize_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );

        let rule = build_rule(nodes, edges, normalized_outputs);
        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(url),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("fetch/parse/select/transform 链路应成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Url(
                "https://example.com/detail/42".to_string()
            ))
        );
    }

    #[tokio::test]
    async fn fetch_node_returns_challenge_required_for_cloudflare_style_response() {
        let url = spawn_single_response_http_server_with_status(
            "HTTP/1.1 503 Service Unavailable",
            "blocked by upstream challenge",
            &[
                ("Content-Type", "text/html; charset=utf-8"),
                ("cf-mitigated", "challenge"),
            ],
        );
        let rule = build_single_fetch_rule(&url, "html", html_port("result"));

        let result = execute_rule(&rule, EngineContext::default()).await;

        assert!(matches!(
            result,
            Err(EngineError::NodeFailed {
                ref node_id,
                ref message,
                code: Some(ref code),
            })
            if node_id == "fetch"
                && code == "CHALLENGE_REQUIRED"
                && message.contains("已中止当前请求")
                && message.contains("暂不支持交互式会话处理")
        ));
    }

    #[tokio::test]
    async fn fetch_node_keeps_ordinary_200_success_unaffected() {
        let url =
            spawn_single_response_http_server("plain success body", "text/plain; charset=utf-8");
        let rule = build_single_fetch_rule(&url, "text", text_port("result"));

        let result = execute_rule(&rule, EngineContext::default())
            .await
            .expect("普通 200 响应不应触发挑战检测");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("plain success body".to_string()))
        );
    }

    #[tokio::test]
    async fn cookie_put_then_same_domain_fetch_auto_sends_cookie() {
        let (server_url, observed_cookies) =
            spawn_cookie_capture_http_server(vec![("cookie-ok", vec![])]);
        let domain = url::Url::parse(&server_url)
            .expect("测试 URL 应可解析")
            .host_str()
            .expect("测试 URL 应包含 host")
            .to_string();

        let nodes = vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cookie_put".to_string(),
                kind: NodeKind::CookiePut,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("value", "cookie-put-value"),
                    ("domain", &domain),
                    ("allowDomains", &domain),
                ]),
            },
            Node {
                id: "fetch".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![text_port("body")],
                params: params(&[("method", "get"), ("response", "text")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "body".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(server_url),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("CookiePut 后同域 fetch 应成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("cookie-ok".to_string()))
        );
        let captured = observed_cookies
            .lock()
            .expect("应可读取抓到的 Cookie")
            .first()
            .cloned()
            .flatten()
            .unwrap_or_default();
        assert!(
            captured.contains("session=cookie-put-value"),
            "fetch 请求应自动附带 Cookie，实际为 `{captured}`"
        );
    }

    #[tokio::test]
    async fn cookie_get_reads_current_jar_value() {
        let target_url = "http://example.local/path";
        let nodes = vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cookie_put".to_string(),
                kind: NodeKind::CookiePut,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("value", "cookie-readback"),
                    ("domain", "example.local"),
                    ("allowDomains", "example.local"),
                ]),
            },
            Node {
                id: "cookie_get".to_string(),
                kind: NodeKind::CookieGet,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("trigger")],
                outputs: vec![text_port("out")],
                params: params(&[("name", "session"), ("domain", "example.local")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_get".to_string(),
                    port_name: "trigger".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cookie_get".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(target_url.to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("CookieGet 应读取当前 jar 的值");
        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("cookie-readback".to_string()))
        );
    }

    #[tokio::test]
    async fn cookie_jar_reload_after_restart_still_auto_sends_cookie() {
        let seed_url = "http://reload.local/seed";
        let put_rule = build_rule(
            vec![
                Node {
                    id: "input_url".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![url_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "cookie_put".to_string(),
                    kind: NodeKind::CookiePut,
                    phase: LifecyclePhase::Search,
                    inputs: vec![url_port("in")],
                    outputs: vec![url_port("out")],
                    params: params(&[
                        ("name", "session"),
                        ("value", "restart-cookie"),
                        ("domain", "127.0.0.1"),
                        ("allowDomains", "127.0.0.1"),
                    ]),
                },
            ],
            vec![Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "in".to_string(),
                },
            }],
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "out".to_string(),
                },
            )]),
        );

        let mut first_context = EngineContext::default();
        first_context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(seed_url.to_string()),
        );
        let first_result = execute_rule(&put_rule, first_context)
            .await
            .expect("首次执行应写入 cookie 快照");
        let persisted_cookie_jar = first_result
            .cookie_jar_json
            .clone()
            .expect("应产出 cookie jar 快照");

        let (server_url, observed_cookies) =
            spawn_cookie_capture_http_server(vec![("reload-ok", vec![])]);
        let fetch_rule = build_rule(
            vec![
                Node {
                    id: "input_url".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![url_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "fetch".to_string(),
                    kind: NodeKind::Fetch,
                    phase: LifecyclePhase::Search,
                    inputs: vec![url_port("in")],
                    outputs: vec![text_port("body")],
                    params: params(&[("method", "get"), ("response", "text")]),
                },
            ],
            vec![Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "in".to_string(),
                },
            }],
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "body".to_string(),
                },
            )]),
        );

        let mut second_context = EngineContext {
            persisted_cookie_jar_json: Some(persisted_cookie_jar),
            ..EngineContext::default()
        };
        second_context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(server_url),
        );

        let second_result = execute_rule(&fetch_rule, second_context)
            .await
            .expect("重启后应继续自动附带 cookie");
        assert_eq!(
            second_result.final_result,
            Some(RuntimeValue::Text("reload-ok".to_string()))
        );

        let captured = observed_cookies
            .lock()
            .expect("应可读取抓到的 Cookie")
            .first()
            .cloned()
            .flatten()
            .unwrap_or_default();
        assert!(
            captured.contains("session=restart-cookie"),
            "重启加载后 fetch 应继续自动附带 Cookie，实际为 `{captured}`"
        );
    }

    #[tokio::test]
    async fn expired_cookie_is_not_sent_by_fetch() {
        let (server_url, observed_cookies) =
            spawn_cookie_capture_http_server(vec![("expired-check", vec![])]);
        let expired = super::current_unix_timestamp_secs()
            .saturating_sub(5)
            .to_string();

        let nodes = vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cookie_put".to_string(),
                kind: NodeKind::CookiePut,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("value", "expired-value"),
                    ("domain", "127.0.0.1"),
                    ("allowDomains", "127.0.0.1"),
                    ("expires", &expired),
                ]),
            },
            Node {
                id: "fetch".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![text_port("body")],
                params: params(&[("method", "get"), ("response", "text")]),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let rule = build_rule(
            nodes,
            edges,
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "fetch".to_string(),
                    port_name: "body".to_string(),
                },
            )]),
        );

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url(server_url),
        );

        let _ = execute_rule(&rule, context)
            .await
            .expect("过期 Cookie 不应导致 fetch 失败");
        let captured = observed_cookies
            .lock()
            .expect("应可读取抓到的 Cookie")
            .first()
            .cloned()
            .flatten()
            .unwrap_or_default();
        assert!(
            !captured.contains("session=expired-value"),
            "过期 Cookie 不应被自动发送，实际为 `{captured}`"
        );
    }

    #[tokio::test]
    async fn expired_cookie_is_not_returned_by_cookie_get() {
        let expired = super::current_unix_timestamp_secs()
            .saturating_sub(10)
            .to_string();
        let nodes = vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cookie_put".to_string(),
                kind: NodeKind::CookiePut,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("value", "expired-read"),
                    ("domain", "example.local"),
                    ("allowDomains", "example.local"),
                    ("expires", &expired),
                ]),
            },
            Node {
                id: "cookie_get".to_string(),
                kind: NodeKind::CookieGet,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("trigger")],
                outputs: vec![text_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("domain", "example.local"),
                    ("default", "miss"),
                ]),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input_url".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cookie_put".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cookie_get".to_string(),
                    port_name: "trigger".to_string(),
                },
            },
        ];
        let rule = build_rule(
            nodes,
            edges,
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "cookie_get".to_string(),
                    port_name: "out".to_string(),
                },
            )]),
        );

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Url("http://example.local/seed".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("过期 Cookie 下 CookieGet 应成功返回 default");
        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("miss".to_string()))
        );
    }

    #[tokio::test]
    async fn rule_rate_limit_delays_repeated_fetch_and_emits_node_log() {
        let first_url = spawn_single_response_http_server("first", "text/plain; charset=utf-8");
        let second_url = spawn_single_response_http_server("second", "text/plain; charset=utf-8");

        let nodes = vec![
            Node {
                id: "fetch_a".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("result")],
                params: params(&[("method", "get"), ("response", "text"), ("url", &first_url)]),
            },
            Node {
                id: "fetch_b".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("result")],
                params: params(&[
                    ("method", "get"),
                    ("response", "text"),
                    ("url", &second_url),
                ]),
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "fetch_b".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule_with_rate_limit(
            nodes,
            vec![],
            normalized_outputs,
            RuleRateLimit {
                count: 1,
                period_ms: 220,
            },
        );

        let started = Instant::now();
        let result = execute_rule(&rule, EngineContext::default())
            .await
            .expect("触发限速时请求应延迟而非失败");
        let elapsed = started.elapsed();

        let node_logs = result
            .events
            .iter()
            .filter_map(|event| match event {
                NodeEvent::NodeLog { message, .. } => Some(message.clone()),
                _ => None,
            })
            .collect::<Vec<_>>();
        assert!(!node_logs.is_empty(), "触发限速后应产生 NodeLog");
        assert!(
            node_logs.iter().any(|message| message.contains("延迟请求")
                && message.contains("count=1")
                && message.contains("periodMs=220")),
            "NodeLog 应包含等待时间与窗口配置"
        );
        assert!(elapsed >= Duration::from_millis(180));
    }

    #[tokio::test]
    async fn rule_rate_limit_under_quota_has_no_delay_or_node_log() {
        let first_url = spawn_single_response_http_server("first", "text/plain; charset=utf-8");
        let second_url = spawn_single_response_http_server("second", "text/plain; charset=utf-8");

        let nodes = vec![
            Node {
                id: "fetch_a".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("result")],
                params: params(&[("method", "get"), ("response", "text"), ("url", &first_url)]),
            },
            Node {
                id: "fetch_b".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("result")],
                params: params(&[
                    ("method", "get"),
                    ("response", "text"),
                    ("url", &second_url),
                ]),
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "fetch_b".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule_with_rate_limit(
            nodes,
            vec![],
            normalized_outputs,
            RuleRateLimit {
                count: 3,
                period_ms: 220,
            },
        );

        let started = Instant::now();
        let result = execute_rule(&rule, EngineContext::default())
            .await
            .expect("配额内请求应正常成功");
        let elapsed = started.elapsed();

        assert!(
            !result
                .events
                .iter()
                .any(|event| matches!(event, NodeEvent::NodeLog { .. })),
            "配额内不应产生限速 NodeLog"
        );
        assert!(elapsed < Duration::from_millis(180));
    }

    #[tokio::test]
    async fn parse_json_and_jsonpath_select_flow_through_engine_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "parse".to_string(),
                kind: NodeKind::Parse,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![json_port("json")],
                params: params(&[("format", "json")]),
            },
            Node {
                id: "select".to_string(),
                kind: NodeKind::Select,
                phase: LifecyclePhase::Search,
                inputs: vec![json_port("in")],
                outputs: vec![list_text_port("names")],
                params: params(&[("engine", "jsonpath"), ("query", "$.items[*].name")]),
            },
            Node {
                id: "join".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![text_port("joined")],
                params: params(&[("family", "list"), ("op", "join"), ("separator", ",")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "parse".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "parse".to_string(),
                    port_name: "json".to_string(),
                },
                to: PortRef {
                    node_id: "select".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "select".to_string(),
                    port_name: "names".to_string(),
                },
                to: PortRef {
                    node_id: "join".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "join".to_string(),
                    port_name: "joined".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text(r#"{"items":[{"name":"A"},{"name":"B"}]}"#.to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("parse + jsonpath + list.join 链路应成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("A,B".to_string()))
        );
    }

    #[tokio::test]
    async fn xpath_selector_requires_explicit_attr_and_runs_in_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![html_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "select".to_string(),
                kind: NodeKind::Select,
                phase: LifecyclePhase::Search,
                inputs: vec![html_port("in")],
                outputs: vec![list_text_port("hrefs")],
                params: params(&[
                    ("engine", "xpath"),
                    ("query", "//a[@class='entry']"),
                    ("extract", "attr"),
                    ("attr", "href"),
                ]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![list_text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "select".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "select".to_string(),
                    port_name: "hrefs".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Html(
                r#"<div><a class="entry" href="/a">A</a><a class="entry" href="/b">B</a></div>"#
                    .to_string(),
            ),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("xpath attr 选择应成功");

        assert!(matches!(
            result.final_result,
            Some(RuntimeValue::List(ref items))
            if items == &vec![
                RuntimeValue::Text("/a".to_string()),
                RuntimeValue::Text("/b".to_string())
            ]
        ));
    }

    #[tokio::test]
    async fn regex_selector_and_text_transform_run_in_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "select".to_string(),
                kind: NodeKind::Select,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![list_text_port("matched")],
                params: params(&[
                    ("engine", "regex"),
                    ("query", "ID-([A-Z]+)"),
                    ("group", "1"),
                ]),
            },
            Node {
                id: "first".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![text_port("first")],
                params: params(&[("family", "list"), ("op", "first")]),
            },
            Node {
                id: "lower".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("family", "text"), ("op", "lower")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "select".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "select".to_string(),
                    port_name: "matched".to_string(),
                },
                to: PortRef {
                    node_id: "first".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "first".to_string(),
                    port_name: "first".to_string(),
                },
                to: PortRef {
                    node_id: "lower".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "lower".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("ID-AB ID-CD".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("regex + text.lower 链路应成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("ab".to_string()))
        );
    }

    #[tokio::test]
    async fn json_transform_stringify_runs_in_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![json_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "stringify".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![json_port("in")],
                outputs: vec![text_port("text")],
                params: params(&[("family", "json"), ("op", "stringify")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "stringify".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "stringify".to_string(),
                    port_name: "text".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Json(serde_json::json!({"name":"Spectra"})),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("json.stringify 链路应成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("{\"name\":\"Spectra\"}".to_string()))
        );
    }

    #[tokio::test]
    async fn text_transform_normalize_space_runs_in_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "normalize".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("family", "text"), ("op", "normalizeSpace")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "normalize".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "normalize".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("  A\n  B\t\tC  ".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("text.normalizeSpace 应通过真实引擎路径生效");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("A B C".to_string()))
        );
    }

    #[tokio::test]
    async fn js_transform_runs_in_sandbox_runtime_dispatch() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "js".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("family", "js"), ("script", "return input.toUpperCase();")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "js".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "js".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("spectra".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("js transform 应可在沙箱中执行");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("SPECTRA".to_string()))
        );
    }

    #[tokio::test]
    async fn js_transform_infinite_loop_is_interrupted_with_timeout_error() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "js".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("family", "js"), ("script", "while (true) {}")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "js".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "js".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("spectra".to_string()),
        );

        let result = execute_rule(&rule, context).await;

        assert!(matches!(
            result,
            Err(EngineError::JsTimeout { ref node_id, .. }) if node_id == "js"
        ));
    }

    #[tokio::test]
    async fn repeated_same_node_and_input_uses_run_scoped_cache_and_marks_port_emit() {
        let node = Node {
            id: "repeat".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        };
        let output_store = Arc::new(Mutex::new(HashMap::new()));
        let node_stats = Arc::new(Mutex::new(BTreeMap::new()));
        let execution_cache = Arc::new(Mutex::new(HashMap::new()));
        let context = Arc::new(EngineContext::default());
        let (event_tx, event_rx) = mpsc::channel(16);
        let collector = tokio::spawn(super::collect_events(
            "run-cache".to_string(),
            None,
            event_rx,
        ));
        let run_context = super::RunNodeContext {
            rule_ir_version: "1.0.0".to_string(),
            context,
            output_store,
            node_stats,
            execution_cache,
            http_client: Arc::new(wreq::Client::new()),
            kv_store: Arc::new(super::RuntimeKvStore::from_persisted_json(None)),
            cookie_jar: Arc::new(super::RuntimeCookieJar::from_persisted_json(None)),
            rate_limiter: None,
            event_tx: event_tx.clone(),
        };

        super::run_node(
            runtime_node_with_single_input(node.clone(), RuntimeValue::Text("spectra".to_string())),
            run_context.clone(),
        )
        .await
        .expect("首次执行应成功");

        super::run_node(
            runtime_node_with_single_input(node, RuntimeValue::Text("spectra".to_string())),
            run_context,
        )
        .await
        .expect("相同输入的二次执行应命中缓存");

        drop(event_tx);
        let events = collector.await.expect("事件收集任务应成功结束");

        let cache_hits = events
            .iter()
            .filter_map(|event| match event {
                NodeEvent::PortEmit {
                    node_id, cache_hit, ..
                } if node_id == "repeat" => Some(*cache_hit),
                _ => None,
            })
            .collect::<Vec<_>>();

        assert_eq!(cache_hits, vec![false, true]);
        assert!(
            events
                .windows(2)
                .all(|pair| event_seq(&pair[1]) > event_seq(&pair[0]))
        );
    }

    #[tokio::test]
    async fn first_execution_and_changed_input_do_not_mark_cache_hit() {
        let node = Node {
            id: "repeat".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        };
        let output_store = Arc::new(Mutex::new(HashMap::new()));
        let node_stats = Arc::new(Mutex::new(BTreeMap::new()));
        let execution_cache = Arc::new(Mutex::new(HashMap::new()));
        let context = Arc::new(EngineContext::default());
        let (event_tx, event_rx) = mpsc::channel(16);
        let collector = tokio::spawn(super::collect_events(
            "run-cache-different-input".to_string(),
            None,
            event_rx,
        ));
        let run_context = super::RunNodeContext {
            rule_ir_version: "1.0.0".to_string(),
            context,
            output_store,
            node_stats,
            execution_cache,
            http_client: Arc::new(wreq::Client::new()),
            kv_store: Arc::new(super::RuntimeKvStore::from_persisted_json(None)),
            cookie_jar: Arc::new(super::RuntimeCookieJar::from_persisted_json(None)),
            rate_limiter: None,
            event_tx: event_tx.clone(),
        };

        super::run_node(
            runtime_node_with_single_input(
                node.clone(),
                RuntimeValue::Text("spectra-a".to_string()),
            ),
            run_context.clone(),
        )
        .await
        .expect("首次执行应成功");

        super::run_node(
            runtime_node_with_single_input(node, RuntimeValue::Text("spectra-b".to_string())),
            run_context,
        )
        .await
        .expect("不同输入的执行不应因缓存失败");

        drop(event_tx);
        let events = collector.await.expect("事件收集任务应成功结束");

        let cache_hits = events
            .iter()
            .filter_map(|event| match event {
                NodeEvent::PortEmit {
                    node_id, cache_hit, ..
                } if node_id == "repeat" => Some(*cache_hit),
                _ => None,
            })
            .collect::<Vec<_>>();

        assert_eq!(cache_hits, vec![false, false]);
    }

    #[tokio::test]
    async fn cache_put_and_cache_get_share_run_scope_in_single_execution() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cache_put".to_string(),
                kind: NodeKind::CachePut,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("key", "shared_key"), ("scope", "run")]),
            },
            Node {
                id: "cache_get".to_string(),
                kind: NodeKind::CacheGet,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("trigger")],
                outputs: vec![text_port("out")],
                params: params(&[("key", "shared_key"), ("scope", "run")]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cache_put".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cache_put".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "trigger".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ];
        let mut normalized_outputs = BTreeMap::new();
        normalized_outputs.insert(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        );
        let rule = build_rule(nodes, edges, normalized_outputs);

        let mut context = EngineContext::default();
        context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("run-value".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("run scope 缓存链路应执行成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("run-value".to_string()))
        );
        assert!(
            result.events.iter().any(|event| {
                matches!(
                    event,
                    NodeEvent::NodeLog { node_id, message, .. }
                    if node_id == "cache_get" && message.contains("缓存命中")
                )
            }),
            "CacheGet 命中时应产生 NodeLog"
        );
    }

    #[tokio::test]
    async fn cache_rule_scope_hits_in_second_execution_with_persisted_snapshot() {
        let put_rule = build_rule(
            vec![
                Node {
                    id: "input".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![text_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "cache_put".to_string(),
                    kind: NodeKind::CachePut,
                    phase: LifecyclePhase::Search,
                    inputs: vec![text_port("in")],
                    outputs: vec![text_port("out")],
                    params: params(&[("key", "persisted_key"), ("scope", "rule")]),
                },
            ],
            vec![Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cache_put".to_string(),
                    port_name: "in".to_string(),
                },
            }],
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "cache_put".to_string(),
                    port_name: "out".to_string(),
                },
            )]),
        );

        let mut first_context = EngineContext::default();
        first_context.port_inputs.insert(
            PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("rule-value".to_string()),
        );
        let first_result = execute_rule(&put_rule, first_context)
            .await
            .expect("首次 rule scope 写入应成功");
        let persisted = first_result
            .rule_kv_json
            .clone()
            .expect("写入 rule scope 后应产出快照");

        let get_rule = build_rule(
            vec![
                Node {
                    id: "trigger".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![text_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "cache_get".to_string(),
                    kind: NodeKind::CacheGet,
                    phase: LifecyclePhase::Search,
                    inputs: vec![text_port("trigger")],
                    outputs: vec![text_port("out")],
                    params: params(&[
                        ("key", "persisted_key"),
                        ("scope", "rule"),
                        ("default", "miss-default"),
                    ]),
                },
                Node {
                    id: "sink".to_string(),
                    kind: NodeKind::Output,
                    phase: LifecyclePhase::Search,
                    inputs: vec![text_port("in")],
                    outputs: vec![text_port("result")],
                    params: BTreeMap::new(),
                },
            ],
            vec![
                Edge {
                    from: PortRef {
                        node_id: "trigger".to_string(),
                        port_name: "out".to_string(),
                    },
                    to: PortRef {
                        node_id: "cache_get".to_string(),
                        port_name: "trigger".to_string(),
                    },
                },
                Edge {
                    from: PortRef {
                        node_id: "cache_get".to_string(),
                        port_name: "out".to_string(),
                    },
                    to: PortRef {
                        node_id: "sink".to_string(),
                        port_name: "in".to_string(),
                    },
                },
            ],
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "sink".to_string(),
                    port_name: "result".to_string(),
                },
            )]),
        );

        let mut second_context = EngineContext {
            persisted_rule_kv_json: Some(persisted),
            ..EngineContext::default()
        };
        second_context.port_inputs.insert(
            PortRef {
                node_id: "trigger".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("go".to_string()),
        );
        let second_result = execute_rule(&get_rule, second_context)
            .await
            .expect("二次执行应读取到 rule scope 缓存");

        assert_eq!(
            second_result.final_result,
            Some(RuntimeValue::Text("rule-value".to_string()))
        );
        assert!(
            second_result.events.iter().any(|event| {
                matches!(
                    event,
                    NodeEvent::NodeLog { node_id, message, .. }
                        if node_id == "cache_get" && message.contains("缓存命中")
                )
            }),
            "rule scope 命中应产生 NodeLog"
        );
    }

    #[tokio::test]
    async fn cache_rule_scope_reload_from_snapshot_after_simulated_restart() {
        let persisted_value = serde_json::to_string(&HashMap::from([(
            "restart_key".to_string(),
            serde_json::json!({
                "type": "text",
                "value": "restart-value"
            }),
        )]))
        .expect("测试快照 JSON 序列化应成功");

        let rule = build_rule(
            vec![
                Node {
                    id: "trigger".to_string(),
                    kind: NodeKind::Input,
                    phase: LifecyclePhase::Search,
                    inputs: vec![],
                    outputs: vec![text_port("out")],
                    params: BTreeMap::new(),
                },
                Node {
                    id: "cache_get".to_string(),
                    kind: NodeKind::CacheGet,
                    phase: LifecyclePhase::Search,
                    inputs: vec![text_port("trigger")],
                    outputs: vec![text_port("out")],
                    params: params(&[
                        ("key", "restart_key"),
                        ("scope", "rule"),
                        ("default", "fallback"),
                    ]),
                },
            ],
            vec![Edge {
                from: PortRef {
                    node_id: "trigger".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "trigger".to_string(),
                },
            }],
            BTreeMap::from([(
                LifecyclePhase::Search,
                PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "out".to_string(),
                },
            )]),
        );

        let mut context = EngineContext {
            persisted_rule_kv_json: Some(persisted_value),
            ..EngineContext::default()
        };
        context.port_inputs.insert(
            PortRef {
                node_id: "trigger".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("go".to_string()),
        );

        let result = execute_rule(&rule, context)
            .await
            .expect("重启后加载快照应可命中 rule scope 缓存");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("restart-value".to_string()))
        );
    }

    #[test]
    fn truncate_utf8_keeps_nearest_valid_boundary_for_multibyte() {
        let value = format!("{}你", "a".repeat(1022));

        let (truncated, is_truncated) = super::truncate_utf8(value, 1024);

        assert!(is_truncated);
        assert_eq!(truncated.len(), 1022);
        assert_eq!(truncated, "a".repeat(1022));
        assert!(std::str::from_utf8(truncated.as_bytes()).is_ok());
    }

    fn event_seq(event: &crate::rules_ir::NodeEvent) -> u64 {
        match event {
            crate::rules_ir::NodeEvent::RunStarted { seq, .. }
            | crate::rules_ir::NodeEvent::NodeStarted { seq, .. }
            | crate::rules_ir::NodeEvent::PortEmit { seq, .. }
            | crate::rules_ir::NodeEvent::NodeLog { seq, .. }
            | crate::rules_ir::NodeEvent::NodeError { seq, .. }
            | crate::rules_ir::NodeEvent::NodeFinished { seq, .. }
            | crate::rules_ir::NodeEvent::RunFinished { seq, .. } => *seq,
        }
    }
}
