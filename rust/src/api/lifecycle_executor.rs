use std::{collections::HashMap, future::Future};

use flutter_rust_bridge::frb;

use crate::{
    domain::{
        phase::{
            ChapterItem, ContentData, ContentType, DetailData, ExploreData, LifecyclePhase,
            PhaseContext, PhaseData, PhaseResult, SearchData, SearchItem, TocData,
        },
        rule::{
            crawler_rule::CrawlerRule,
            lifecycle::{ContentConfig, DetailConfig, ExploreConfig, SearchConfig, TocConfig},
            network::NetworkConfig,
            pipeline::{NodePayload, PipelineExecuteRequest, PipelineOperation},
        },
    },
    error::CrawlerError,
    internal::{
        html_parser::execute_pipeline,
        http_client::{self, EmulationType, HttpRequest, HttpResponse},
    },
};

/// 执行指定生命周期阶段并返回结构化结果
#[frb]
pub async fn execute_lifecycle_phase(
    rule: CrawlerRule,
    phase: LifecyclePhase,
    context: PhaseContext,
) -> Result<PhaseResult, CrawlerError> {
    match execute_lifecycle_phase_with_fetcher(rule, phase, context, http_client::fetch).await {
        Ok(result) => Ok(result),
        Err(error) => Ok(PhaseResult {
            success: false,
            final_url: None,
            content_type: ContentType::Html,
            raw_body: None,
            data: None,
            error: Some(error),
        }),
    }
}

async fn execute_lifecycle_phase_with_fetcher<F, Fut>(
    rule: CrawlerRule,
    phase: LifecyclePhase,
    context: PhaseContext,
    fetcher: F,
) -> Result<PhaseResult, CrawlerError>
where
    F: Fn(HttpRequest) -> Fut,
    Fut: Future<Output = Result<HttpResponse, String>>,
{
    let url_template = get_phase_url_template(&rule, &phase)?;
    let url = build_phase_url(&phase, url_template, &context)?;

    if let Some(network_config) = &rule.network {
        if !network_config.strategy.eq_ignore_ascii_case("http") {
            return Err(CrawlerError::InvalidInput(format!(
                "当前仅支持 http 策略，收到: {}",
                network_config.strategy
            )));
        }
    }

    let request = build_http_request(url, rule.network.as_ref());

    let response = fetcher(request).await.map_err(|error| {
        if error.contains("需要认证") {
            CrawlerError::AuthRequired(error)
        } else {
            CrawlerError::InvalidInput(error)
        }
    })?;

    if is_waf_intercepted(response.status, &response.headers) {
        return Err(CrawlerError::AuthRequired(response.status.to_string()));
    }

    if response.status >= 400 {
        return Err(CrawlerError::InvalidInput(format!(
            "HTTP 请求失败: 状态码 {}",
            response.status
        )));
    }

    let content_type = detect_content_type(&response.headers, context.vars.as_ref())?;
    let operations = build_phase_operations(&rule, &phase, &content_type)?;
    let pipeline_result = execute_pipeline(PipelineExecuteRequest {
        content: response.body.clone(),
        base_url: Some(response.url.clone()),
        vars: context
            .vars
            .as_ref()
            .and_then(|vars| serde_json::to_string(vars).ok()),
        operations,
    });

    if !pipeline_result.success {
        return Err(CrawlerError::DataParseError {
            reason: pipeline_result
                .error
                .unwrap_or_else(|| "Pipeline 执行失败".to_string()),
        });
    }

    let structured_data = convert_to_phase_data(&phase, pipeline_result.data)?;

    Ok(PhaseResult {
        success: true,
        final_url: Some(response.url),
        content_type,
        raw_body: Some(response.body),
        data: Some(structured_data),
        error: None,
    })
}

