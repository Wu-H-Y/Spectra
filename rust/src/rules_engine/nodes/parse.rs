use std::collections::BTreeMap;

use super::{
    map_single_value_to_outputs, node_failure, normalize_param_value, parse_json_input,
    primary_input_value, reject_unknown_params, required_param,
};
use crate::{
    rules_engine::{EngineError, RuntimeValue},
    rules_ir::Node,
};

pub(crate) fn execute(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["format"])?;

    let format = normalize_param_value(required_param(node, "format")?);
    let input = primary_input_value(node, inputs)?;

    let value = match format.as_str() {
        "html" => match input {
            RuntimeValue::Html(html) => RuntimeValue::Html(html),
            RuntimeValue::Text(text) | RuntimeValue::Url(text) => RuntimeValue::Html(text),
            other => {
                return Err(node_failure(
                    node,
                    format!(
                        "HTML 解析只支持 text/html/url 输入，实际为 `{}`",
                        other.type_label()
                    ),
                ));
            }
        },
        "json" => RuntimeValue::Json(parse_json_input(node, input)?),
        other => {
            return Err(node_failure(
                node,
                format!("不支持 format=`{other}`，仅支持 html/json"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}
