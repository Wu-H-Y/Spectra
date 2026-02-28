//! HTTP 客户端 API (基于 wreq)。
//!
//! 提供完整的 HTTP 客户端功能，包括:
//! - TLS 指纹伪装 (JA3/JA4)
//! - HTTP/2 指纹模拟
//! - 代理支持
//! - Cookie 管理
//! - 超时配置
//! - 重定向控制

use std::{collections::HashMap, time::Duration};

use flutter_rust_bridge::frb;
use wreq::{redirect::Policy, Client};
use wreq_util::{
    Emulation as WreqEmulation, EmulationOS as WreqEmulationOS,
    EmulationOption as WreqEmulationOption,
};

// ============================================================================
// Emulation 枚举 - 浏览器模拟类型
// ============================================================================

/// 浏览器设备模拟类型。
///
/// 提供常用浏览器的 TLS/HTTP2 指纹伪装。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum Emulation {
    // Chrome 系列
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

    // Safari 系列
    Safari18,
    Safari18_2,
    Safari18_3,
    Safari18_5,
    Safari26,
    SafariIos18_1_1,

    // Firefox 系列
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

    // Edge 系列
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

    // OkHttp 系列 (Android)
    OkHttp3_14,
    OkHttp4_12,
    OkHttp5,
}

impl Emulation {
    /// 转换为 wreq Emulation。
    fn to_wreq(self) -> WreqEmulation {
        match self {
            Emulation::Chrome131 => WreqEmulation::Chrome131,
            Emulation::Chrome132 => WreqEmulation::Chrome132,
            Emulation::Chrome133 => WreqEmulation::Chrome133,
            Emulation::Chrome134 => WreqEmulation::Chrome134,
            Emulation::Chrome135 => WreqEmulation::Chrome135,
            Emulation::Chrome136 => WreqEmulation::Chrome136,
            Emulation::Chrome120 => WreqEmulation::Chrome120,
            Emulation::Chrome124 => WreqEmulation::Chrome124,
            Emulation::Chrome126 => WreqEmulation::Chrome126,
            Emulation::Chrome127 => WreqEmulation::Chrome127,
            Emulation::Chrome128 => WreqEmulation::Chrome128,
            Emulation::Chrome129 => WreqEmulation::Chrome129,
            Emulation::Chrome130 => WreqEmulation::Chrome130,
            Emulation::Safari18 => WreqEmulation::Safari18,
            Emulation::Safari18_2 => WreqEmulation::Safari18_2,
            Emulation::Safari18_3 => WreqEmulation::Safari18_3,
            Emulation::Safari18_5 => WreqEmulation::Safari18_5,
            Emulation::Safari26 => WreqEmulation::Safari26,
            Emulation::SafariIos18_1_1 => WreqEmulation::SafariIos18_1_1,
            Emulation::Firefox133 => WreqEmulation::Firefox133,
            Emulation::Firefox135 => WreqEmulation::Firefox135,
            Emulation::Firefox136 => WreqEmulation::Firefox136,
            Emulation::Firefox139 => WreqEmulation::Firefox139,
            Emulation::Firefox142 => WreqEmulation::Firefox142,
            Emulation::Firefox143 => WreqEmulation::Firefox143,
            Emulation::Firefox144 => WreqEmulation::Firefox144,
            Emulation::Firefox145 => WreqEmulation::Firefox145,
            Emulation::Firefox146 => WreqEmulation::Firefox146,
            Emulation::Firefox147 => WreqEmulation::Firefox147,
            Emulation::Edge127 => WreqEmulation::Edge127,
            Emulation::Edge131 => WreqEmulation::Edge131,
            Emulation::Edge134 => WreqEmulation::Edge134,
            Emulation::Edge135 => WreqEmulation::Edge135,
            Emulation::Edge136 => WreqEmulation::Edge136,
            Emulation::Edge137 => WreqEmulation::Edge137,
            Emulation::Edge138 => WreqEmulation::Edge138,
            Emulation::Edge139 => WreqEmulation::Edge139,
            Emulation::Edge140 => WreqEmulation::Edge140,
            Emulation::Edge141 => WreqEmulation::Edge141,
            Emulation::Edge142 => WreqEmulation::Edge142,
            Emulation::Edge143 => WreqEmulation::Edge143,
            Emulation::Edge144 => WreqEmulation::Edge144,
            Emulation::Edge145 => WreqEmulation::Edge145,
            Emulation::OkHttp3_14 => WreqEmulation::OkHttp3_14,
            Emulation::OkHttp4_12 => WreqEmulation::OkHttp4_12,
            Emulation::OkHttp5 => WreqEmulation::OkHttp5,
        }
    }
}