fn get_phase_url_template<'a>(
    rule: &'a CrawlerRule,
    phase: &LifecyclePhase,
) -> Result<&'a str, CrawlerError> {
    match phase {
        LifecyclePhase::Explore => {
            let config: &ExploreConfig = rule.lifecycle.explore.as_ref().ok_or_else(|| {
                CrawlerError::MissingPhaseConfig {
                    phase: "explore".to_string(),
                }
            })?;
            Ok(config.url.as_str())
        }
        LifecyclePhase::Search => {
            let config: &SearchConfig =
                rule.lifecycle
                    .search
                    .as_ref()
                    .ok_or_else(|| CrawlerError::MissingPhaseConfig {
                        phase: "search".to_string(),
                    })?;
            Ok(config.url.as_str())
        }
        LifecyclePhase::Detail | LifecyclePhase::Toc | LifecyclePhase::Content => {
            Ok(contextual_url_placeholder())
        }
    }
}

fn contextual_url_placeholder() -> &'static str {
    "{{url}}"
}

fn build_phase_url(
    phase: &LifecyclePhase,
    template: &str,
    context: &PhaseContext,
) -> Result<String, CrawlerError> {
    if matches!(
        phase,
        LifecyclePhase::Detail | LifecyclePhase::Toc | LifecyclePhase::Content
    ) {
        return context
            .url
            .clone()
            .ok_or_else(|| CrawlerError::MissingRequiredContext {
                field: "url".to_string(),
            });
    }

    let mut url = template.to_string();

    if url.contains("{{key}}") {
        let keyword =
            context
                .keyword
                .as_ref()
                .ok_or_else(|| CrawlerError::MissingRequiredContext {
                    field: "keyword".to_string(),
                })?;
        url = url.replace("{{key}}", &encode_url_component(keyword));
    }

    if url.contains("{{page}}") {
        let page = context
            .page
            .ok_or_else(|| CrawlerError::MissingRequiredContext {
                field: "page".to_string(),
            })?;
        url = url.replace("{{page}}", &page.to_string());
    }

    if let Some(vars) = &context.vars {
        for (key, value) in vars {
            let pattern = format!("{{{{{}}}}}", key);
            url = url.replace(&pattern, &encode_url_component(value));
        }
    }

    if url.contains("{{") || url.contains("}}") {
        return Err(CrawlerError::UrlTemplateError {
            reason: format!("模板包含未替换变量: {}", url),
        });
    }

    Ok(url)
}

fn build_http_request(url: String, network: Option<&NetworkConfig>) -> HttpRequest {
    let mut request = HttpRequest {
        url,
        method: "GET".to_string(),
        headers: None,
        body: None,
        emulation: EmulationType::Chrome131,
        timeout_ms: 30_000,
        follow_redirects: true,
    };

    if let Some(network_config) = network {
        if let Some(connect_timeout) = network_config.connect_timeout {
            request.timeout_ms = connect_timeout;
        }
        request.headers = network_config.headers.clone();
        request.emulation = map_emulation_type(network_config);
    }

    request
}

fn encode_url_component(value: &str) -> String {
    url::form_urlencoded::byte_serialize(value.as_bytes()).collect()
}

