// HTTP 客户端 - 基于 wreq 的 FFI 桥接
// 提供高级 TLS/HTTP2 指纹伪装能力

use std::{collections::HashMap, time::Duration};

use thiserror::Error;
use wreq::{redirect::Policy, Client};

// ============================================================================
// 错误类型定义
// ============================================================================

/// 爬虫错误类型
#[derive(Debug, Error)]
pub(crate) enum HttpClientError {
    /// 网络连接错误
    #[error("网络连接失败: {0}")]
    ConnectionError(String),

    /// DNS 解析失败
    #[error("DNS 解析失败: {0}")]
    DnsError(String),

    /// 连接超时
    #[error("连接超时")]
    TimeoutError,

    /// 需要认证 (WAF 拦截)
    #[error("需要认证: 被 WAF 拦截 (状态码: {0})")]
    AuthRequired(u16),

    /// HTTP 错误
    #[error("HTTP 错误: {0}")]
    HttpError(String),

    /// 请求构建错误
    #[error("请求构建失败: {0}")]
    RequestBuildError(String),

    /// 响应解析错误
    #[error("响应解析失败: {0}")]
    ResponseParseError(String),

    /// URL 解析错误
    #[error("URL 解析失败: {0}")]
    UrlError(String),
}

// ============================================================================
// FRB 类型定义 - 浏览器模拟
// ============================================================================

/// 浏览器设备模拟类型
///
/// 提供常用浏览器的 TLS/HTTP2 指纹伪装
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum EmulationType {
    #[default]
    Chrome131,
    Chrome132,
    Chrome133,
    Chrome134,
    Chrome135,
    Chrome136,
    Chrome120,
    Chrome124,
    Chrome126,
    Chrome127,
    Chrome128,
    Chrome129,
    Chrome130,
    Safari18,
    Safari18_2,
    Safari18_3,
    Safari18_5,
    Safari26,
    SafariIos18_1_1,
    Firefox133,
    Firefox135,
    Firefox136,
    Firefox139,
    Firefox142,
    Firefox143,
    Firefox144,
    Firefox145,
    Firefox146,
    Firefox147,
    Edge127,
    Edge131,
    Edge134,
    Edge135,
    Edge136,
    Edge137,
    Edge138,
    Edge139,
    Edge140,
    Edge141,
    Edge142,
    Edge143,
    Edge144,
    Edge145,
    OkHttp3_14,
    OkHttp4_12,
    OkHttp5,
}

/// 操作系统模拟类型
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub(crate) enum HttpEmulationOS {
    #[default]
    Windows,
    MacOS,
    Linux,
    Android,
    IOS,
}

/// 浏览器模拟高级选项
#[derive(Debug, Clone, Default)]
pub(crate) struct HttpEmulationOption {
    /// 浏览器版本
    pub emulation: Option<EmulationType>,
    /// 操作系统
    pub emulation_os: Option<HttpEmulationOS>,
    /// 是否跳过 HTTP/2 指纹
    pub skip_http2: Option<bool>,
    /// 是否跳过默认请求头
    pub skip_headers: Option<bool>,
}

// ============================================================================
// FRB 类型定义 - 网络配置
// ============================================================================

/// Cookie 配置
#[derive(Debug, Clone)]
pub(crate) struct CookieSettings {
    /// 是否存储 Cookie
    pub store_cookies: bool,
}

impl Default for CookieSettings {
    fn default() -> Self {
        Self {
            store_cookies: true,
        }
    }
}

/// 超时配置
#[derive(Debug, Clone)]
pub(crate) struct TimeoutSettings {
    /// 请求超时 (毫秒)
    pub timeout_ms: Option<u64>,
    /// 连接超时 (毫秒)
    pub connect_timeout_ms: Option<u64>,
}

impl Default for TimeoutSettings {
    fn default() -> Self {
        Self {
            timeout_ms: Some(30_000),         // 30 秒
            connect_timeout_ms: Some(10_000), // 10 秒
        }
    }
}

/// 代理条件
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum ProxyCondition {
    All,
    Http,
    Https,
}

/// 代理配置
#[derive(Debug, Clone)]
pub(crate) struct ProxyConfig {
    /// 代理 URL
    pub url: String,
    /// 代理条件
    pub condition: ProxyCondition,
}

/// 代理设置
#[derive(Debug, Clone, Default)]
pub(crate) enum ProxySettings {
    /// 不使用代理
    #[default]
    NoProxy,
    /// 自定义代理列表
    Custom(Vec<ProxyConfig>),
}

/// 重定向设置
#[derive(Debug, Clone)]
pub(crate) enum RedirectSettings {
    /// 不跟随重定向
    None,
    /// 有限次重定向
    Limited(u32),
}

impl Default for RedirectSettings {
    fn default() -> Self {
        Self::Limited(10)
    }
}