/// 操作系统模拟类型。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default)]
pub enum EmulationOS {
    #[default]
    Windows,
    MacOS,
    Linux,
    Android,
    IOS,
}

impl EmulationOS {
    /// 转换为 wreq EmulationOS。
    fn to_wreq(self) -> WreqEmulationOS {
        match self {
            EmulationOS::Windows => WreqEmulationOS::Windows,
            EmulationOS::MacOS => WreqEmulationOS::MacOS,
            EmulationOS::Linux => WreqEmulationOS::Linux,
            EmulationOS::Android => WreqEmulationOS::Android,
            EmulationOS::IOS => WreqEmulationOS::IOS,
        }
    }
}

// ============================================================================
// 配置结构体
// ============================================================================

/// 浏览器模拟高级选项。
#[derive(Debug, Clone, Default)]
pub struct EmulationOption {
    /// 浏览器版本。
    pub emulation: Option<Emulation>,
    /// 操作系统。
    pub emulation_os: Option<EmulationOS>,
    /// 是否跳过 HTTP/2 指纹。
    pub skip_http2: Option<bool>,
    /// 是否跳过默认请求头。
    pub skip_headers: Option<bool>,
}

/// 超时配置。
#[derive(Debug, Clone, Default)]
pub struct TimeoutSettings {
    /// 请求超时 (毫秒)。
    pub timeout_ms: Option<u32>,
    /// 连接超时 (毫秒)。
    pub connect_timeout_ms: Option<u32>,
}

/// Cookie 配置。
#[derive(Debug, Clone, Default)]
pub struct CookieSettings {
    /// 是否存储 Cookie。
    pub store_cookies: bool,
}

/// 代理条件。
#[derive(Debug, Clone, Default)]
pub enum ProxyCondition {
    #[default]
    All,
    Http,
    Https,
}

/// 代理配置。
#[derive(Debug, Clone)]
pub struct ProxyConfig {
    /// 代理 URL。
    pub url: String,
    /// 代理条件。
    pub condition: ProxyCondition,
}

/// 代理设置。
#[derive(Debug, Clone, Default)]
pub enum ProxySettings {
    /// 不使用代理。
    #[default]
    NoProxy,
    /// 自定义代理列表。
    Custom(Vec<ProxyConfig>),
}

/// 重定向设置。
#[derive(Debug, Clone)]
pub enum RedirectSettings {
    /// 不跟随重定向。
    None,
    /// 有限次重定向。
    Limited(i32),
}

impl Default for RedirectSettings {
    fn default() -> Self {
        Self::Limited(10)
    }
}

/// 客户端配置。
#[derive(Debug, Clone, Default)]
pub struct ClientSettings {
    /// 浏览器模拟 (简单模式)。
    pub emulation: Option<Emulation>,
    /// 浏览器模拟 (高级模式)。
    pub emulation_option: Option<EmulationOption>,
    /// Cookie 配置。
    pub cookie_settings: Option<CookieSettings>,
    /// 超时配置。
    pub timeout_settings: Option<TimeoutSettings>,
    /// 代理配置。
    pub proxy_settings: Option<ProxySettings>,
    /// 重定向配置。
    pub redirect_settings: Option<RedirectSettings>,
    /// User-Agent。
    pub user_agent: Option<String>,
}

