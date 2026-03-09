use std::collections::BTreeMap;

use regex::Regex;
use scraper::{Html, Selector};
use serde_json_path::JsonPath;
use sxd_document::parser;
use sxd_xpath::{Context, Factory, Value};

use super::{
    json_value_to_runtime_values, map_selected_values_to_outputs, node_failure, optional_param,
    parse_json_input, primary_input_value, reject_unknown_params, required_param,
};
use crate::{
    rules_engine::{EngineError, RuntimeValue},
    rules_ir::Node,
};

pub(crate) fn execute(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["attr", "engine", "extract", "group", "query"])?;

    match required_param(node, "engine")? {
        "css" => execute_css(node, inputs),
        "xpath" => execute_xpath(node, inputs),
        "jsonpath" | "jsonPath" | "jsonPointer" => execute_json_path(node, inputs),
        "regex" => execute_regex(node, inputs),
        other => Err(node_failure(
            node,
            format!("不支持 engine=`{other}`，仅支持 css/xpath/jsonpath/regex"),
        )),
    }
}

fn execute_css(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let query = required_param(node, "query")?;
    let extract = optional_param(node, "extract").unwrap_or("text");
    let attr = if extract == "attr" {
        Some(required_param(node, "attr")?)
    } else {
        None
    };
    let input = primary_input_value(node, inputs)?;
    let html = match input {
        RuntimeValue::Html(html) | RuntimeValue::Text(html) => html,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "CSS 选择只支持 html/text 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let selector = Selector::parse(query)
        .map_err(|error| node_failure(node, format!("CSS selector 解析失败：{error}")))?;
    let document = Html::parse_document(&html);
    let mut values = Vec::new();

    for element in document.select(&selector) {
        match extract {
            "text" => values.push(RuntimeValue::Text(element.text().collect::<String>())),
            "html" => values.push(RuntimeValue::Html(element.html())),
            "attr" => {
                if let Some(value) = attr.and_then(|attr_name| element.value().attr(attr_name)) {
                    values.push(RuntimeValue::Text(value.to_string()));
                }
            }
            other => {
                return Err(node_failure(
                    node,
                    format!("CSS extract=`{other}` 无效，仅支持 text/html/attr"),
                ));
            }
        }
    }

    map_selected_values_to_outputs(node, values)
}

fn execute_xpath(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let query = required_param(node, "query")?;
    let extract = optional_param(node, "extract").unwrap_or("text");
    let attr = if extract == "attr" {
        Some(required_param(node, "attr")?)
    } else {
        None
    };
    let input = primary_input_value(node, inputs)?;
    let html = match input {
        RuntimeValue::Html(html) | RuntimeValue::Text(html) => html,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "XPath 选择只支持 html/text 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let xpath_query = match extract {
        "attr" => format!("{query}/@{}", attr.unwrap_or_default()),
        "text" | "html" | "outerHtml" | "innerHtml" => query.to_string(),
        _ => {
            return Err(node_failure(
                node,
                format!(
                    "XPath extract=`{extract}` 无效，仅支持 text/html/outerHtml/innerHtml/attr"
                ),
            ));
        }
    };

    let package = parser::parse(&html)
        .map_err(|error| node_failure(node, format!("XPath 文档解析失败：{error}")))?;
    let document = package.as_document();
    let xpath = Factory::new()
        .build(&xpath_query)
        .map_err(|error| node_failure(node, format!("XPath 编译失败：{error}")))?
        .ok_or_else(|| node_failure(node, "XPath 表达式为空"))?;
    let evaluated = xpath
        .evaluate(&Context::new(), document.root())
        .map_err(|error| node_failure(node, format!("XPath 执行失败：{error}")))?;

    let values = match evaluated {
        Value::Nodeset(nodeset) => nodeset
            .document_order()
            .into_iter()
            .map(|selected_node| match extract {
                "text" => RuntimeValue::Text(selected_node.string_value()),
                "html" | "outerHtml" | "innerHtml" => {
                    RuntimeValue::Html(selected_node.string_value())
                }
                "attr" => RuntimeValue::Text(selected_node.string_value()),
                _ => unreachable!(),
            })
            .collect::<Vec<_>>(),
        Value::String(text) => vec![RuntimeValue::Text(text)],
        Value::Boolean(value) => vec![RuntimeValue::Text(value.to_string())],
        Value::Number(value) => vec![RuntimeValue::Text(value.to_string())],
    };

    map_selected_values_to_outputs(node, values)
}

fn execute_json_path(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let query = required_param(node, "query")?;
    let json = parse_json_input(node, primary_input_value(node, inputs)?)?;
    let json_path = JsonPath::parse(query)
        .map_err(|error| node_failure(node, format!("JSONPath 解析失败：{error}")))?;
    let nodes = json_path.query(&json).all();
    if nodes.is_empty() {
        return Err(node_failure(node, format!("JSONPath `{query}` 未命中")));
    }

    let values = nodes
        .into_iter()
        .flat_map(|value| json_value_to_runtime_values(value.clone()))
        .collect();

    map_selected_values_to_outputs(node, values)
}

fn execute_regex(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let query = required_param(node, "query")?;
    let group = optional_param(node, "group")
        .unwrap_or("0")
        .parse::<usize>()
        .map_err(|error| node_failure(node, format!("group 参数必须是数字：{error}")))?;
    let input = primary_input_value(node, inputs)?;
    let text = match input {
        RuntimeValue::Text(text) | RuntimeValue::Html(text) | RuntimeValue::Url(text) => text,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "Regex 选择只支持 text/html/url 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let regex = Regex::new(query)
        .map_err(|error| node_failure(node, format!("Regex 编译失败：{error}")))?;
    let values = regex
        .captures_iter(&text)
        .filter_map(|captures| captures.get(group))
        .map(|matched| RuntimeValue::Text(matched.as_str().to_string()))
        .collect();

    map_selected_values_to_outputs(node, values)
}
