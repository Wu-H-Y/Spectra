use std::collections::BTreeMap;

use super::{node_failure, optional_param, primary_input_value, reject_unknown_params};
use crate::{
    rules_engine::{EngineError, RuntimeValue},
    rules_ir::{
        ChapterItem, ContentModel, DetailModel, LifecyclePhase, MediaAsset, MediaType, Node,
        NormalizedModel, SearchItem, SearchModel, TocModel,
    },
};

pub(crate) fn execute(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(node, &["target"])?;

    let input = primary_input_value(node, inputs)?;
    let target = resolve_target(node)?;
    let model = match target {
        MapTarget::Search => map_search_model(node, input)?,
        MapTarget::Detail => map_detail_model(node, input)?,
        MapTarget::Toc => map_toc_model(node, input)?,
        MapTarget::Content => map_content_model(node, input)?,
    };

    let value = RuntimeValue::NormalizedModel(Box::new(model));
    let mut outputs = BTreeMap::new();
    for output in &node.outputs {
        outputs.insert(output.name.clone(), vec![value.clone()]);
    }

    Ok(outputs)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
enum MapTarget {
    Search,
    Detail,
    Toc,
    Content,
}

fn resolve_target(node: &Node) -> Result<MapTarget, EngineError> {
    let raw = if let Some(target) = optional_param(node, "target") {
        target
    } else {
        match node.phase {
            LifecyclePhase::Explore => {
                return Err(node_failure(
                    node,
                    "Explore 阶段的 MapToModel 节点必须显式提供 target，允许值：search/detail/toc/content",
                ));
            }
            LifecyclePhase::Search => "search",
            LifecyclePhase::Detail => "detail",
            LifecyclePhase::Toc => "toc",
            LifecyclePhase::Content => "content",
        }
    };

    match raw {
        "search" => Ok(MapTarget::Search),
        "detail" => Ok(MapTarget::Detail),
        "toc" => Ok(MapTarget::Toc),
        "content" => Ok(MapTarget::Content),
        other => Err(node_failure(
            node,
            format!("target=`{other}` 无效，仅支持 search/detail/toc/content"),
        )),
    }
}

fn map_search_model(node: &Node, input: RuntimeValue) -> Result<NormalizedModel, EngineError> {
    let items_value = match input {
        RuntimeValue::List(items) => items,
        RuntimeValue::Record(fields) => {
            required_field(node, &fields, "items", "items")?.clone_list(node, "items")?
        }
        other => {
            return Err(node_failure(
                node,
                format!(
                    "search 映射只支持 list<Record> 或含 `items` 的 record，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let items = items_value
        .into_iter()
        .enumerate()
        .map(|(index, value)| map_search_item(node, value, &format!("items[{index}]")))
        .collect::<Result<Vec<_>, _>>()?;

    Ok(NormalizedModel {
        search: Some(SearchModel { items }),
        detail: None,
        toc: None,
        content: None,
        media: None,
    })
}

fn map_search_item(
    node: &Node,
    value: RuntimeValue,
    path: &str,
) -> Result<SearchItem, EngineError> {
    let fields = value.expect_record(node, path)?;
    Ok(SearchItem {
        title: required_string_field(node, &fields, path, "title")?,
        url: required_url_like_field(node, &fields, path, "url")?,
        cover: optional_url_like_field(node, &fields, path, "cover")?,
        author: optional_string_field(node, &fields, path, "author")?,
    })
}

fn map_detail_model(node: &Node, input: RuntimeValue) -> Result<NormalizedModel, EngineError> {
    let fields = input.expect_record(node, "detail")?;
    Ok(NormalizedModel {
        search: None,
        detail: Some(DetailModel {
            title: required_string_field(node, &fields, "detail", "title")?,
            cover: optional_url_like_field(node, &fields, "detail", "cover")?,
            author: optional_string_field(node, &fields, "detail", "author")?,
            description: optional_string_field(node, &fields, "detail", "description")?,
            tags: optional_string_list_field(node, &fields, "detail", "tags")?.unwrap_or_default(),
        }),
        toc: None,
        content: None,
        media: None,
    })
}

fn map_toc_model(node: &Node, input: RuntimeValue) -> Result<NormalizedModel, EngineError> {
    let chapters_value = match input {
        RuntimeValue::List(items) => items,
        RuntimeValue::Record(fields) => {
            required_field(node, &fields, "chapters", "chapters")?.clone_list(node, "chapters")?
        }
        other => {
            return Err(node_failure(
                node,
                format!(
                    "toc 映射只支持 list<Record> 或含 `chapters` 的 record，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let chapters = chapters_value
        .into_iter()
        .enumerate()
        .map(|(index, value)| map_chapter_item(node, value, &format!("chapters[{index}]")))
        .collect::<Result<Vec<_>, _>>()?;

    Ok(NormalizedModel {
        search: None,
        detail: None,
        toc: Some(TocModel { chapters }),
        content: None,
        media: None,
    })
}

fn map_chapter_item(
    node: &Node,
    value: RuntimeValue,
    path: &str,
) -> Result<ChapterItem, EngineError> {
    let fields = value.expect_record(node, path)?;
    Ok(ChapterItem {
        title: required_string_field(node, &fields, path, "title")?,
        url: optional_url_like_field(node, &fields, path, "url")?,
    })
}

fn map_content_model(node: &Node, input: RuntimeValue) -> Result<NormalizedModel, EngineError> {
    let fields = input.expect_record(node, "content")?;
    let media_assets = optional_media_assets_field(node, &fields, "content", "mediaAssets")?
        .or(optional_media_assets_field(
            node,
            &fields,
            "content",
            "media_assets",
        )?)
        .unwrap_or_default();

    Ok(NormalizedModel {
        search: None,
        detail: None,
        toc: None,
        content: Some(ContentModel {
            content_text_html: optional_text_like_field(
                node,
                &fields,
                "content",
                &["contentTextHtml", "content_text_html"],
            )?,
            content_text_plain: optional_text_like_field(
                node,
                &fields,
                "content",
                &["contentTextPlain", "content_text_plain"],
            )?,
            media_assets,
        }),
        media: None,
    })
}

fn optional_media_assets_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<Option<Vec<MediaAsset>>, EngineError> {
    let Some(value) = fields.get(field_name) else {
        return Ok(None);
    };
    let items = value.clone_list(node, &join_path(base_path, field_name))?;
    let assets = items
        .into_iter()
        .enumerate()
        .map(|(index, value)| {
            map_media_asset(node, value, &format!("{base_path}.{field_name}[{index}]"))
        })
        .collect::<Result<Vec<_>, _>>()?;
    Ok(Some(assets))
}

fn map_media_asset(
    node: &Node,
    value: RuntimeValue,
    path: &str,
) -> Result<MediaAsset, EngineError> {
    let fields = value.expect_record(node, path)?;
    let media_type_field = if fields.contains_key("mediaType") {
        "mediaType"
    } else {
        "media_type"
    };
    Ok(MediaAsset {
        media_type: required_media_type_field(node, &fields, path, media_type_field)?,
        url: required_url_like_field(node, &fields, path, "url")?,
        title: optional_string_field(node, &fields, path, "title")?,
        cover: optional_url_like_field(node, &fields, path, "cover")?,
    })
}

fn required_media_type_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<MediaType, EngineError> {
    let value = required_field(node, fields, field_name, &join_path(base_path, field_name))?;
    let text = value.as_string(node, &join_path(base_path, field_name))?;
    match text.as_str() {
        "video" => Ok(MediaType::Video),
        "music" => Ok(MediaType::Music),
        "novel" => Ok(MediaType::Novel),
        "comic" => Ok(MediaType::Comic),
        "image" => Ok(MediaType::Image),
        other => Err(node_failure(
            node,
            format!(
                "字段 `{}` 的值 `{other}` 无效，仅支持 video/music/novel/comic/image",
                join_path(base_path, field_name)
            ),
        )),
    }
}

fn required_string_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<String, EngineError> {
    required_field(node, fields, field_name, &join_path(base_path, field_name))?
        .as_string(node, &join_path(base_path, field_name))
}

fn required_url_like_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<String, EngineError> {
    required_field(node, fields, field_name, &join_path(base_path, field_name))?
        .as_url_like(node, &join_path(base_path, field_name))
}

fn optional_string_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<Option<String>, EngineError> {
    fields
        .get(field_name)
        .map(|value| value.as_string(node, &join_path(base_path, field_name)))
        .transpose()
}

fn optional_url_like_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<Option<String>, EngineError> {
    fields
        .get(field_name)
        .map(|value| value.as_url_like(node, &join_path(base_path, field_name)))
        .transpose()
}

fn optional_string_list_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_name: &str,
) -> Result<Option<Vec<String>>, EngineError> {
    let Some(value) = fields.get(field_name) else {
        return Ok(None);
    };
    let path = join_path(base_path, field_name);
    let items = value.clone_list(node, &path)?;
    items
        .into_iter()
        .enumerate()
        .map(|(index, item)| item.as_string(node, &format!("{path}[{index}]")))
        .collect::<Result<Vec<_>, _>>()
        .map(Some)
}

fn optional_text_like_field(
    node: &Node,
    fields: &BTreeMap<String, RuntimeValue>,
    base_path: &str,
    field_names: &[&str],
) -> Result<Option<String>, EngineError> {
    for field_name in field_names {
        if let Some(value) = fields.get(*field_name) {
            return value
                .as_text_like(node, &join_path(base_path, field_name))
                .map(Some);
        }
    }
    Ok(None)
}

fn required_field<'a>(
    node: &Node,
    fields: &'a BTreeMap<String, RuntimeValue>,
    field_name: &str,
    path: &str,
) -> Result<&'a RuntimeValue, EngineError> {
    fields
        .get(field_name)
        .ok_or_else(|| node_failure(node, format!("字段 `{path}` 缺失")))
}

fn join_path(base_path: &str, field_name: &str) -> String {
    format!("{base_path}.{field_name}")
}

trait RuntimeValueExt {
    fn expect_record(
        self,
        node: &Node,
        path: &str,
    ) -> Result<BTreeMap<String, RuntimeValue>, EngineError>;
    fn clone_list(&self, node: &Node, path: &str) -> Result<Vec<RuntimeValue>, EngineError>;
    fn as_string(&self, node: &Node, path: &str) -> Result<String, EngineError>;
    fn as_text_like(&self, node: &Node, path: &str) -> Result<String, EngineError>;
    fn as_url_like(&self, node: &Node, path: &str) -> Result<String, EngineError>;
}

impl RuntimeValueExt for RuntimeValue {
    fn expect_record(
        self,
        node: &Node,
        path: &str,
    ) -> Result<BTreeMap<String, RuntimeValue>, EngineError> {
        match self {
            RuntimeValue::Record(fields) => Ok(fields),
            other => Err(node_failure(
                node,
                format!("字段 `{path}` 期望 record，实际为 `{}`", other.type_label()),
            )),
        }
    }

    fn clone_list(&self, node: &Node, path: &str) -> Result<Vec<RuntimeValue>, EngineError> {
        match self {
            RuntimeValue::List(items) => Ok(items.clone()),
            other => Err(node_failure(
                node,
                format!("字段 `{path}` 期望 list，实际为 `{}`", other.type_label()),
            )),
        }
    }

    fn as_string(&self, node: &Node, path: &str) -> Result<String, EngineError> {
        match self {
            RuntimeValue::Text(text) => Ok(text.clone()),
            other => Err(node_failure(
                node,
                format!("字段 `{path}` 期望 text，实际为 `{}`", other.type_label()),
            )),
        }
    }

    fn as_text_like(&self, node: &Node, path: &str) -> Result<String, EngineError> {
        match self {
            RuntimeValue::Text(text) | RuntimeValue::Html(text) => Ok(text.clone()),
            other => Err(node_failure(
                node,
                format!(
                    "字段 `{path}` 期望 text/html，实际为 `{}`",
                    other.type_label()
                ),
            )),
        }
    }

    fn as_url_like(&self, node: &Node, path: &str) -> Result<String, EngineError> {
        match self {
            RuntimeValue::Text(text) | RuntimeValue::Url(text) => Ok(text.clone()),
            other => Err(node_failure(
                node,
                format!(
                    "字段 `{path}` 期望 text/url，实际为 `{}`",
                    other.type_label()
                ),
            )),
        }
    }
}