// ============================================================================
// HTTP 请求/响应结构体
// ============================================================================

/// HTTP 请求配置。
#[derive(Debug, Clone)]
pub struct HttpRequest {
    /// 请求 URL。
    pub url: String,
    /// HTTP 方法 (GET/POST/PUT/DELETE/HEAD)。
    pub method: String,
    /// 请求头。
    pub headers: Option<HashMap<String, String>>,
    /// 请求体。
    pub body: Option<String>,
    /// 浏览器模拟类型。
    pub emulation: Emulation,
    /// 超时时间 (毫秒)。
    pub timeout_ms: u32,
    /// 是否跟随重定向。
    pub follow_redirects: bool,
}

impl Default for HttpRequest {
    fn default() -> Self {
        Self {
            url: String::new(),
            method: "GET".to_string(),
            headers: None,
            body: None,
            emulation: Emulation::default(),
            timeout_ms: 15_000,
            follow_redirects: true,
        }
    }
}

/// HTTP 响应。
#[derive(Debug, Clone)]
pub struct HttpResponse {
    /// HTTP 状态码。
    pub status: u16,
    /// 响应头。
    pub headers: HashMap<String, String>,
    /// 响应体。
    pub body: String,
    /// 最终 URL (重定向后)。
    pub url: String,
}

// ============================================================================
// 持久化客户端
// ============================================================================

/// HTTP 客户端 (可复用连接)。
#[derive(Clone)]
pub struct HttpClient {
    client: Client,
}

impl HttpClient {
    /// 创建新客户端。
    ///
    /// # Errors
    ///
    /// 返回错误字符串，包含失败原因。
    #[frb]
    pub fn new(settings: ClientSettings) -> Result<Self, String> {
        let client = Self::build_client(&settings)?;
        Ok(Self { client })
    }

    /// 创建默认客户端。
    #[frb]
    pub fn default_client() -> Result<Self, String> {
        Self::new(ClientSettings::default())
    }

    fn build_client(settings: &ClientSettings) -> Result<Client, String> {
        let mut builder = Client::builder();

        // 浏览器模拟配置
        if let Some(emulation) = &settings.emulation {
            builder = builder.emulation(emulation.to_wreq());
        } else if let Some(option) = &settings.emulation_option {
            let emulation = option
                .emulation
                .map(|e| e.to_wreq())
                .unwrap_or(WreqEmulation::Chrome131);
            let os = option
                .emulation_os
                .map(|e| e.to_wreq())
                .unwrap_or(WreqEmulationOS::Windows);

            builder = builder.emulation(
                WreqEmulationOption::builder()
                    .emulation(emulation)
                    .emulation_os(os)
                    .skip_http2(option.skip_http2.unwrap_or(false))
                    .skip_headers(option.skip_headers.unwrap_or(false))
                    .build(),
            );
        }

        // Cookie 配置
        if let Some(cookie) = &settings.cookie_settings {
            builder = builder.cookie_store(cookie.store_cookies);
        }

        // 超时配置
        if let Some(timeout) = &settings.timeout_settings {
            if let Some(ms) = timeout.timeout_ms {
                builder = builder.timeout(Duration::from_millis(ms as u64));
            }
            if let Some(ms) = timeout.connect_timeout_ms {
                builder = builder.connect_timeout(Duration::from_millis(ms as u64));
            }
        }

        // 代理配置
        if let Some(proxy) = &settings.proxy_settings {
            match proxy {
                ProxySettings::NoProxy => {
                    builder = builder.no_proxy();
                }
                ProxySettings::Custom(proxies) => {
                    for p in proxies {
                        let result = match p.condition {
                            ProxyCondition::All => wreq::Proxy::all(&p.url),
                            ProxyCondition::Http => wreq::Proxy::http(&p.url),
                            ProxyCondition::Https => wreq::Proxy::https(&p.url),
                        };
                        if let Ok(proxy) = result {
                            builder = builder.proxy(proxy);
                        }
                    }
                }
            }
        }

        // 重定向配置
        if let Some(redirect) = &settings.redirect_settings {
            builder = match redirect {
                RedirectSettings::None => builder.redirect(Policy::none()),
                RedirectSettings::Limited(max) => builder.redirect(Policy::limited(*max as usize)),
            };
        }

        // User-Agent
        if let Some(ua) = &settings.user_agent {
            builder = builder.user_agent(ua);
        }

        builder.build().map_err(|e| format!("创建客户端失败: {e}"))
    }

