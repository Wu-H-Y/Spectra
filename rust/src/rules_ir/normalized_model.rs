use flutter_rust_bridge::frb;
use serde::{Deserialize, Serialize};
use ts_rs::TS;

/// 规则执行的规范化输出模型。
#[frb(json_serializable, unignore)]
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
#[frb(json_serializable, unignore)]
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct SearchModel {
    /// 搜索结果列表。
    #[frb(default = "const <SearchItem>[]")]
    #[serde(default)]
    pub items: Vec<SearchItem>,
}

/// 搜索项模型。
#[frb(json_serializable, unignore)]
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
#[frb(json_serializable, unignore)]
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
    #[frb(default = "const <String>[]")]
    #[serde(default)]
    pub tags: Vec<String>,
}

/// 目录阶段模型。
#[frb(json_serializable, unignore)]
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct TocModel {
    /// 章节列表。
    #[frb(default = "const <ChapterItem>[]")]
    #[serde(default)]
    pub chapters: Vec<ChapterItem>,
}

/// 章节项模型。
#[frb(json_serializable, unignore)]
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
#[frb(json_serializable, unignore)]
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
    #[frb(default = "const <MediaAsset>[]")]
    #[serde(default)]
    pub media_assets: Vec<MediaAsset>,
}

/// 媒体资源项。
#[frb(json_serializable, unignore)]
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct MediaAsset {
    /// 资源类型。
    #[frb(name = "mediaType", default = "MediaType.video")]
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
#[frb(json_serializable, unignore)]
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
#[frb(json_serializable, unignore)]
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
#[frb(json_serializable, unignore)]
#[derive(Debug, Clone, PartialEq, Eq, Serialize, Deserialize, TS)]
#[serde(rename_all = "camelCase")]
pub struct MediaSpec {
    /// 附加元数据。
    #[frb(default = "const <String, String>{}")]
    #[serde(default)]
    pub extra: std::collections::HashMap<String, String>,
}

#[cfg(test)]
mod tests {
    use std::collections::HashMap;

    use super::{
        ChapterItem, ContentModel, DetailModel, MediaAsset, MediaExtension, MediaSpec, MediaType,
        NormalizedModel, SearchItem, SearchModel, TocModel,
    };

    #[test]
    fn normalized_model_json_roundtrip_success() {
        let model = NormalizedModel {
            search: Some(SearchModel {
                items: vec![SearchItem {
                    title: "搜索标题".to_owned(),
                    url: "https://example.com/search/1".to_owned(),
                    cover: Some("https://example.com/cover.jpg".to_owned()),
                    author: Some("作者甲".to_owned()),
                }],
            }),
            detail: Some(DetailModel {
                title: "详情标题".to_owned(),
                cover: Some("https://example.com/detail-cover.jpg".to_owned()),
                author: Some("作者乙".to_owned()),
                description: Some("详情描述".to_owned()),
                tags: vec!["连载".to_owned(), "精选".to_owned()],
            }),
            toc: Some(TocModel {
                chapters: vec![ChapterItem {
                    title: "第一章".to_owned(),
                    url: Some("https://example.com/chapter-1".to_owned()),
                }],
            }),
            content: Some(ContentModel {
                content_text_html: Some("<p>正文</p>".to_owned()),
                content_text_plain: Some("正文".to_owned()),
                media_assets: vec![MediaAsset {
                    media_type: MediaType::Video,
                    url: "https://example.com/video.mp4".to_owned(),
                    title: Some("视频资源".to_owned()),
                    cover: Some("https://example.com/video-cover.jpg".to_owned()),
                }],
            }),
            media: Some(MediaExtension {
                video: Some(MediaSpec {
                    extra: HashMap::from([("resolution".to_owned(), "1080p".to_owned())]),
                }),
                music: Some(MediaSpec {
                    extra: HashMap::from([("bitrate".to_owned(), "320kbps".to_owned())]),
                }),
                novel: Some(MediaSpec {
                    extra: HashMap::from([("wordCount".to_owned(), "1024".to_owned())]),
                }),
                comic: Some(MediaSpec {
                    extra: HashMap::from([("pageCount".to_owned(), "12".to_owned())]),
                }),
                image: Some(MediaSpec {
                    extra: HashMap::from([("format".to_owned(), "png".to_owned())]),
                }),
            }),
        };

        let json = serde_json::to_string(&model).expect("规范化模型应可序列化为 JSON");
        let restored: NormalizedModel =
            serde_json::from_str(&json).expect("规范化模型应可从 JSON 反序列化");

        assert_eq!(restored, model);
        assert!(json.contains("contentTextHtml"));
        assert!(json.contains("mediaAssets"));
        assert!(json.contains("mediaType"));
    }
}
