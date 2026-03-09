use std::collections::BTreeMap;

use serde_json::Value as JsonValue;

use super::{EngineError, RuntimeValue};
use crate::rules_ir::{DataType, Node};

pub(crate) mod cache;
pub(crate) mod cookie;
pub(crate) mod fetch;
pub(crate) mod map_to_model;
pub(crate) mod parse;
pub(crate) mod select;
pub(crate) mod transform;

pub(crate) fn node_failure(node: &Node, message: impl Into<String>) -> EngineError {
    EngineError::NodeFailed {
        node_id: node.id.clone(),
        message: message.into(),
        code: None,
    }
}

pub(crate) fn reject_unknown_params(node: &Node, allowed: &[&str]) -> Result<(), EngineError> {
    for key in node.params.keys() {
        if !allowed.iter().any(|item| item == key) {
            return Err(node_failure(
                node,
                format!("不支持参数 `{key}`，允许参数：{}", allowed.join(", ")),
            ));
        }
    }

    Ok(())
}

pub(crate) fn required_param<'a>(node: &'a Node, key: &str) -> Result<&'a str, EngineError> {
    node.params
        .get(key)
        .map(String::as_str)
        .ok_or_else(|| node_failure(node, format!("缺少必填参数 `{key}`")))
}

pub(crate) fn optional_param<'a>(node: &'a Node, key: &str) -> Option<&'a str> {
    node.params.get(key).map(String::as_str)
}

pub(crate) fn normalize_param_value(value: &str) -> String {
    value.trim().to_ascii_lowercase()
}

pub(crate) fn primary_input_value(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<RuntimeValue, EngineError> {
    let port_name = node
        .inputs
        .first()
        .map(|port| port.name.clone())
        .unwrap_or_else(|| "input".to_string());

    inputs
        .get(&port_name)
        .and_then(|values| values.last())
        .cloned()
        .ok_or_else(|| EngineError::MissingInput {
            node_id: node.id.clone(),
            port_name,
        })
}

pub(crate) fn map_single_value_to_outputs(
    node: &Node,
    value: RuntimeValue,
) -> BTreeMap<String, Vec<RuntimeValue>> {
    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        outputs.insert(output.name.clone(), vec![value.clone()]);
    }
    outputs
}

pub(crate) fn map_selected_values_to_outputs(
    node: &Node,
    values: Vec<RuntimeValue>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let mut outputs = BTreeMap::new();

    for output in &node.outputs {
        let emitted = match &output.data_type {
            DataType::List { .. } => vec![RuntimeValue::List(values.clone())],
            _ => {
                let value = values.first().cloned().ok_or_else(|| {
                    node_failure(node, format!("端口 `{}` 未选中任何结果", output.name))
                })?;
                vec![value]
            }
        };
        outputs.insert(output.name.clone(), emitted);
    }

    Ok(outputs)
}

pub(crate) fn parse_json_input(node: &Node, value: RuntimeValue) -> Result<JsonValue, EngineError> {
    match value {
        RuntimeValue::Json(json) => Ok(json),
        RuntimeValue::Text(text) => serde_json::from_str(&text)
            .map_err(|error| node_failure(node, format!("JSON 解析失败：{error}"))),
        other => Err(node_failure(
            node,
            format!(
                "当前节点只支持 text/json 输入，实际为 `{}`",
                other.type_label()
            ),
        )),
    }
}

pub(crate) fn json_value_to_runtime(value: JsonValue) -> RuntimeValue {
    match value {
        JsonValue::String(text) => RuntimeValue::Text(text),
        other => RuntimeValue::Json(other),
    }
}

pub(crate) fn json_value_to_runtime_values(value: JsonValue) -> Vec<RuntimeValue> {
    match value {
        JsonValue::Array(items) => items.into_iter().map(json_value_to_runtime).collect(),
        other => vec![json_value_to_runtime(other)],
    }
}