    /// 发送 HTTP 请求。
    ///
    /// # Errors
    ///
    /// 返回错误字符串，包含失败原因。
    #[frb]
    pub async fn request(&self, request: HttpRequest) -> Result<HttpResponse, String> {
        let method = request.method.to_uppercase();
        let mut req = match method.as_str() {
            "GET" => self.client.get(&request.url),
            "POST" => self.client.post(&request.url),
            "PUT" => self.client.put(&request.url),
            "DELETE" => self.client.delete(&request.url),
            "HEAD" => self.client.head(&request.url),
            m => return Err(format!("不支持的 HTTP 方法: {m}")),
        };

        if let Some(headers) = &request.headers {
            for (key, value) in headers {
                req = req.header(key, value);
            }
        }

        if let Some(body) = &request.body {
            req = req.body(body.clone());
        }

        let response = req.send().await.map_err(|e| format!("请求失败: {e}"))?;

        let status = response.status().as_u16();
        let final_url = response.uri().to_string();

        let headers: HashMap<String, String> = response
            .headers()
            .iter()
            .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
            .collect();

        let body = response
            .text()
            .await
            .map_err(|e| format!("读取响应体失败: {e}"))?;

        Ok(HttpResponse {
            status,
            headers,
            body,
            url: final_url,
        })
    }

    /// GET 请求。
    #[frb]
    pub async fn get(&self, url: String) -> Result<HttpResponse, String> {
        self.request(HttpRequest {
            url,
            method: "GET".to_string(),
            ..Default::default()
        })
        .await
    }

    /// POST 请求。
    #[frb]
    pub async fn post(&self, url: String, body: String) -> Result<HttpResponse, String> {
        self.request(HttpRequest {
            url,
            method: "POST".to_string(),
            body: Some(body),
            ..Default::default()
        })
        .await
    }
}

// ============================================================================
// 便捷函数 (一次性请求，每次创建新客户端)
// ============================================================================

/// 发送 HTTP 请求。
///
/// 使用指定的浏览器模拟配置发送 HTTP 请求，
/// 支持 TLS 指纹伪装和 HTTP/2 指纹。
///
/// # Errors
///
/// 返回错误字符串，包含失败原因。
#[frb]
pub async fn fetch(request: HttpRequest) -> Result<HttpResponse, String> {
    let emulation = request.emulation.to_wreq();

    let redirect_policy = if request.follow_redirects {
        Policy::default()
    } else {
        Policy::none()
    };

    let client = Client::builder()
        .emulation(emulation)
        .timeout(Duration::from_millis(request.timeout_ms as u64))
        .redirect(redirect_policy)
        .build()
        .map_err(|e| format!("创建客户端失败: {e}"))?;

    let method = request.method.to_uppercase();
    let mut req = match method.as_str() {
        "GET" => client.get(&request.url),
        "POST" => client.post(&request.url),
        "PUT" => client.put(&request.url),
        "DELETE" => client.delete(&request.url),
        "HEAD" => client.head(&request.url),
        m => return Err(format!("不支持的 HTTP 方法: {m}")),
    };

    if let Some(headers) = &request.headers {
        for (key, value) in headers {
            req = req.header(key, value);
        }
    }

    if let Some(body) = &request.body {
        req = req.body(body.clone());
    }

    let response = req.send().await.map_err(|e| format!("请求失败: {e}"))?;

    let status = response.status().as_u16();
    let final_url = response.uri().to_string();

    let headers: HashMap<String, String> = response
        .headers()
        .iter()
        .map(|(k, v)| (k.to_string(), v.to_str().unwrap_or("").to_string()))
        .collect();

    let body = response
        .text()
        .await
        .map_err(|e| format!("读取响应体失败: {e}"))?;

    Ok(HttpResponse {
        status,
        headers,
        body,
        url: final_url,
    })
}