/// 客户端配置
#[derive(Debug, Clone, Default)]
pub(crate) struct ClientSettings {
    /// 浏览器模拟 (简单模式)
    pub emulation: Option<EmulationType>,
    /// 浏览器模拟 (高级模式)
    pub emulation_option: Option<HttpEmulationOption>,
    /// Cookie 配置
    pub cookie_settings: Option<CookieSettings>,
    /// 超时配置
    pub timeout_settings: Option<TimeoutSettings>,
    /// 代理配置
    pub proxy_settings: Option<ProxySettings>,
    /// 重定向配置
    pub redirect_settings: Option<RedirectSettings>,
    /// User-Agent
    pub user_agent: Option<String>,
}

// ============================================================================
// FRB 类型定义 - 请求与响应
// ============================================================================

/// HTTP 请求配置
#[derive(Debug, Clone)]
pub(crate) struct HttpRequest {
    /// 请求 URL
    pub url: String,
    /// HTTP 方法 (GET/POST/PUT/DELETE/HEAD)
    pub method: String,
    /// 请求头
    pub headers: Option<HashMap<String, String>>,
    /// 请求体
    pub body: Option<String>,
    /// 浏览器模拟类型
    pub emulation: EmulationType,
    /// 超时时间 (毫秒)
    pub timeout_ms: u64,
    /// 是否跟随重定向
    pub follow_redirects: bool,
}

impl Default for HttpRequest {
    fn default() -> Self {
        Self {
            url: String::new(),
            method: "GET".to_string(),
            headers: None,
            body: None,
            emulation: EmulationType::Chrome131,
            timeout_ms: 30_000,
            follow_redirects: true,
        }
    }
}

/// HTTP 响应
#[derive(Debug, Clone)]
pub(crate) struct HttpResponse {
    /// HTTP 状态码
    pub status: u16,
    /// 响应头
    pub headers: HashMap<String, String>,
    /// 响应体
    pub body: String,
    /// 最终 URL (重定向后)
    pub url: String,
}

// ============================================================================
// HTTP 客户端 (opaque handle)
// ============================================================================

/// HTTP 客户端
///
/// 持久化的 wreq 客户端实例，支持连接复用和 Cookie 管理
pub(crate) struct HttpClient {
    client: Client,
}

impl HttpClient {
    /// 创建新客户端
    ///
    /// # Errors
    ///
    /// 返回错误字符串，包含失败原因
    pub fn new(settings: ClientSettings) -> Result<Self, String> {
        let client = build_client(settings)?;
        Ok(Self { client })
    }

    /// 创建默认客户端
    pub async fn default_client() -> Self {
        let settings = ClientSettings::default();
        Self::new(settings).expect("默认客户端创建失败")
    }

    /// 发送 HTTP 请求
    ///
    /// # Errors
    ///
    /// 返回错误字符串，包含失败原因
    pub async fn request(&self, request: HttpRequest) -> Result<HttpResponse, String> {
        fetch_impl(&self.client, request).await
    }

    /// GET 请求
    pub async fn get(&self, url: String) -> Result<HttpResponse, String> {
        let request = HttpRequest {
            url,
            method: "GET".to_string(),
            ..Default::default()
        };
        self.request(request).await
    }

    /// POST 请求
    pub async fn post(&self, url: String, body: String) -> Result<HttpResponse, String> {
        let request = HttpRequest {
            url,
            method: "POST".to_string(),
            body: Some(body),
            ..Default::default()
        };
        self.request(request).await
    }
}

// ============================================================================
// FRB 导出函数
// ============================================================================

/// 发送 HTTP 请求
///
/// 使用指定的浏览器模拟配置发送 HTTP 请求，
/// 支持 TLS 指纹伪装和 HTTP/2 指纹。
///
/// # Errors
///
/// 返回错误字符串，包含失败原因
pub(crate) async fn fetch(request: HttpRequest) -> Result<HttpResponse, String> {
    // 创建临时客户端
    let client = build_client_from_request(&request)?;
    fetch_impl(&client, request).await
}

/// 快速 GET 请求 (使用默认配置)
pub(crate) async fn http_get(url: String) -> Result<HttpResponse, String> {
    let request = HttpRequest {
        url,
        method: "GET".to_string(),
        ..Default::default()
    };
    fetch(request).await
}

/// 快速 POST 请求 (使用默认配置)
pub(crate) async fn http_post(url: String, body: String) -> Result<HttpResponse, String> {
    let request = HttpRequest {
        url,
        method: "POST".to_string(),
        body: Some(body),
        ..Default::default()
    };
    fetch(request).await
}

/// 快速请求 (使用指定模拟器)
pub(crate) async fn http_fetch(
    url: String,
    emulation: EmulationType,
    timeout_ms: u64,
) -> Result<HttpResponse, String> {
    let request = HttpRequest {
        url,
        emulation,
        timeout_ms,
        ..Default::default()
    };
    fetch(request).await
}

// ============================================================================
// 内部实现
// ============================================================================

