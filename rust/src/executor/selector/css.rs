//! CSS 选择器执行器
//!
//! 使用 scraper 库实现 CSS 选择器查询功能。

use crate::error::{CrawlerError, ParseError};

/// CSS 执行器
pub struct CssExecutor;

impl CssExecutor {
    /// 执行 CSS 选择器查询
    ///
    /// # 参数
    /// - `html`: HTML 文档字符串
    /// - `selector`: CSS 选择器表达式
    ///
    /// # 返回
    /// 匹配结果的字符串数组
    pub fn execute(html: &str, selector: &str) -> Result<Vec<String>, CrawlerError> {
        use scraper::{Html, Selector};

        // 解析 HTML 文档
        let document = Html::parse_document(html);

        // 编译 CSS 选择器
        let sel = Selector::parse(selector)
            .map_err(|e| ParseError::CssSyntax(format!("无效的 CSS 选择器: {}", e)))?;

        // 提取匹配元素
        let results: Vec<String> = document
            .select(&sel)
            .map(|element| {
                // 默认返回元素的文本内容
                element.text().collect::<String>().trim().to_string()
            })
            .filter(|s| !s.is_empty())
            .collect();

        Ok(results)
    }

    /// 执行 CSS 选择器查询并返回元素属性
    ///
    /// # 参数
    /// - `html`: HTML 文档字符串
    /// - `selector`: CSS 选择器表达式
    /// - `attr`: 属性名
    ///
    /// # 返回
    /// 匹配元素的属性值数组
    pub fn execute_attr(
        html: &str,
        selector: &str,
        attr: &str,
    ) -> Result<Vec<String>, CrawlerError> {
        use scraper::{Html, Selector};

        let document = Html::parse_document(html);
        let sel = Selector::parse(selector)
            .map_err(|e| ParseError::CssSyntax(format!("无效的 CSS 选择器: {}", e)))?;

        let results: Vec<String> = document
            .select(&sel)
            .filter_map(|element| element.value().attr(attr).map(|s| s.to_string()))
            .collect();

        Ok(results)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_css_basic() {
        let html = r#"<html><body><div class="title">Hello World</div></body></html>"#;
        let result = CssExecutor::execute(html, ".title").unwrap();
        assert_eq!(result, vec!["Hello World"]);
    }

    #[test]
    fn test_css_multiple() {
        let html = r#"<ul><li>Item 1</li><li>Item 2</li><li>Item 3</li></ul>"#;
        let result = CssExecutor::execute(html, "li").unwrap();
        assert_eq!(result, vec!["Item 1", "Item 2", "Item 3"]);
    }

    #[test]
    fn test_css_attr() {
        let html = r#"<a href="https://example.com">Link</a>"#;
        let result = CssExecutor::execute_attr(html, "a", "href").unwrap();
        assert_eq!(result, vec!["https://example.com"]);
    }
}
