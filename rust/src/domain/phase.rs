use std::collections::HashMap;

use flutter_rust_bridge::frb;

use crate::error::CrawlerError;

/// 生命周期阶段
#[derive(Debug, Clone, PartialEq, Eq)]
#[frb(dart_metadata=("freezed"))]
pub enum LifecyclePhase {
    Explore,
    Search,
    Detail,
    Toc,
    Content,
}

/// 响应内容类型
#[derive(Debug, Clone, PartialEq, Eq)]
#[frb(dart_metadata=("freezed"))]
pub enum ContentType {
    Html,
    Json,
    Xml,
}

/// 阶段执行上下文
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct PhaseContext {
    pub url: Option<String>,
    pub keyword: Option<String>,
    pub page: Option<u32>,
    pub vars: Option<HashMap<String, String>>,
}

/// 阶段执行返回结果
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct PhaseResult {
    pub success: bool,
    pub final_url: Option<String>,
    pub content_type: ContentType,
    pub raw_body: Option<String>,
    pub data: Option<PhaseData>,
    pub error: Option<CrawlerError>,
}

/// 阶段结构化数据联合类型
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub enum PhaseData {
    Explore(ExploreData),
    Search(SearchData),
    Detail(DetailData),
    Toc(TocData),
    Content(ContentData),
}

/// 发现页数据
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct ExploreData {
    pub items: Vec<String>,
}

/// 搜索结果条目
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct SearchItem {
    pub title: String,
    pub url: String,
    pub cover: Option<String>,
    pub author: Option<String>,
}

/// 搜索页数据
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct SearchData {
    pub items: Vec<SearchItem>,
}

/// 详情页数据
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct DetailData {
    pub fields: HashMap<String, String>,
}

/// 章节条目
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct ChapterItem {
    pub title: String,
    pub url: Option<String>,
}

/// 目录页数据
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct TocData {
    pub chapters: Vec<ChapterItem>,
}

/// 内容页数据
#[derive(Debug, Clone)]
#[frb(dart_metadata=("freezed"))]
pub struct ContentData {
    pub content: String,
    pub media: Vec<String>,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn lifecycle_phase_variants_accessible() {
        let phases = [
            LifecyclePhase::Explore,
            LifecyclePhase::Search,
            LifecyclePhase::Detail,
            LifecyclePhase::Toc,
            LifecyclePhase::Content,
        ];
        assert_eq!(phases.len(), 5);
    }
}
