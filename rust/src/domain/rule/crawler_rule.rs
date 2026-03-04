use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
#[cfg(feature = "ts-rs")]
use ts_rs::TS;

use super::{lifecycle::Lifecycle, network::NetworkConfig};

/// 爬虫规则根结构 - 单一数据源 (Single Source of Truth)
/// 此结构将被自动生成 Dart (freezed) 和 TypeScript 接口
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct CrawlerRule {
    /// 规则唯一标识
    pub id: String,
    /// 规则名称
    pub name: String,
    /// 规则描述
    pub description: String,
    /// 作者
    pub author: String,
    /// 版本号
    pub version: String,
    /// 网络配置 (TLS指纹、代理、回退策略等)
    pub network: Option<NetworkConfig>,
    /// 多源聚合配置
    pub aggregation: Option<AggregationConfig>,
    /// 生命周期配置 (Explore/Search/Detail/Toc/Content)
    pub lifecycle: Lifecycle,
}

/// 多源聚合配置
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct AggregationConfig {
    /// 是否启用聚合
    pub enabled: bool,
    /// 源权重 (用于排序)
    pub weight: u8,
    /// 匹配配置
    pub matching: MatchingConfig,
}

/// 匹配配置 - 用于多源结果去重
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct MatchingConfig {
    /// 匹配策略: "exact" 或 "fuzzy"
    pub strategy: String,
    /// 匹配维度
    pub dimensions: Vec<MatchingDimension>,
}

/// 匹配维度定义
#[derive(Debug, Clone, Serialize, Deserialize)]
#[cfg_attr(feature = "ts-rs", derive(TS))]
#[cfg_attr(
    feature = "ts-rs",
    ts(export, export_to = "../../web-editor/src/types/rule.ts")
)]
#[frb(dart_metadata=("freezed"))]
#[frb(json_serializable)]
pub struct MatchingDimension {
    /// 字段名 (如 "title", "author")
    pub field: String,
    /// 匹配类型: "exact", "fuzzy", "jaccard"
    pub match_type: String,
    /// 相似度阈值 (0.0 - 1.0)
    pub threshold: f64,
}
