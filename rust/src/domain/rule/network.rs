use std::collections::HashMap;

use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
#[cfg(feature = "ts-rs")]
use ts_rs::TS;

// ============================================================================
// 浏览器模拟枚举 - TLS/HTTP2 指纹伪装
// ============================================================================

/// 浏览器设备模拟类型
///
/// 提供常用浏览器的 TLS/HTTP2 指纹伪装，内部映射到 wreq 的具体实现
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[serde(rename_all = "camelCase")]
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

/// 操作系统模拟类型
#[derive(Debug, Clone, Copy, PartialEq, Eq, Default, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[serde(rename_all = "camelCase")]
pub enum EmulationOS {
    #[default]
    Windows,
    MacOS,
    Linux,
    Android,
    IOS,
}

/// 浏览器模拟高级选项
#[derive(Debug, Clone, Default, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct EmulationOption {
    /// 浏览器版本模拟
    pub emulation: Option<Emulation>,
    /// 操作系统模拟
    pub emulation_os: Option<EmulationOS>,
    /// 是否跳过 HTTP/2 指纹伪装
    pub skip_http2: Option<bool>,
    /// 是否跳过默认请求头
    pub skip_headers: Option<bool>,
}

// ============================================================================
// 网络配置结构体
// ============================================================================

/// 网络配置 - 用户友好的规则级配置
/// 具体的 TLS/HTTP2 指纹伪装由内部 wreq 引擎自动处理
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct NetworkConfig {
    /// 请求策略: "http" (Rust wreq) 或 "webview" (交互式)
    pub strategy: String,
    /// 浏览器模拟配置
    pub emulation: Option<EmulationOption>,
    /// 连接超时(毫秒)
    pub connect_timeout: Option<u64>,
    /// 读取超时(毫秒)
    pub read_timeout: Option<u64>,
    /// 自定义请求头
    pub headers: Option<HashMap<String, String>>,
    /// 代理配置
    pub proxy: Option<RuleProxyConfig>,
    /// 反爬回退配置
    pub fallback: Option<FallbackConfig>,
}

/// 规则级代理配置 (简化版，用户友好)
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct RuleProxyConfig {
    /// 是否启用代理
    pub enabled: bool,
    /// HTTP 代理地址 (如 "http://127.0.0.1:7890")
    pub http: Option<String>,
    /// HTTPS 代理地址
    pub https: Option<String>,
    /// SOCKS5 代理地址 (如 "socks5://127.0.0.1:1080")
    pub socks5: Option<String>,
}

/// 反爬回退配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct FallbackConfig {
    /// 触发回退的 HTTP 状态码 (如 [403, 503])
    /// 使用 Vec<i32> 避免 Dart Uint16List 的 JSON 序列化问题
    pub trigger_status: Vec<i32>,
    /// 触发回退的关键词 (如 ["cloudflare", "cf-ray"])
    pub trigger_keywords: Vec<String>,
    /// 回退动作: "webview_interactive" 或 "abort"
    pub action: String,
}
