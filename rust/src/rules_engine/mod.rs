use std::{
    collections::{BTreeMap, HashMap},
    fmt,
    sync::Arc,
    time::{Duration, Instant, SystemTime, UNIX_EPOCH},
};

use serde_json::Value as JsonValue;
use tokio::sync::{Mutex, mpsc};

use crate::rules_ir::{
    DataType, LifecyclePhase, Node, NodeEvent, NodeKind, NormalizedModel, PortRef, RuleEnvelope,
};

const DEFAULT_CHANNEL_CAPACITY: usize = 8;
const PAYLOAD_PREVIEW_LIMIT_BYTES: usize = 1024;

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
            Self::NodeFailed { node_id, message } => {
                write!(formatter, "节点 `{node_id}` 执行失败：{message}")
            }
            Self::TaskJoin(message) => write!(formatter, "异步任务执行失败：{message}"),
        }
    }
}

impl std::error::Error for EngineError {}

impl EngineError {
    fn code(&self) -> &'static str {
        match self {
            Self::MissingInput { .. } => "MISSING_INPUT",
            Self::TypeMismatch { .. } => "TYPE_MISMATCH",
            Self::JoinWithoutInputs { .. } => "JOIN_WITHOUT_INPUTS",
            Self::MissingFinalResult => "MISSING_FINAL_RESULT",
            Self::NodeFailed { .. } => "NODE_FAILED",
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
    let (event_tx, event_rx) = mpsc::channel(channel_capacity);

    let event_collector = tokio::spawn(collect_events(run_id.clone(), trace_id.clone(), event_rx));
    send_event(&event_tx, EventCommand::RunStarted).await;

    let shared_context = Arc::new(context);
    let mut handles = Vec::with_capacity(graph.nodes.len());
    for runtime_node in graph.nodes {
        handles.push(tokio::spawn(run_node(
            runtime_node,
            shared_context.clone(),
            output_store.clone(),
            node_stats.clone(),
            event_tx.clone(),
        )));
    }

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
    })
}

async fn run_node(
    runtime_node: RuntimeNode,
    context: Arc<EngineContext>,
    output_store: Arc<Mutex<HashMap<PortRef, Vec<RuntimeValue>>>>,
    node_stats: Arc<Mutex<BTreeMap<String, NodeStats>>>,
    event_tx: mpsc::Sender<EventCommand>,
) -> Result<(), EngineError> {
    send_event(
        &event_tx,
        EventCommand::NodeStarted {
            node_id: runtime_node.node.id.clone(),
        },
    )
    .await;

    let started_at = Instant::now();
    let node_id = runtime_node.node.id.clone();
    let inputs =
        match collect_inputs(&runtime_node.node, runtime_node.input_receivers, &context).await {
            Ok(inputs) => inputs,
            Err(error) => {
                emit_node_failure(
                    &event_tx,
                    &node_stats,
                    &node_id,
                    &error,
                    started_at.elapsed(),
                )
                .await;
                return Err(error);
            }
        };
    let input_messages = inputs.values().map(Vec::len).sum();
    let emitted_outputs = match execute_node_semantics(&runtime_node.node, &inputs) {
        Ok(outputs) => outputs,
        Err(error) => {
            emit_node_failure(
                &event_tx,
                &node_stats,
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
        let Some(values) = emitted_outputs.get(&output.name) else {
            continue;
        };

        for value in values {
            let coerced = match coerce_to_type_for_port(
                &runtime_node.node.id,
                &output.name,
                value.clone(),
                &output.data_type,
            ) {
                Ok(value) => value,
                Err(error) => {
                    emit_node_failure(
                        &event_tx,
                        &node_stats,
                        &node_id,
                        &error,
                        started_at.elapsed(),
                    )
                    .await;
                    return Err(error);
                }
            };
            store_output_value(&output_store, &runtime_node.node.id, &output.name, &coerced).await;
            output_messages += 1;

            let (payload_preview, payload_truncated) = preview_payload(&coerced);
            send_event(
                &event_tx,
                EventCommand::PortEmit {
                    node_id: runtime_node.node.id.clone(),
                    port: output.name.clone(),
                    payload_preview: Some(payload_preview),
                    payload_truncated,
                },
            )
            .await;

            if let Some(senders) = runtime_node.output_senders.get(&output.name) {
                for sender in senders {
                    let _ = sender.send(coerced.clone()).await;
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
    update_node_stats(&node_stats, &runtime_node.node.id, stats).await;
    send_event(
        &event_tx,
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

fn execute_node_semantics(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    match node.kind {
        NodeKind::Input => Ok(inputs.clone()),
        NodeKind::Join => execute_join(node, inputs),
        _ => execute_passthrough(node, inputs),
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
        } => Some(NodeEvent::PortEmit {
            run_id: run_id.to_string(),
            seq,
            trace_id,
            span_id: None,
            node_id,
            port,
            payload_preview,
            payload_truncated,
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
    use std::collections::BTreeMap;

    use super::{EngineContext, RuntimeValue, execute_rule};
    use crate::rules_ir::{
        Capabilities, DataType, Edge, Graph, LifecyclePhase, Metadata, Node, NodeKind, Port,
        PortRef, RuleEnvelope,
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
            },
        }
    }

    #[tokio::test]
    async fn chain_execution_emits_monotonic_seq_and_stats() {
        let nodes = vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
            },
            Node {
                id: "passthrough".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
            },
        ];
        let edges = vec![
            Edge {
                from: PortRef {
                    node_id: "input".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "passthrough".to_string(),
                    port_name: "in".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "passthrough".to_string(),
                    port_name: "out".to_string(),
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
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            RuntimeValue::Text("hello-engine".to_string()),
        );
        context.run_id = Some("run-chain".to_string());

        let result = execute_rule(&rule, context)
            .await
            .expect("链式图应执行成功");

        assert_eq!(
            result.final_result,
            Some(RuntimeValue::Text("hello-engine".to_string()))
        );
        assert_eq!(result.events.first().map(event_seq), Some(1));
        assert!(matches!(
            result.events.first(),
            Some(crate::rules_ir::NodeEvent::RunStarted { .. })
        ));
        assert!(matches!(
            result.events.last(),
            Some(crate::rules_ir::NodeEvent::RunFinished { success: true, .. })
        ));
        assert!(
            result
                .events
                .windows(2)
                .all(|pair| event_seq(&pair[1]) > event_seq(&pair[0]))
        );
        assert_eq!(result.node_stats.len(), 3);
        assert!(result.node_stats.values().all(|stats| stats.success));
        assert_eq!(result.node_stats["input"].output_messages, 1);
        assert_eq!(result.node_stats["passthrough"].input_messages, 1);
        assert_eq!(result.node_stats["sink"].input_messages, 1);
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
            },
            Node {
                id: "left".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
            },
            Node {
                id: "right".to_string(),
                kind: NodeKind::Transform,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
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
            },
            Node {
                id: "right_input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
            },
            Node {
                id: "join".to_string(),
                kind: NodeKind::Join,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("left"), text_port("right")],
                outputs: vec![list_text_port("joined")],
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![list_text_port("in")],
                outputs: vec![list_text_port("result")],
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
