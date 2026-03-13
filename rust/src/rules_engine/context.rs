use std::collections::{BTreeMap, HashMap};

use super::{NodeStats, RuntimeValue};
use crate::rules_ir::{LifecyclePhase, NodeEvent, PortRef};

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
