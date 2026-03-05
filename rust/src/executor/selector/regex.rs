//! Regex 选择器执行器
//!
//! 使用 regex 库实现正则表达式匹配功能。

use crate::error::{CrawlerError, ParseError};

/// Regex 执行器
pub struct RegexExecutor;

impl RegexExecutor {
    /// 执行正则表达式匹配
    ///
    /// # 参数
    /// - `input`: 输入字符串
    /// - `pattern`: 正则表达式模式
    ///
    /// # 返回
    /// 匹配结果的字符串数组（返回所有捕获组或完整匹配）
    pub fn execute(input: &str, pattern: &str) -> Result<Vec<String>, CrawlerError> {
        use regex::Regex;

        // 编译正则表达式
        let re = Regex::new(pattern)
            .map_err(|e| ParseError::RegexSyntax(format!("正则表达式语法错误: {}", e)))?;

        let mut results = Vec::new();

        // 遍历所有匹配
        for caps in re.captures_iter(input) {
            // 如果有捕获组，返回第一个捕获组的内容
            // 否则返回完整匹配
            if caps.len() > 1 {
                // 跳过完整匹配（索引 0），只返回捕获组
                for i in 1..caps.len() {
                    if let Some(m) = caps.get(i) {
                        results.push(m.as_str().to_string());
                    }
                }
            } else if let Some(m) = caps.get(0) {
                results.push(m.as_str().to_string());
            }
        }

        Ok(results)
    }

    /// 执行正则表达式替换
    ///
    /// # 参数
    /// - `input`: 输入字符串
    /// - `pattern`: 正则表达式模式
    /// - `replacement`: 替换字符串
    ///
    /// # 返回
    /// 替换后的字符串
    pub fn replace(input: &str, pattern: &str, replacement: &str) -> Result<String, CrawlerError> {
        use regex::Regex;

        let re = Regex::new(pattern)
            .map_err(|e| ParseError::RegexSyntax(format!("正则表达式语法错误: {}", e)))?;

        Ok(re.replace_all(input, replacement).to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_regex_basic() {
        let input = "Hello 123 World 456";
        let result = RegexExecutor::execute(input, r"\d+").unwrap();
        assert_eq!(result, vec!["123", "456"]);
    }

    #[test]
    fn test_regex_capture_group() {
        let input = "url: https://example.com/page/1 and https://example.com/page/2";
        let result = RegexExecutor::execute(input, r"/page/(\d+)").unwrap();
        assert_eq!(result, vec!["1", "2"]);
    }

    #[test]
    fn test_regex_replace() {
        let input = "Hello   World";
        let result = RegexExecutor::replace(input, r"\s+", " ").unwrap();
        assert_eq!(result, "Hello World");
    }
}