/// 快速 GET 请求 (使用默认配置)。
#[frb]
pub async fn http_get(url: String) -> Result<HttpResponse, String> {
    fetch(HttpRequest {
        url,
        method: "GET".to_string(),
        ..Default::default()
    })
    .await
}

/// 快速 POST 请求 (使用默认配置)。
#[frb]
pub async fn http_post(url: String, body: String) -> Result<HttpResponse, String> {
    fetch(HttpRequest {
        url,
        method: "POST".to_string(),
        body: Some(body),
        ..Default::default()
    })
    .await
}

/// 快速请求 (使用指定模拟器)。
#[frb]
pub async fn http_fetch(
    url: String,
    emulation: Emulation,
    timeout_ms: u32,
) -> Result<HttpResponse, String> {
    fetch(HttpRequest {
        url,
        emulation,
        timeout_ms,
        ..Default::default()
    })
    .await
}

// ============================================================================
// 测试
// ============================================================================

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_emulation_default() {
        let emulation = Emulation::default();
        assert_eq!(emulation, Emulation::Chrome131);
    }

    #[test]
    fn test_emulation_os_default() {
        let os = EmulationOS::default();
        assert_eq!(os, EmulationOS::Windows);
    }

    #[test]
    fn test_client_settings_default() {
        let settings = ClientSettings::default();
        assert!(settings.emulation.is_none());
        assert!(settings.emulation_option.is_none());
    }

    #[test]
    fn test_http_request_default() {
        let request = HttpRequest::default();
        assert!(request.url.is_empty());
        assert_eq!(request.method, "GET");
        assert!(request.headers.is_none());
        assert!(request.body.is_none());
        assert_eq!(request.emulation, Emulation::Chrome131);
        assert_eq!(request.timeout_ms, 15_000);
        assert!(request.follow_redirects);
    }

    #[test]
    fn test_client_creation() {
        let settings = ClientSettings {
            emulation: Some(Emulation::Chrome131),
            timeout_settings: Some(TimeoutSettings {
                timeout_ms: Some(10_000),
                ..Default::default()
            }),
            ..Default::default()
        };

        let result = HttpClient::new(settings);
        assert!(result.is_ok());
    }

    #[test]
    fn test_client_with_emulation_option() {
        let settings = ClientSettings {
            emulation_option: Some(EmulationOption {
                emulation: Some(Emulation::Chrome136),
                emulation_os: Some(EmulationOS::MacOS),
                skip_http2: Some(true),
                skip_headers: Some(false),
            }),
            ..Default::default()
        };

        let result = HttpClient::new(settings);
        assert!(result.is_ok());
    }

    #[test]
    fn test_client_with_proxy() {
        let settings = ClientSettings {
            proxy_settings: Some(ProxySettings::Custom(vec![ProxyConfig {
                url: "http://localhost:8080".to_string(),
                condition: ProxyCondition::All,
            }])),
            ..Default::default()
        };

        let result = HttpClient::new(settings);
        assert!(result.is_ok());
    }

    #[test]
    fn test_client_with_cookie() {
        let settings = ClientSettings {
            cookie_settings: Some(CookieSettings {
                store_cookies: true,
            }),
            ..Default::default()
        };

        let result = HttpClient::new(settings);
        assert!(result.is_ok());
    }
}