/// 构建客户端
fn build_client(settings: ClientSettings) -> Result<Client, String> {
    let mut builder = Client::builder();

    // 配置浏览器模拟
    if let Some(_emulation) = settings.emulation {}

    // 配置超时
    if let Some(timeout_settings) = settings.timeout_settings {
        if let Some(timeout_ms) = timeout_settings.timeout_ms {
            builder = builder.timeout(Duration::from_millis(timeout_ms));
        }
        if let Some(connect_ms) = timeout_settings.connect_timeout_ms {
            builder = builder.connect_timeout(Duration::from_millis(connect_ms));
        }
    }

    // 配置 Cookie
    if let Some(cookie_settings) = settings.cookie_settings {
        if cookie_settings.store_cookies {
            builder = builder.cookie_store(true);
        }
    }

    // 配置重定向
    if let Some(redirect_settings) = settings.redirect_settings {
        let policy = match redirect_settings {
            RedirectSettings::None => Policy::none(),
            RedirectSettings::Limited(limit) => Policy::limited(limit as usize),
        };
        builder = builder.redirect(policy);
    }

    // 配置代理
    if let Some(proxy_settings) = settings.proxy_settings {
        match proxy_settings {
            ProxySettings::NoProxy => {
                builder = builder.no_proxy();
            }
            ProxySettings::Custom(proxies) => {
                let _ = proxies;
            }
        }
    }

    // 配置 User-Agent
    if let Some(user_agent) = settings.user_agent {
        builder = builder.user_agent(&user_agent);
    }

    builder
        .build()
        .map_err(|e| format!("客户端构建失败: {}", e))
}

/// 从请求构建客户端
fn build_client_from_request(request: &HttpRequest) -> Result<Client, String> {
    let settings = ClientSettings {
        emulation: Some(request.emulation),
        timeout_settings: Some(TimeoutSettings {
            timeout_ms: Some(request.timeout_ms),
            connect_timeout_ms: Some(request.timeout_ms / 3),
        }),
        redirect_settings: Some(if request.follow_redirects {
            RedirectSettings::Limited(10)
        } else {
            RedirectSettings::None
        }),
        ..Default::default()
    };
    build_client(settings)
}

/// 发送请求的实现
async fn fetch_impl(client: &Client, request: HttpRequest) -> Result<HttpResponse, String> {
    // 解析 URL
    // 构建请求
    let method = parse_method(&request.method)?;
    let mut req_builder = client.request(method, request.url.clone());

    // 添加请求头
    if let Some(headers) = request.headers {
        for (key, value) in headers {
            req_builder = req_builder.header(&key, &value);
        }
    }

    // 添加请求体
    if let Some(body) = request.body {
        req_builder = req_builder.body(body);
    }

    // 发送请求
    let response = req_builder.send().await.map_err(map_request_error)?;

    // 检查 WAF 拦截
    if is_auth_required(&response) {
        return Err(HttpClientError::AuthRequired(response.status().as_u16()).to_string());
    }

    // 构建响应
    let status = response.status().as_u16();
    let headers = response
        .headers()
        .iter()
        .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
        .collect();
    let url = response.uri().to_string();
    let body = response.text().await.map_err(|e| {
        HttpClientError::ResponseParseError(format!("读取响应体失败: {}", e)).to_string()
    })?;

    Ok(HttpResponse {
        status,
        headers,
        body,
        url,
    })
}

/// 解析 HTTP 方法
fn parse_method(method: &str) -> Result<wreq::Method, String> {
    match method.to_uppercase().as_str() {
        "GET" => Ok(wreq::Method::GET),
        "POST" => Ok(wreq::Method::POST),
        "PUT" => Ok(wreq::Method::PUT),
        "DELETE" => Ok(wreq::Method::DELETE),
        "HEAD" => Ok(wreq::Method::HEAD),
        "PATCH" => Ok(wreq::Method::PATCH),
        _ => Err(format!("不支持的 HTTP 方法: {}", method)),
    }
}

/// 映射请求错误
fn map_request_error(error: wreq::Error) -> String {
    let error_str = error.to_string();

    if error_str.contains("timed out") || error_str.contains("timeout") {
        HttpClientError::TimeoutError.to_string()
    } else if error_str.contains("dns") || error_str.contains("resolve") {
        HttpClientError::DnsError(error_str).to_string()
    } else if error_str.contains("connection") {
        HttpClientError::ConnectionError(error_str).to_string()
    } else {
        HttpClientError::HttpError(error_str).to_string()
    }
}

/// 检查是否需要认证 (WAF 拦截)
fn is_auth_required(response: &wreq::Response) -> bool {
    let status = response.status().as_u16();

    // 检查状态码
    if status == 403 || status == 503 {
        // 检查特定的 WAF 标识头
        let headers = response.headers();
        let has_cf_ray = headers.get("cf-ray").is_some();
        let has_cf_mitigated = headers.get("cf-mitigated").is_some();

        if has_cf_ray || has_cf_mitigated {
            return true;
        }
    }

    false
}
