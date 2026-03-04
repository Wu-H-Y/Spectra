use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
#[cfg(feature = "ts-rs")]
use ts_rs::TS;

use super::pipeline::PipelineGraph;

/// 生命周期配置 - 定义爬虫的各个阶段
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct Lifecycle {
    /// 发现页配置
    pub explore: Option<ExploreConfig>,
    /// 搜索页配置
    pub search: Option<SearchConfig>,
    /// 详情页配置
    pub detail: Option<DetailConfig>,
    /// 目录页配置
    pub toc: Option<TocConfig>,
    /// 内容页配置
    pub content: Option<ContentConfig>,
}

/// 发现页配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct ExploreConfig {
    /// 入口 URL
    pub url: String,
    /// 数据提取管线
    pub pipeline: PipelineGraph,
}

/// 搜索页配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct SearchConfig {
    /// 搜索 URL 模板 (支持 {{key}} 变量)
    pub url: String,
    /// 数据提取管线
    pub pipeline: PipelineGraph,
}

/// 详情页配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct DetailConfig {
    /// 数据提取管线
    pub pipeline: PipelineGraph,
}

/// 目录页配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct TocConfig {
    /// 数据提取管线
    pub pipeline: PipelineGraph,
}

/// 内容页配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct ContentConfig {
    /// 数据提取管线
    pub pipeline: PipelineGraph,
    /// 是否启用媒体嗅探
    pub sniff_media: bool,
}