fn map_emulation_type(network: &NetworkConfig) -> EmulationType {
    if let Some(option) = &network.emulation {
        if let Some(kind) = option.emulation {
            return match kind {
                crate::domain::rule::network::Emulation::Chrome132 => EmulationType::Chrome132,
                crate::domain::rule::network::Emulation::Chrome133 => EmulationType::Chrome133,
                crate::domain::rule::network::Emulation::Chrome134 => EmulationType::Chrome134,
                crate::domain::rule::network::Emulation::Chrome135 => EmulationType::Chrome135,
                crate::domain::rule::network::Emulation::Chrome136 => EmulationType::Chrome136,
                crate::domain::rule::network::Emulation::Chrome120 => EmulationType::Chrome120,
                crate::domain::rule::network::Emulation::Chrome124 => EmulationType::Chrome124,
                crate::domain::rule::network::Emulation::Chrome126 => EmulationType::Chrome126,
                crate::domain::rule::network::Emulation::Chrome127 => EmulationType::Chrome127,
                crate::domain::rule::network::Emulation::Chrome128 => EmulationType::Chrome128,
                crate::domain::rule::network::Emulation::Chrome129 => EmulationType::Chrome129,
                crate::domain::rule::network::Emulation::Chrome130 => EmulationType::Chrome130,
                crate::domain::rule::network::Emulation::Safari18 => EmulationType::Safari18,
                crate::domain::rule::network::Emulation::Safari18_2 => EmulationType::Safari18_2,
                crate::domain::rule::network::Emulation::Safari18_3 => EmulationType::Safari18_3,
                crate::domain::rule::network::Emulation::Safari18_5 => EmulationType::Safari18_5,
                crate::domain::rule::network::Emulation::Safari26 => EmulationType::Safari26,
                crate::domain::rule::network::Emulation::SafariIos18_1_1 => {
                    EmulationType::SafariIos18_1_1
                }
                crate::domain::rule::network::Emulation::Firefox133 => EmulationType::Firefox133,
                crate::domain::rule::network::Emulation::Firefox135 => EmulationType::Firefox135,
                crate::domain::rule::network::Emulation::Firefox136 => EmulationType::Firefox136,
                crate::domain::rule::network::Emulation::Firefox139 => EmulationType::Firefox139,
                crate::domain::rule::network::Emulation::Firefox142 => EmulationType::Firefox142,
                crate::domain::rule::network::Emulation::Firefox143 => EmulationType::Firefox143,
                crate::domain::rule::network::Emulation::Firefox144 => EmulationType::Firefox144,
                crate::domain::rule::network::Emulation::Firefox145 => EmulationType::Firefox145,
                crate::domain::rule::network::Emulation::Firefox146 => EmulationType::Firefox146,
                crate::domain::rule::network::Emulation::Firefox147 => EmulationType::Firefox147,
                crate::domain::rule::network::Emulation::Edge127 => EmulationType::Edge127,
                crate::domain::rule::network::Emulation::Edge131 => EmulationType::Edge131,
                crate::domain::rule::network::Emulation::Edge134 => EmulationType::Edge134,
                crate::domain::rule::network::Emulation::Edge135 => EmulationType::Edge135,
                crate::domain::rule::network::Emulation::Edge136 => EmulationType::Edge136,
                crate::domain::rule::network::Emulation::Edge137 => EmulationType::Edge137,
                crate::domain::rule::network::Emulation::Edge138 => EmulationType::Edge138,
                crate::domain::rule::network::Emulation::Edge139 => EmulationType::Edge139,
                crate::domain::rule::network::Emulation::Edge140 => EmulationType::Edge140,
                crate::domain::rule::network::Emulation::Edge141 => EmulationType::Edge141,
                crate::domain::rule::network::Emulation::Edge142 => EmulationType::Edge142,
                crate::domain::rule::network::Emulation::Edge143 => EmulationType::Edge143,
                crate::domain::rule::network::Emulation::Edge144 => EmulationType::Edge144,
                crate::domain::rule::network::Emulation::Edge145 => EmulationType::Edge145,
                crate::domain::rule::network::Emulation::OkHttp3_14 => EmulationType::OkHttp3_14,
                crate::domain::rule::network::Emulation::OkHttp4_12 => EmulationType::OkHttp4_12,
                crate::domain::rule::network::Emulation::OkHttp5 => EmulationType::OkHttp5,
                crate::domain::rule::network::Emulation::Chrome131 => EmulationType::Chrome131,
            };
        }
    }

    EmulationType::Chrome131
}

