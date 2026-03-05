//! 爬虫执行器错误定义模块
//!
//! 定义了 HTML 解析、选择器执行、变换操作等过程中可能发生的所有错误类型。

use thiserror::Error;

/// 爬虫执行器统一错误类型
#[derive(Debug, Clone, Error)]
#[flutter_rust_bridge::frb(dart_metadata=("freezed"))]
pub enum CrawlerError {
    /// 解析错误 - HTML/XML/JSON 解析失败
    #[error("解析错误: {0}")]
    ParseError(#[from] ParseError),

    /// 构建错误 - 执行器或配置构建失败
    #[error("构建错误: {0}")]
    BuildError(#[from] BuildError),

    /// JavaScript 执行错误
    #[error("JavaScript 执行错误: {0}")]
    JsError(String),

    /// 输入数据无效
    #[error("输入数据无效: {0}")]
    InvalidInput(String),

    /// 选择器未匹配到结果
    #[error("选择器未匹配到结果: {0}")]
    NoMatch(String),

    /// 需要认证（通常为 WAF 拦截）
    #[error("需要认证: {0}")]
    AuthRequired(String),

    /// 阶段配置缺失
    #[error("规则缺少阶段配置: {phase}")]
    MissingPhaseConfig { phase: String },

    /// URL 模板替换失败
    #[error("URL 模板替换失败: {reason}")]
    UrlTemplateError { reason: String },

    /// 不支持的响应类型
    #[error("不支持的响应类型: {content_type}")]
    UnsupportedContentType { content_type: String },

    /// 数据解析失败
    #[error("数据解析失败: {reason}")]
    DataParseError { reason: String },

    /// 缺少必需的上下文参数
    #[error("缺少必需上下文字段: {field}")]
    MissingRequiredContext { field: String },
}

/// 解析错误类型
#[derive(Debug, Clone, Error)]
#[flutter_rust_bridge::frb(dart_metadata=("freezed"))]
pub enum ParseError {
    /// HTML 解析失败
    #[error("HTML 解析失败: {0}")]
    HtmlParse(String),

    /// XML 解析失败
    #[error("XML 解析失败: {0}")]
    XmlParse(String),

    /// JSON 解析失败
    #[error("JSON 解析失败: {0}")]
    JsonParse(String),

    /// XPath 语法错误
    #[error("XPath 语法错误: {0}")]
    XPathSyntax(String),

    /// CSS 选择器语法错误
    #[error("CSS 选择器语法错误: {0}")]
    CssSyntax(String),

    /// JSONPath 语法错误
    #[error("JSONPath 语法错误: {0}")]
    JsonPathSyntax(String),

    /// 正则表达式语法错误
    #[error("正则表达式语法错误: {0}")]
    RegexSyntax(String),
}

/// 构建错误类型
#[derive(Debug, Clone, Error)]
#[flutter_rust_bridge::frb(dart_metadata=("freezed"))]
pub enum BuildError {
    /// 执行器配置无效
    #[error("执行器配置无效: {0}")]
    InvalidConfig(String),

    /// 缺少必要参数
    #[error("缺少必要参数: {0}")]
    MissingParameter(String),

    /// 不支持的操作类型
    #[error("不支持的操作类型: {0}")]
    UnsupportedOperation(String),

    /// 初始化失败
    #[error("初始化失败: {0}")]
    InitializationFailed(String),
}
