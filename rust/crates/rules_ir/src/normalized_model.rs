use serde::{Deserialize, Serialize};
use ts_rs::TS;

/// 规则执行的规范化输出模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct NormalizedModel {
    /// 搜索阶段输出。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub search: Option<SearchModel>,
    /// 详情阶段输出。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub detail: Option<DetailModel>,
    /// 目录阶段输出。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub toc: Option<TocModel>,
    /// 内容阶段输出。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub content: Option<ContentModel>,
    /// 媒体扩展输出。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub media: Option<MediaExtension>,
}

/// 搜索阶段模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct SearchModel {
    /// 搜索结果列表。
    #[serde(default)]
    pub items: Vec<SearchItem>,
}

/// 搜索项模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct SearchItem {
    /// 标题。
    pub title: String,
    /// 链接。
    pub url: String,
    /// 封面。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub cover: Option<String>,
    /// 作者。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub author: Option<String>,
}

/// 详情阶段模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct DetailModel {
    /// 标题。
    pub title: String,
    /// 封面。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub cover: Option<String>,
    /// 作者。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub author: Option<String>,
    /// 描述。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub description: Option<String>,
    /// 标签。
    #[serde(default)]
    pub tags: Vec<String>,
}

/// 目录阶段模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct TocModel {
    /// 章节列表。
    #[serde(default)]
    pub chapters: Vec<ChapterItem>,
}

/// 章节项模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct ChapterItem {
    /// 章节标题。
    pub title: String,
    /// 章节链接。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub url: Option<String>,
}

/// 内容阶段模型。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct ContentModel {
    /// HTML 文本内容。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub content_text_html: Option<String>,
    /// 纯文本内容。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub content_text_plain: Option<String>,
    /// 媒体资源。
    #[serde(default)]
    pub media_assets: Vec<MediaAsset>,
}

/// 媒体资源项。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct MediaAsset {
    /// 资源类型。
    pub media_type: MediaType,
    /// 资源链接。
    pub url: String,
    /// 资源标题。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub title: Option<String>,
    /// 缩略图链接。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub cover: Option<String>,
}

/// 媒体类型。
#[derive(Debug, Clone, Copy, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub enum MediaType {
    Video,
    Music,
    Novel,
    Comic,
    Image,
}

/// 媒体扩展信息。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct MediaExtension {
    /// 可选视频扩展。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub video: Option<MediaSpec>,
    /// 可选音乐扩展。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub music: Option<MediaSpec>,
    /// 可选小说扩展。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub novel: Option<MediaSpec>,
    /// 可选漫画扩展。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub comic: Option<MediaSpec>,
    /// 可选图片扩展。
    #[serde(default, skip_serializing_if = "Option::is_none")]
    pub image: Option<MediaSpec>,
}

/// 通用媒体扩展配置。
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct MediaSpec {
    /// 附加元数据。
    #[serde(default)]
    pub extra: std::collections::BTreeMap<String, String>,
}