fn detect_content_type(
    headers: &HashMap<String, String>,
    vars: Option<&HashMap<String, String>>,
) -> Result<ContentType, CrawlerError> {
    if let Some(variable_map) = vars {
        if let Some(override_type) = variable_map.get("content_type_override") {
            return parse_content_type_name(override_type);
        }
    }

    let content_type = headers
        .iter()
        .find(|(key, _)| key.eq_ignore_ascii_case("content-type"))
        .map(|(_, value)| value.to_ascii_lowercase())
        .unwrap_or_default();

    if content_type.contains("application/json") {
        Ok(ContentType::Json)
    } else if content_type.contains("application/xml") || content_type.contains("text/xml") {
        Ok(ContentType::Xml)
    } else {
        Ok(ContentType::Html)
    }
}

fn parse_content_type_name(raw: &str) -> Result<ContentType, CrawlerError> {
    match raw.to_ascii_lowercase().as_str() {
        "html" | "text/html" => Ok(ContentType::Html),
        "json" | "application/json" => Ok(ContentType::Json),
        "xml" | "application/xml" | "text/xml" => Ok(ContentType::Xml),
        other => Err(CrawlerError::UnsupportedContentType {
            content_type: other.to_string(),
        }),
    }
}

fn is_waf_intercepted(status: u16, headers: &HashMap<String, String>) -> bool {
    if status != 403 && status != 503 {
        return false;
    }

    headers
        .keys()
        .any(|key| key.eq_ignore_ascii_case("cf-ray") || key.eq_ignore_ascii_case("cf-mitigated"))
}

