#![allow(dead_code)]

//! HTML 解析器 API
//!
//! 提供统一的 HTML 解析和数据提取入口点，通过 FFI 暴露给 Dart。

use crate::{
    domain::rule::pipeline::{PipelineExecuteRequest, PipelineExecuteResult, PipelineOperation},
    error::CrawlerError,
    executor::{selector::CssExecutor, transform::StringOps},
};

/// 解析 HTML 并执行单个选择器查询
///
/// # 参数
/// - `html`: HTML 文档字符串
/// - `selector_type`: 选择器类型 ("xpath", "css", "jsonpath", "regex")
/// - `query`: 查询表达式
///
/// # 返回
/// 匹配结果的字符串数组
pub(crate) fn parse_html(html: String, selector_type: String, query: String) -> Vec<String> {
    match parse_html_internal(&html, &selector_type, &query) {
        Ok(results) => results,
        Err(e) => {
            log::error!("HTML 解析失败: {}", e);
            vec![]
        }
    }
}

fn parse_html_internal(
    html: &str,
    selector_type: &str,
    query: &str,
) -> Result<Vec<String>, CrawlerError> {
    match selector_type {
        "xpath" => crate::executor::XPathExecutor::execute(html, query),
        "css" => CssExecutor::execute(html, query),
        "jsonpath" => crate::executor::JsonPathExecutor::execute(html, query),
        "regex" => crate::executor::RegexExecutor::execute(html, query),
        _ => Err(CrawlerError::InvalidInput(format!(
            "不支持的选择器类型: {}",
            selector_type
        ))),
    }
}

/// 执行完整的 Pipeline 操作序列
///
/// # 参数
/// - `request`: Pipeline 执行请求
///
/// # 返回
/// Pipeline 执行结果
pub(crate) fn execute_pipeline(request: PipelineExecuteRequest) -> PipelineExecuteResult {
    match execute_pipeline_internal(&request) {
        Ok(data) => PipelineExecuteResult {
            success: true,
            data,
            error: None,
        },
        Err(e) => {
            log::error!("Pipeline 执行失败: {}", e);
            PipelineExecuteResult {
                success: false,
                data: vec![],
                error: Some(e.to_string()),
            }
        }
    }
}

fn execute_pipeline_internal(
    request: &PipelineExecuteRequest,
) -> Result<Vec<String>, CrawlerError> {
    let mut current_input = vec![request.content.clone()];
    let vars: Option<serde_json::Value> = request
        .vars
        .as_ref()
        .and_then(|v| serde_json::from_str(v).ok());

    for op in &request.operations {
        current_input = execute_operation(
            op,
            &current_input,
            request.base_url.as_deref(),
            vars.as_ref(),
        )?;
    }

    Ok(current_input)
}

fn execute_operation(
    op: &PipelineOperation,
    input: &[String],
    base_url: Option<&str>,
    vars: Option<&serde_json::Value>,
) -> Result<Vec<String>, CrawlerError> {
    match op.op_type.as_str() {
        // 选择器操作
        "xpath" => {
            let query = op.param.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("XPath 操作缺少 query 参数".to_string())
            })?;
            let mut results = Vec::new();
            for content in input {
                let r = crate::executor::XPathExecutor::execute(content, query)?;
                results.extend(r);
            }
            Ok(results)
        }
        "css" => {
            let selector = op.param.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("CSS 操作缺少 selector 参数".to_string())
            })?;
            let mut results = Vec::new();
            for content in input {
                let r = CssExecutor::execute(content, selector)?;
                results.extend(r);
            }
            Ok(results)
        }
        "jsonpath" => {
            let path = op.param.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("JSONPath 操作缺少 path 参数".to_string())
            })?;
            let mut results = Vec::new();
            for content in input {
                let r = crate::executor::JsonPathExecutor::execute(content, path)?;
                results.extend(r);
            }
            Ok(results)
        }
        "regex" => {
            let pattern = op.param.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("Regex 操作缺少 pattern 参数".to_string())
            })?;
            let mut results = Vec::new();
            for content in input {
                let r = crate::executor::RegexExecutor::execute(content, pattern)?;
                results.extend(r);
            }
            Ok(results)
        }
        // 属性提取
        "attr" => {
            let attr_name = op
                .param
                .as_ref()
                .ok_or_else(|| CrawlerError::InvalidInput("Attr 操作缺少 name 参数".to_string()))?;
            let mut results = Vec::new();
            // 需要从原始 HTML 中提取属性，这里简化处理
            // 实际使用时可能需要调整 pipeline 设计
            for content in input {
                let r = CssExecutor::execute_attr(content, "*", attr_name)?;
                results.extend(r);
            }
            Ok(results)
        }
        // 文本提取
        "text" => Ok(input.to_vec()),
        // 变换操作
        "trim" => Ok(input.iter().map(|s| StringOps::trim(s)).collect()),
        "lower" => Ok(input.iter().map(|s| StringOps::lower(s)).collect()),
        "upper" => Ok(input.iter().map(|s| StringOps::upper(s)).collect()),
        "replace" => {
            let pattern = op.param.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("Replace 操作缺少 pattern 参数".to_string())
            })?;
            let replacement = op.param2.as_ref().ok_or_else(|| {
                CrawlerError::InvalidInput("Replace 操作缺少 replacement 参数".to_string())
            })?;
            input
                .iter()
                .map(|s| StringOps::replace(s, pattern, replacement))
                .collect()
        }
        "url" => {
            if let Some(base) = base_url {
                input.iter().map(|s| StringOps::url_join(base, s)).collect()
            } else {
                Ok(input.to_vec())
            }
        }
        "js" => {
            let script = op
                .param
                .as_ref()
                .ok_or_else(|| CrawlerError::InvalidInput("JS 操作缺少 script 参数".to_string()))?;
            let mut results = Vec::with_capacity(input.len());
            for val in input {
                let result = crate::executor::JsExecutor::execute(script, val, vars)?;
                results.push(result);
            }
            Ok(results)
        }
        "first" => Ok(input.first().cloned().into_iter().collect()),
        "last" => Ok(input.last().cloned().into_iter().collect()),
        "join" => {
            let separator = op.param.as_deref().unwrap_or("");
            Ok(vec![input.join(separator)])
        }
        "array" => Ok(input.to_vec()),
        _ => Err(CrawlerError::InvalidInput(format!(
            "不支持的操作类型: {}",
            op.op_type
        ))),
    }
}

/// 执行 CSS 选择器并提取属性
///
/// # 参数
/// - `html`: HTML 文档字符串
/// - `selector`: CSS 选择器
/// - `attr`: 属性名
///
/// # 返回
/// 匹配元素的属性值数组
pub(crate) fn css_select_attr(html: String, selector: String, attr: String) -> Vec<String> {
    match CssExecutor::execute_attr(&html, &selector, &attr) {
        Ok(results) => results,
        Err(e) => {
            log::error!("CSS 属性提取失败: {}", e);
            vec![]
        }
    }
}

/// 执行 JavaScript 代码
///
/// # 参数
/// - `script`: JavaScript 代码
/// - `val`: 当前值
/// - `vars_json`: 上下文变量 (JSON 字符串)
///
/// # 返回
/// 执行结果
pub(crate) fn execute_js(script: String, val: String, vars_json: Option<String>) -> String {
    let vars = vars_json
        .as_ref()
        .and_then(|v| serde_json::from_str(v).ok());
    match crate::executor::JsExecutor::execute(&script, &val, vars.as_ref()) {
        Ok(result) => result,
        Err(e) => {
            log::error!("JS 执行失败: {}", e);
            val
        }
    }
}
