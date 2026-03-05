//! XPath 选择器执行器
//!
//! 使用 rlibxml2 实现 XPath 1.0 查询功能。

use crate::error::{CrawlerError, ParseError};

/// XPath 执行器
pub struct XPathExecutor;

impl XPathExecutor {
    /// 执行 XPath 查询
    ///
    /// # 参数
    /// - `html`: HTML/XML 文档字符串
    /// - `query`: XPath 查询表达式
    ///
    /// # 返回
    /// 匹配结果的字符串数组
    pub fn execute(html: &str, query: &str) -> Result<Vec<String>, CrawlerError> {
        use rlibxml2::Document;

        // 解析 HTML 文档
        let doc = Document::parse(html).map_err(|e| ParseError::HtmlParse(e.to_string()))?;

        // 执行 XPath 查询
        let nodes = doc
            .select(query)
            .map_err(|e| ParseError::XPathSyntax(e.to_string()))?;

        // 提取结果
        let results: Vec<String> = nodes
            .into_iter()
            .map(|node| node.text().trim().to_string())
            .filter(|s| !s.is_empty())
            .collect();

        Ok(results)
    }

    /// 执行 XPath 查询并提取属性
    ///
    /// # 参数
    /// - `html`: HTML/XML 文档字符串
    /// - `query`: XPath 查询表达式
    /// - `attr`: 属性名
    ///
    /// # 返回
    /// 匹配节点的属性值数组
    pub fn execute_attr(html: &str, query: &str, attr: &str) -> Result<Vec<String>, CrawlerError> {
        use rlibxml2::Document;

        let doc = Document::parse(html).map_err(|e| ParseError::HtmlParse(e.to_string()))?;

        let nodes = doc
            .select(query)
            .map_err(|e| ParseError::XPathSyntax(e.to_string()))?;

        let results: Vec<String> = nodes
            .into_iter()
            .filter_map(|node| node.attr(attr).map(|s| s.to_string()))
            .collect();

        Ok(results)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_xpath_basic() {
        let html = r#"<html><body><div class="title">Hello World</div></body></html>"#;
        let result = XPathExecutor::execute(html, "//div[@class='title']").unwrap();
        assert_eq!(result, vec!["Hello World"]);
    }

    #[test]
    fn test_xpath_multiple() {
        let html = r#"<ul><li>Item 1</li><li>Item 2</li><li>Item 3</li></ul>"#;
        let result = XPathExecutor::execute(html, "//li").unwrap();
        assert_eq!(result, vec!["Item 1", "Item 2", "Item 3"]);
    }
}