fn build_phase_operations(
    rule: &CrawlerRule,
    phase: &LifecyclePhase,
    content_type: &ContentType,
) -> Result<Vec<PipelineOperation>, CrawlerError> {
    let pipeline =
        match phase {
            LifecyclePhase::Explore => {
                let config: &ExploreConfig = rule.lifecycle.explore.as_ref().ok_or_else(|| {
                    CrawlerError::MissingPhaseConfig {
                        phase: "explore".to_string(),
                    }
                })?;
                &config.pipeline
            }
            LifecyclePhase::Search => {
                let config: &SearchConfig = rule.lifecycle.search.as_ref().ok_or_else(|| {
                    CrawlerError::MissingPhaseConfig {
                        phase: "search".to_string(),
                    }
                })?;
                &config.pipeline
            }
            LifecyclePhase::Detail => {
                let config: &DetailConfig = rule.lifecycle.detail.as_ref().ok_or_else(|| {
                    CrawlerError::MissingPhaseConfig {
                        phase: "detail".to_string(),
                    }
                })?;
                &config.pipeline
            }
            LifecyclePhase::Toc => {
                let config: &TocConfig = rule.lifecycle.toc.as_ref().ok_or_else(|| {
                    CrawlerError::MissingPhaseConfig {
                        phase: "toc".to_string(),
                    }
                })?;
                &config.pipeline
            }
            LifecyclePhase::Content => {
                let config: &ContentConfig = rule.lifecycle.content.as_ref().ok_or_else(|| {
                    CrawlerError::MissingPhaseConfig {
                        phase: "content".to_string(),
                    }
                })?;
                &config.pipeline
            }
        };

    let sorted_nodes = sort_pipeline_nodes(pipeline);
    let mut operations = Vec::new();
    for node in sorted_nodes {
        match &node.data {
            NodePayload::Selector(selector_def) => {
                let operation = match selector_def {
                    crate::domain::rule::pipeline::SelectorDef::Css { selector } => {
                        PipelineOperation {
                            op_type: "css".to_string(),
                            param: Some(selector.clone()),
                            param2: None,
                        }
                    }
                    crate::domain::rule::pipeline::SelectorDef::XPath { query } => {
                        PipelineOperation {
                            op_type: "xpath".to_string(),
                            param: Some(query.clone()),
                            param2: None,
                        }
                    }
                    crate::domain::rule::pipeline::SelectorDef::JsonPath { path } => {
                        PipelineOperation {
                            op_type: "jsonpath".to_string(),
                            param: Some(path.clone()),
                            param2: None,
                        }
                    }
                    crate::domain::rule::pipeline::SelectorDef::Regex { pattern } => {
                        PipelineOperation {
                            op_type: "regex".to_string(),
                            param: Some(pattern.clone()),
                            param2: None,
                        }
                    }
                };

                validate_selector_for_content_type(content_type, &operation.op_type)?;
                operations.push(operation);
            }
            NodePayload::Transform(transform_def) => {
                let operation = match transform_def {
                    crate::domain::rule::pipeline::TransformDef::Trim => PipelineOperation {
                        op_type: "trim".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::TransformDef::Lower => PipelineOperation {
                        op_type: "lower".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::TransformDef::Upper => PipelineOperation {
                        op_type: "upper".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::TransformDef::RegexReplace {
                        pattern,
                        replace,
                    } => PipelineOperation {
                        op_type: "replace".to_string(),
                        param: Some(pattern.clone()),
                        param2: Some(replace.clone()),
                    },
                    crate::domain::rule::pipeline::TransformDef::Text => PipelineOperation {
                        op_type: "text".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::TransformDef::Attr { name } => {
                        PipelineOperation {
                            op_type: "attr".to_string(),
                            param: Some(name.clone()),
                            param2: None,
                        }
                    }
                    crate::domain::rule::pipeline::TransformDef::Url => PipelineOperation {
                        op_type: "url".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::TransformDef::Js { script } => {
                        PipelineOperation {
                            op_type: "js".to_string(),
                            param: Some(script.clone()),
                            param2: None,
                        }
                    }
                };
                operations.push(operation);
            }
            NodePayload::Aggregation(aggregation_def) => {
                let operation = match aggregation_def {
                    crate::domain::rule::pipeline::AggregationDef::First => PipelineOperation {
                        op_type: "first".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::AggregationDef::Last => PipelineOperation {
                        op_type: "last".to_string(),
                        param: None,
                        param2: None,
                    },
                    crate::domain::rule::pipeline::AggregationDef::Join { separator } => {
                        PipelineOperation {
                            op_type: "join".to_string(),
                            param: Some(separator.clone()),
                            param2: None,
                        }
                    }
                    crate::domain::rule::pipeline::AggregationDef::Array => PipelineOperation {
                        op_type: "array".to_string(),
                        param: None,
                        param2: None,
                    },
                };
                operations.push(operation);
            }
        }
    }

    Ok(operations)
}

fn sort_pipeline_nodes(
    pipeline: &crate::domain::rule::pipeline::PipelineGraph,
) -> Vec<&crate::domain::rule::pipeline::FlowNode> {
    let mut id_to_node = HashMap::new();
    for node in &pipeline.nodes {
        id_to_node.insert(node.id.clone(), node);
    }

    let mut indegree: HashMap<String, usize> = pipeline
        .nodes
        .iter()
        .map(|node| (node.id.clone(), 0usize))
        .collect();
    let mut adjacency: HashMap<String, Vec<String>> = HashMap::new();

    for edge in &pipeline.edges {
        if indegree.contains_key(&edge.target) && indegree.contains_key(&edge.source) {
            *indegree.entry(edge.target.clone()).or_insert(0) += 1;
            adjacency
                .entry(edge.source.clone())
                .or_default()
                .push(edge.target.clone());
        }
    }

    let mut queue: Vec<String> = indegree
        .iter()
        .filter_map(|(id, degree)| if *degree == 0 { Some(id.clone()) } else { None })
        .collect();
    queue.sort();

    let mut ordered_ids = Vec::new();
    while let Some(current) = queue.pop() {
        ordered_ids.push(current.clone());
        if let Some(neighbors) = adjacency.get(&current) {
            for neighbor in neighbors {
                if let Some(degree) = indegree.get_mut(neighbor) {
                    *degree = degree.saturating_sub(1);
                    if *degree == 0 {
                        queue.push(neighbor.clone());
                    }
                }
            }
            queue.sort();
        }
    }

    if ordered_ids.len() != pipeline.nodes.len() {
        return pipeline.nodes.iter().collect();
    }

    ordered_ids
        .into_iter()
        .filter_map(|id| id_to_node.get(&id).copied())
        .collect()
}

fn validate_selector_for_content_type(
    content_type: &ContentType,
    selector: &str,
) -> Result<(), CrawlerError> {
    if *content_type == ContentType::Json && selector == "xpath" {
        return Err(CrawlerError::UnsupportedContentType {
            content_type: "JSON 不支持 XPath 选择器".to_string(),
        });
    }

    Ok(())
}

fn convert_to_phase_data(
    phase: &LifecyclePhase,
    values: Vec<String>,
) -> Result<PhaseData, CrawlerError> {
    match phase {
        LifecyclePhase::Explore => Ok(PhaseData::Explore(ExploreData { items: values })),
        LifecyclePhase::Search => Ok(PhaseData::Search(SearchData {
            items: values
                .into_iter()
                .map(|item| {
                    let fields: Vec<&str> = item.split('|').collect();
                    SearchItem {
                        title: fields
                            .first()
                            .map_or_else(|| "".to_string(), |value| value.to_string()),
                        url: fields
                            .get(1)
                            .map_or_else(|| "".to_string(), |value| value.to_string()),
                        cover: fields.get(2).map(|value| value.to_string()),
                        author: fields.get(3).map(|value| value.to_string()),
                    }
                })
                .collect(),
        })),
        LifecyclePhase::Detail => {
            let fields = values
                .into_iter()
                .enumerate()
                .map(|(index, value)| (format!("field_{}", index), value))
                .collect();
            Ok(PhaseData::Detail(DetailData { fields }))
        }
        LifecyclePhase::Toc => Ok(PhaseData::Toc(TocData {
            chapters: values
                .into_iter()
                .map(|value| {
                    let fields: Vec<&str> = value.split('|').collect();
                    ChapterItem {
                        title: fields
                            .first()
                            .map_or_else(|| "".to_string(), |item| item.to_string()),
                        url: fields.get(1).map(|item| item.to_string()),
                    }
                })
                .collect(),
        })),
        LifecyclePhase::Content => {
            let content = values.first().cloned().unwrap_or_default();
            let media = if values.len() > 1 {
                values[1..].to_vec()
            } else {
                Vec::new()
            };
            Ok(PhaseData::Content(ContentData { content, media }))
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::domain::rule::{
        lifecycle::{DetailConfig, Lifecycle, SearchConfig, TocConfig},
        pipeline::PipelineGraph,
    };

    fn build_test_rule() -> CrawlerRule {
        CrawlerRule {
            id: "test".to_string(),
            name: "测试规则".to_string(),
            description: "用于测试".to_string(),
            author: "tester".to_string(),
            version: "1.0.0".to_string(),
            network: None,
            aggregation: None,
            lifecycle: Lifecycle {
                explore: None,
                search: Some(SearchConfig {
                    url: "https://example.com/search?q={{key}}&page={{page}}".to_string(),
                    pipeline: PipelineGraph {
                        nodes: vec![],
                        edges: vec![],
                    },
                }),
                detail: Some(DetailConfig {
                    pipeline: PipelineGraph {
                        nodes: vec![],
                        edges: vec![],
                    },
                }),
                toc: Some(TocConfig {
                    pipeline: PipelineGraph {
                        nodes: vec![],
                        edges: vec![],
                    },
                }),
                content: Some(ContentConfig {
                    pipeline: PipelineGraph {
                        nodes: vec![],
                        edges: vec![],
                    },
                    sniff_media: false,
                }),
            },
        }
    }

    #[test]
    fn replace_url_template_success() {
        let context = PhaseContext {
            url: None,
            keyword: Some("abc".to_string()),
            page: Some(2),
            vars: Some(HashMap::from([("site".to_string(), "x".to_string())])),
        };
        let url = build_phase_url(
            &LifecyclePhase::Search,
            "https://example.com/{{site}}?k={{key}}&p={{page}}",
            &context,
        )
        .expect("URL 模板替换应成功");
        assert_eq!(url, "https://example.com/x?k=abc&p=2");
    }

    #[test]
    fn replace_url_template_missing_var() {
        let context = PhaseContext {
            url: None,
            keyword: Some("abc".to_string()),
            page: Some(1),
            vars: None,
        };
        let result = build_phase_url(
            &LifecyclePhase::Search,
            "https://example.com/{{site}}?k={{key}}",
            &context,
        );
        assert!(matches!(result, Err(CrawlerError::UrlTemplateError { .. })));
    }

    #[test]
    fn detect_content_type_auto_and_override() {
        let headers = HashMap::from([(
            "content-type".to_string(),
            "application/json; charset=utf-8".to_string(),
        )]);
        let auto = detect_content_type(&headers, None).expect("应识别 JSON");
        assert_eq!(auto, ContentType::Json);

        let vars = HashMap::from([("content_type_override".to_string(), "xml".to_string())]);
        let override_type = detect_content_type(&headers, Some(&vars)).expect("覆盖应生效");
        assert_eq!(override_type, ContentType::Xml);
    }

    #[test]
    fn detect_waf() {
        let waf_headers = HashMap::from([("cf-ray".to_string(), "abc".to_string())]);
        let plain_headers = HashMap::new();

        assert!(is_waf_intercepted(403, &waf_headers));
        assert!(!is_waf_intercepted(403, &plain_headers));
        assert!(!is_waf_intercepted(200, &waf_headers));
    }

    #[tokio::test]
    async fn execute_search_phase_integration() {
        let rule = build_test_rule();
        let context = PhaseContext {
            url: None,
            keyword: Some("rust".to_string()),
            page: Some(1),
            vars: None,
        };
        let result = execute_lifecycle_phase_with_fetcher(
            rule,
            LifecyclePhase::Search,
            context,
            |_| async {
                Ok(HttpResponse {
                    status: 200,
                    headers: HashMap::from([("content-type".to_string(), "text/html".to_string())]),
                    body: "<html><body>ok</body></html>".to_string(),
                    url: "https://example.com/search?q=rust&page=1".to_string(),
                })
            },
        )
        .await
        .expect("搜索阶段应执行成功");

        assert!(result.success);
        assert!(matches!(result.data, Some(PhaseData::Search(_))));
    }

    #[tokio::test]
    async fn execute_detail_phase_integration() {
        let rule = build_test_rule();
        let context = PhaseContext {
            url: Some("https://example.com/book/1".to_string()),
            keyword: None,
            page: None,
            vars: None,
        };

        let result = execute_lifecycle_phase_with_fetcher(
            rule,
            LifecyclePhase::Detail,
            context,
            |_| async {
                Ok(HttpResponse {
                    status: 200,
                    headers: HashMap::from([("content-type".to_string(), "text/html".to_string())]),
                    body: "<html><body>detail</body></html>".to_string(),
                    url: "https://example.com/book/1".to_string(),
                })
            },
        )
        .await
        .expect("详情阶段应执行成功");

        assert!(result.success);
        assert!(matches!(result.data, Some(PhaseData::Detail(_))));
    }

    #[test]
    fn benchmark_new_vs_old_pipeline_path() {
        use std::time::Instant;

        let values = vec!["标题|https://example.com".to_string(); 2000];
        let start_new = Instant::now();
        let _ = convert_to_phase_data(&LifecyclePhase::Search, values.clone())
            .expect("新路径转换应成功");
        let elapsed_new = start_new.elapsed();

        let start_old = Instant::now();
        let _ = values.join("\n");
        let elapsed_old = start_old.elapsed();

        assert!(elapsed_new.as_millis() <= elapsed_old.as_millis().saturating_mul(4) + 1);
    }
}
