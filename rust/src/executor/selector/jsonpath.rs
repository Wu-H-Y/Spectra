//! JSONPath 选择器执行器
//!
//! 使用 jsonpath-rust 库实现 JSONPath 查询功能。

use crate::error::{CrawlerError, ParseError};

/// JSONPath 执行器
pub struct JsonPathExecutor;

impl JsonPathExecutor {
    /// 执行 JSONPath 查询
    ///
    /// # 参数
    /// - `json`: JSON 字符串
    /// - `path`: JSONPath 查询表达式
    ///
    /// # 返回
    /// 匹配结果的字符串数组
    pub fn execute(json: &str, path: &str) -> Result<Vec<String>, CrawlerError> {
        use jsonpath_rust::JsonPathFinder;
        use serde_json::Value;

        // 使用 JsonPathFinder 进行查询
        let finder = JsonPathFinder::from_str(json, path)
            .map_err(|e| ParseError::JsonPathSyntax(format!("JSONPath 解析错误: {}", e)))?;

        let result = finder.find();

        // 将结果转换为字符串数组
        let results: Vec<String> = match result {
            Value::Array(arr) => arr
                .into_iter()
                .map(|v| match v {
                    Value::String(s) => s,
                    Value::Number(n) => n.to_string(),
                    Value::Bool(b) => b.to_string(),
                    Value::Null => String::new(),
                    other => other.to_string(),
                })
                .filter(|s| !s.is_empty())
                .collect(),
            Value::String(s) => vec![s],
            Value::Number(n) => vec![n.to_string()],
            Value::Bool(b) => vec![b.to_string()],
            Value::Null => vec![],
            _ => vec![result.to_string()],
        };

        Ok(results)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_jsonpath_basic() {
        let json = r#"{"store": {"book": {"title": "Hello World"}}}"#;
        let result = JsonPathExecutor::execute(json, "$.store.book.title").unwrap();
        assert_eq!(result, vec!["Hello World"]);
    }

    #[test]
    fn test_jsonpath_array() {
        let json = r#"{"items": ["a", "b", "c"]}"#;
        let result = JsonPathExecutor::execute(json, "$.items[*]").unwrap();
        assert_eq!(result, vec!["a", "b", "c"]);
    }
}
