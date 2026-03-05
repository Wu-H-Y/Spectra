//! 爬虫执行器模块
//!
//! 提供 HTML 解析、选择器执行、变换操作等功能。
//! 所有执行器都在 Rust 端实现，通过 FFI 暴露给 Dart。

pub mod selector;
pub mod transform;

pub use selector::{CssExecutor, JsonPathExecutor, RegexExecutor, XPathExecutor};
pub use transform::{JsExecutor, StringOps};

use crate::{
    domain::rule::pipeline::{SelectorDef, TransformDef},
    error::CrawlerError,
};

/// 选择器执行结果
pub type SelectorResult = Vec<String>;

/// 执行选择器操作
///
/// 根据选择器定义从输入内容中提取数据
pub fn execute_selector(
    input: &str,
    selector: &SelectorDef,
    base_url: Option<&str>,
) -> Result<SelectorResult, CrawlerError> {
    match selector {
        SelectorDef::Css { selector } => CssExecutor::execute(input, selector),
        SelectorDef::XPath { query } => XPathExecutor::execute(input, query),
        SelectorDef::JsonPath { path } => JsonPathExecutor::execute(input, path),
        SelectorDef::Regex { pattern } => RegexExecutor::execute(input, pattern),
    }
    .map(|results| {
        // 如果有 base_url 且需要 URL 处理
        if let Some(url) = base_url {
            results
                .into_iter()
                .map(|r| StringOps::url_join(url, &r).unwrap_or(r))
                .collect()
        } else {
            results
        }
    })
}

/// 执行变换操作
///
/// 对输入字符串应用变换
pub fn execute_transform(
    input: &[String],
    transform: &TransformDef,
    vars: Option<&serde_json::Value>,
) -> Result<Vec<String>, CrawlerError> {
    match transform {
        TransformDef::Trim => Ok(input.iter().map(|s| StringOps::trim(s)).collect()),
        TransformDef::Lower => Ok(input.iter().map(|s| StringOps::lower(s)).collect()),
        TransformDef::Upper => Ok(input.iter().map(|s| StringOps::upper(s)).collect()),
        TransformDef::RegexReplace { pattern, replace } => input
            .iter()
            .map(|s| StringOps::replace(s, pattern, replace))
            .collect(),
        TransformDef::Text => Ok(input.to_vec()),
        TransformDef::Attr { name: _ } => {
            // Attr 在选择器阶段处理，此处直接返回
            Ok(input.to_vec())
        }
        TransformDef::Url => Ok(input.to_vec()),
        TransformDef::Js { script } => {
            let mut results = Vec::with_capacity(input.len());
            for val in input {
                let result = JsExecutor::execute(script, val, vars)?;
                results.push(result);
            }
            Ok(results)
        }
    }
}
