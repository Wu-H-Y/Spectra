//! 字符串操作工具
//!
//! 提供高性能的字符串变换操作。

use crate::error::{CrawlerError, ParseError};

/// 字符串操作工具类
pub struct StringOps;

impl StringOps {
    /// 去除字符串两端空白字符
    pub fn trim(input: &str) -> String {
        input.trim().to_string()
    }

    /// 转换为小写
    pub fn lower(input: &str) -> String {
        input.to_lowercase()
    }

    /// 转换为大写
    pub fn upper(input: &str) -> String {
        input.to_uppercase()
    }

    /// 正则替换
    ///
    /// # 参数
    /// - `input`: 输入字符串
    /// - `pattern`: 正则表达式模式
    /// - `replacement`: 替换字符串
    pub fn replace(input: &str, pattern: &str, replacement: &str) -> Result<String, CrawlerError> {
        use regex::Regex;

        let re = Regex::new(pattern)
            .map_err(|e| ParseError::RegexSyntax(format!("正则表达式语法错误: {}", e)))?;

        Ok(re.replace_all(input, replacement).to_string())
    }

    /// URL 拼接
    ///
    /// 将相对 URL 与基础 URL 拼接成绝对 URL
    ///
    /// # 参数
    /// - `base`: 基础 URL
    /// - `relative`: 相对路径
    pub fn url_join(base: &str, relative: &str) -> Result<String, CrawlerError> {
        use url::Url;

        // 如果 relative 已经是绝对 URL，直接返回
        if relative.starts_with("http://") || relative.starts_with("https://") {
            return Ok(relative.to_string());
        }

        let base_url = Url::parse(base)
            .map_err(|e| CrawlerError::InvalidInput(format!("无效的基础 URL: {}", e)))?;

        let joined = base_url
            .join(relative)
            .map_err(|e| CrawlerError::InvalidInput(format!("URL 拼接失败: {}", e)))?;

        Ok(joined.to_string())
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_trim() {
        assert_eq!(StringOps::trim("  hello  "), "hello");
        assert_eq!(StringOps::trim("\t\nworld\t\n"), "world");
    }

    #[test]
    fn test_lower() {
        assert_eq!(StringOps::lower("HELLO"), "hello");
        assert_eq!(StringOps::lower("HeLLo WoRLD"), "hello world");
    }

    #[test]
    fn test_upper() {
        assert_eq!(StringOps::upper("hello"), "HELLO");
        assert_eq!(StringOps::upper("HeLLo WoRLD"), "HELLO WORLD");
    }

    #[test]
    fn test_replace() {
        let result = StringOps::replace("hello world", "world", "rust").unwrap();
        assert_eq!(result, "hello rust");
    }

    #[test]
    fn test_url_join() {
        let result = StringOps::url_join("https://example.com/page/", "../other").unwrap();
        assert_eq!(result, "https://example.com/other");

        let result = StringOps::url_join("https://example.com/", "/path").unwrap();
        assert_eq!(result, "https://example.com/path");

        // 绝对 URL 直接返回
        let result = StringOps::url_join("https://example.com/", "https://other.com/page").unwrap();
        assert_eq!(result, "https://other.com/page");
    }
}
