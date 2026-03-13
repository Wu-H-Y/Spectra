use std::{
    collections::{BTreeMap, HashMap},
    io::{Read, Write},
    net::TcpListener,
    sync::{Arc, Mutex as StdMutex},
    thread,
    time::{Duration, Instant},
};

use tokio::sync::{Mutex, mpsc};

use super::{EngineContext, EngineError, RuntimeValue, execute_rule};
use crate::rules_ir::{
    Capabilities, DataType, Edge, Graph, LifecyclePhase, Metadata, Node, NodeEvent, NodeKind, Port,
    PortRef, RuleEnvelope, RuleRateLimit,
};

fn text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Text,
        optional: false,
    }
}

fn list_text_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::List {
            item: Box::new(DataType::Text),
        },
        optional: false,
    }
}

fn html_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Html,
        optional: false,
    }
}

fn json_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Json,
        optional: false,
    }
}

fn url_port(name: &str) -> Port {
    Port {
        name: name.to_string(),
        data_type: DataType::Url,
        optional: false,
    }
}

fn params(entries: &[(&str, &str)]) -> BTreeMap<String, String> {
    entries
        .iter()
        .map(|(key, value)| ((*key).to_string(), (*value).to_string()))
        .collect()
}

fn spawn_single_response_http_server(body: &str, content_type: &str) -> String {
    spawn_single_response_http_server_with_status(
        "HTTP/1.1 200 OK",
        body,
        &[("Content-Type", content_type)],
    )
}

fn spawn_single_response_http_server_with_status(
    status_line: &str,
    body: &str,
    headers: &[(&str, &str)],
) -> String {
    let listener = TcpListener::bind("127.0.0.1:0").expect("应可绑定本地测试端口");
    let address = listener.local_addr().expect("应可读取监听地址");
    let status_line = status_line.to_string();
    let body = body.to_string();
    let headers = headers
        .iter()
        .map(|(name, value)| ((*name).to_string(), (*value).to_string()))
        .collect::<Vec<_>>();

    thread::spawn(move || {
        if let Ok((mut stream, _)) = listener.accept() {
            let mut request_buffer = [0_u8; 1024];
            let _ = stream.read(&mut request_buffer);
            let header_lines = headers
                .iter()
                .map(|(name, value)| format!("{name}: {value}\r\n"))
                .collect::<String>();
            let response = format!(
                "{status_line}\r\n{header_lines}Content-Length: {}\r\nConnection: close\r\n\r\n{body}",
                body.len()
            );
            let _ = stream.write_all(response.as_bytes());
            let _ = stream.flush();
        }
    });

    format!("http://{address}/")
}

fn spawn_cookie_capture_http_server(
    responses: Vec<(&'static str, Vec<(&'static str, &'static str)>)>,
) -> (String, Arc<StdMutex<Vec<Option<String>>>>) {
    let listener = TcpListener::bind("127.0.0.1:0").expect("应可绑定本地测试端口");
    let address = listener.local_addr().expect("应可读取监听地址");
    let observed_cookies = Arc::new(StdMutex::new(Vec::<Option<String>>::new()));
    let observed_cookies_for_thread = Arc::clone(&observed_cookies);

    thread::spawn(move || {
        for (body, headers) in responses {
            let Ok((mut stream, _)) = listener.accept() else {
                break;
            };

            let mut request_bytes = Vec::new();
            let mut buffer = [0_u8; 1024];
            loop {
                let Ok(read) = stream.read(&mut buffer) else {
                    break;
                };
                if read == 0 {
                    break;
                }
                request_bytes.extend_from_slice(&buffer[..read]);
                if request_bytes.windows(4).any(|window| window == b"\r\n\r\n") {
                    break;
                }
            }

            let request_text = String::from_utf8_lossy(&request_bytes);
            let cookie_header = request_text.lines().find_map(|line| {
                let lower = line.to_ascii_lowercase();
                if lower.starts_with("cookie:") {
                    Some(line[7..].trim().to_string())
                } else {
                    None
                }
            });
            observed_cookies_for_thread
                .lock()
                .expect("应可写入观察到的 Cookie")
                .push(cookie_header);

            let header_lines = headers
                .iter()
                .map(|(name, value)| format!("{name}: {value}\r\n"))
                .collect::<String>();
            let response = format!(
                "HTTP/1.1 200 OK\r\n{header_lines}Content-Type: text/plain; charset=utf-8\r\nContent-Length: {}\r\nConnection: close\r\n\r\n{body}",
                body.len()
            );
            let _ = stream.write_all(response.as_bytes());
            let _ = stream.flush();
        }
    });

    (format!("http://{address}/"), observed_cookies)
}

fn build_rule(
    nodes: Vec<Node>,
    edges: Vec<Edge>,
    normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
) -> RuleEnvelope {
    RuleEnvelope {
        ir_version: "1.0.0".to_string(),
        metadata: Metadata {
            rule_id: "test.rule".to_string(),
            name: "测试规则".to_string(),
            description: Some("用于 rules_engine 单测".to_string()),
        },
        graph: Graph {
            nodes,
            edges,
            phase_entrypoints: BTreeMap::new(),
            metadata: None,
            layout: None,
        },
        normalized_outputs,
        capabilities: Capabilities {
            supports_pagination: false,
            supports_concurrency: false,
            requires_auth: false,
            supports_js: false,
            codec: false,
            crypto: Default::default(),
            allow_inline_secrets: false,
        },
        rate_limit: None,
    }
}

fn build_rule_with_rate_limit(
    nodes: Vec<Node>,
    edges: Vec<Edge>,
    normalized_outputs: BTreeMap<LifecyclePhase, PortRef>,
    rate_limit: RuleRateLimit,
) -> RuleEnvelope {
    let mut rule = build_rule(nodes, edges, normalized_outputs);
    rule.rate_limit = Some(rate_limit);
    rule
}

fn build_single_fetch_rule(url: &str, response: &str, output: Port) -> RuleEnvelope {
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "fetch".to_string(),
            port_name: output.name.clone(),
        },
    );

    build_rule(
        vec![Node {
            id: "fetch".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![output],
            params: params(&[("method", "get"), ("response", response), ("url", url)]),
        }],
        vec![],
        normalized_outputs,
    )
}

fn runtime_node_with_single_input(node: Node, value: RuntimeValue) -> super::graph::RuntimeNode {
    let input_name = node
        .inputs
        .first()
        .expect("测试节点应至少包含一个输入端口")
        .name
        .clone();
    let (sender, receiver) = mpsc::channel(1);
    sender.try_send(value).expect("测试输入应可写入单节点通道");
    drop(sender);

    let mut input_receivers = HashMap::new();
    input_receivers.insert(input_name, vec![receiver]);

    super::graph::RuntimeNode {
        node,
        input_receivers,
        output_senders: HashMap::new(),
    }
}

#[tokio::test]
async fn fan_out_execution_reaches_each_branch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "left".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "right".to_string(),
            kind: NodeKind::Filter,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "left".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "right".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let rule = build_rule(nodes, edges, BTreeMap::new());
    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("fanout".to_string()),
    );
    context.run_id = Some("run-fanout".to_string());

    let result = execute_rule(&rule, context)
        .await
        .expect("fan-out 图应执行成功");

    let port_emit_count = result
        .events
        .iter()
        .filter(|event| matches!(event, crate::rules_ir::NodeEvent::PortEmit { .. }))
        .count();
    assert_eq!(port_emit_count, 3);
    assert_eq!(result.node_stats["left"].input_messages, 1);
    assert_eq!(result.node_stats["right"].input_messages, 1);
}

#[tokio::test]
async fn join_collects_inputs_and_truncates_preview() {
    let nodes = vec![
        Node {
            id: "left_input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "right_input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "join".to_string(),
            kind: NodeKind::Join,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("left"), text_port("right")],
            outputs: vec![list_text_port("joined")],
            params: BTreeMap::new(),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![list_text_port("in")],
            outputs: vec![list_text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "left_input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "left".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "right_input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "right".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "join".to_string(),
                port_name: "joined".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let rule = build_rule(nodes, edges, BTreeMap::new());
    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "left_input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("L".repeat(900)),
    );
    context.port_inputs.insert(
        PortRef {
            node_id: "right_input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("R".repeat(900)),
    );
    context.run_id = Some("run-join".to_string());

    let result = execute_rule(&rule, context)
        .await
        .expect("join 图应执行成功");

    assert!(matches!(
        result.final_result,
        Some(RuntimeValue::List(ref items)) if items.len() == 2
    ));
    let join_emit = result
        .events
        .iter()
        .find(|event| matches!(event, crate::rules_ir::NodeEvent::PortEmit { node_id, .. } if node_id == "join"))
        .expect("join 节点应发出 PortEmit");
    match join_emit {
        crate::rules_ir::NodeEvent::PortEmit {
            payload_preview,
            payload_truncated,
            ..
        } => {
            assert!(*payload_truncated);
            assert!(payload_preview.as_ref().expect("应有预览").len() <= 1024);
        }
        _ => unreachable!(),
    }
    assert_eq!(result.node_stats["join"].input_messages, 2);
    assert_eq!(result.node_stats["join"].output_messages, 1);
}

#[tokio::test]
async fn fetch_parse_css_select_and_transform_nodes_execute_in_runtime_dispatch() {
    let html = r#"<html><body><a class="item" href="/detail/42">详情</a></body></html>"#;
    let url = spawn_single_response_http_server(html, "text/html; charset=utf-8");

    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![url_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "fetch".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![html_port("body")],
            params: params(&[("method", "get"), ("response", "html")]),
        },
        Node {
            id: "parse".to_string(),
            kind: NodeKind::Parse,
            phase: LifecyclePhase::Search,
            inputs: vec![html_port("in")],
            outputs: vec![html_port("doc")],
            params: params(&[("format", "html")]),
        },
        Node {
            id: "select".to_string(),
            kind: NodeKind::Select,
            phase: LifecyclePhase::Search,
            inputs: vec![html_port("in")],
            outputs: vec![list_text_port("links")],
            params: params(&[
                ("engine", "css"),
                ("query", "a.item"),
                ("extract", "attr"),
                ("attr", "href"),
            ]),
        },
        Node {
            id: "pick_first".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![list_text_port("in")],
            outputs: vec![text_port("first")],
            params: params(&[("family", "list"), ("op", "first")]),
        },
        Node {
            id: "join_url".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![url_port("abs")],
            params: params(&[
                ("family", "url"),
                ("op", "join"),
                ("base", "https://example.com"),
            ]),
        },
        Node {
            id: "convert_text".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![text_port("text")],
            params: params(&[("family", "convert"), ("op", "text")]),
        },
        Node {
            id: "normalize_url".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![url_port("out")],
            params: params(&[("family", "url"), ("op", "normalize")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![url_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "fetch".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "fetch".to_string(),
                port_name: "body".to_string(),
            },
            to: PortRef {
                node_id: "parse".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "parse".to_string(),
                port_name: "doc".to_string(),
            },
            to: PortRef {
                node_id: "select".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "select".to_string(),
                port_name: "links".to_string(),
            },
            to: PortRef {
                node_id: "pick_first".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "pick_first".to_string(),
                port_name: "first".to_string(),
            },
            to: PortRef {
                node_id: "join_url".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "join_url".to_string(),
                port_name: "abs".to_string(),
            },
            to: PortRef {
                node_id: "convert_text".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "convert_text".to_string(),
                port_name: "text".to_string(),
            },
            to: PortRef {
                node_id: "normalize_url".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "normalize_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );

    let rule = build_rule(nodes, edges, normalized_outputs);
    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(url),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("fetch/parse/select/transform 链路应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Url(
            "https://example.com/detail/42".to_string()
        ))
    );
}

#[tokio::test]
async fn fetch_node_returns_challenge_required_for_cloudflare_style_response() {
    let url = spawn_single_response_http_server_with_status(
        "HTTP/1.1 503 Service Unavailable",
        "blocked by upstream challenge",
        &[
            ("Content-Type", "text/html; charset=utf-8"),
            ("cf-mitigated", "challenge"),
        ],
    );
    let rule = build_single_fetch_rule(&url, "html", html_port("result"));

    let result = execute_rule(&rule, EngineContext::default()).await;

    assert!(matches!(
        result,
        Err(EngineError::NodeFailed {
            ref node_id,
            ref message,
            code: Some(ref code),
        })
        if node_id == "fetch"
            && code == "CHALLENGE_REQUIRED"
            && message.contains("已中止当前请求")
            && message.contains("暂不支持交互式会话处理")
    ));
}

#[tokio::test]
async fn fetch_node_keeps_ordinary_200_success_unaffected() {
    let url = spawn_single_response_http_server("plain success body", "text/plain; charset=utf-8");
    let rule = build_single_fetch_rule(&url, "text", text_port("result"));

    let result = execute_rule(&rule, EngineContext::default())
        .await
        .expect("普通 200 响应不应触发挑战检测");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("plain success body".to_string()))
    );
}

#[tokio::test]
async fn cookie_put_then_same_domain_fetch_auto_sends_cookie() {
    let (server_url, observed_cookies) =
        spawn_cookie_capture_http_server(vec![("cookie-ok", vec![])]);
    let domain = url::Url::parse(&server_url)
        .expect("测试 URL 应可解析")
        .host_str()
        .expect("测试 URL 应包含 host")
        .to_string();

    let nodes = vec![
        Node {
            id: "input_url".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![url_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![url_port("out")],
            params: params(&[
                ("name", "session"),
                ("value", "cookie-put-value"),
                ("domain", &domain),
                ("allowDomains", &domain),
            ]),
        },
        Node {
            id: "fetch".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![text_port("body")],
            params: params(&[("method", "get"), ("response", "text")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "fetch".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "fetch".to_string(),
                port_name: "body".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(server_url),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("CookiePut 后同域 fetch 应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("cookie-ok".to_string()))
    );
    let captured = observed_cookies
        .lock()
        .expect("应可读取抓到的 Cookie")
        .first()
        .cloned()
        .flatten()
        .unwrap_or_default();
    assert!(
        captured.contains("session=cookie-put-value"),
        "fetch 请求应自动附带 Cookie，实际为 `{captured}`"
    );
}

#[tokio::test]
async fn cookie_get_reads_current_jar_value() {
    let target_url = "http://example.local/path";
    let nodes = vec![
        Node {
            id: "input_url".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![url_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![url_port("out")],
            params: params(&[
                ("name", "session"),
                ("value", "cookie-readback"),
                ("domain", "example.local"),
                ("allowDomains", "example.local"),
            ]),
        },
        Node {
            id: "cookie_get".to_string(),
            kind: NodeKind::CookieGet,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("trigger")],
            outputs: vec![text_port("out")],
            params: params(&[("name", "session"), ("domain", "example.local")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_get".to_string(),
                port_name: "trigger".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cookie_get".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(target_url.to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("CookieGet 应读取当前 jar 的值");
    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("cookie-readback".to_string()))
    );
}

#[tokio::test]
async fn cookie_jar_reload_after_restart_still_auto_sends_cookie() {
    let seed_url = "http://reload.local/seed";
    let put_rule = build_rule(
        vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cookie_put".to_string(),
                kind: NodeKind::CookiePut,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![url_port("out")],
                params: params(&[
                    ("name", "session"),
                    ("value", "restart-cookie"),
                    ("domain", "127.0.0.1"),
                    ("allowDomains", "127.0.0.1"),
                ]),
            },
        ],
        vec![Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "in".to_string(),
            },
        }],
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "out".to_string(),
            },
        )]),
    );

    let mut first_context = EngineContext::default();
    first_context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(seed_url.to_string()),
    );
    let first_result = execute_rule(&put_rule, first_context)
        .await
        .expect("首次执行应写入 cookie 快照");
    let persisted_cookie_jar = first_result
        .cookie_jar_json
        .clone()
        .expect("应产出 cookie jar 快照");

    let (server_url, observed_cookies) =
        spawn_cookie_capture_http_server(vec![("reload-ok", vec![])]);
    let fetch_rule = build_rule(
        vec![
            Node {
                id: "input_url".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![url_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "fetch".to_string(),
                kind: NodeKind::Fetch,
                phase: LifecyclePhase::Search,
                inputs: vec![url_port("in")],
                outputs: vec![text_port("body")],
                params: params(&[("method", "get"), ("response", "text")]),
            },
        ],
        vec![Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "fetch".to_string(),
                port_name: "in".to_string(),
            },
        }],
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "fetch".to_string(),
                port_name: "body".to_string(),
            },
        )]),
    );

    let mut second_context = EngineContext {
        persisted_cookie_jar_json: Some(persisted_cookie_jar),
        ..EngineContext::default()
    };
    second_context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(server_url),
    );

    let second_result = execute_rule(&fetch_rule, second_context)
        .await
        .expect("重启后应继续自动附带 cookie");
    assert_eq!(
        second_result.final_result,
        Some(RuntimeValue::Text("reload-ok".to_string()))
    );

    let captured = observed_cookies
        .lock()
        .expect("应可读取抓到的 Cookie")
        .first()
        .cloned()
        .flatten()
        .unwrap_or_default();
    assert!(
        captured.contains("session=restart-cookie"),
        "重启加载后 fetch 应继续自动附带 Cookie，实际为 `{captured}`"
    );
}

#[tokio::test]
async fn expired_cookie_is_not_sent_by_fetch() {
    let (server_url, observed_cookies) =
        spawn_cookie_capture_http_server(vec![("expired-check", vec![])]);
    let expired = super::storage::current_unix_timestamp_secs()
        .saturating_sub(5)
        .to_string();

    let nodes = vec![
        Node {
            id: "input_url".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![url_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![url_port("out")],
            params: params(&[
                ("name", "session"),
                ("value", "expired-value"),
                ("domain", "127.0.0.1"),
                ("allowDomains", "127.0.0.1"),
                ("expires", &expired),
            ]),
        },
        Node {
            id: "fetch".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![text_port("body")],
            params: params(&[("method", "get"), ("response", "text")]),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "fetch".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let rule = build_rule(
        nodes,
        edges,
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "fetch".to_string(),
                port_name: "body".to_string(),
            },
        )]),
    );

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url(server_url),
    );

    let _ = execute_rule(&rule, context)
        .await
        .expect("过期 Cookie 不应导致 fetch 失败");
    let captured = observed_cookies
        .lock()
        .expect("应可读取抓到的 Cookie")
        .first()
        .cloned()
        .flatten()
        .unwrap_or_default();
    assert!(
        !captured.contains("session=expired-value"),
        "过期 Cookie 不应被自动发送，实际为 `{captured}`"
    );
}

#[tokio::test]
async fn expired_cookie_is_not_returned_by_cookie_get() {
    let expired = super::storage::current_unix_timestamp_secs()
        .saturating_sub(10)
        .to_string();
    let nodes = vec![
        Node {
            id: "input_url".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![url_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "cookie_put".to_string(),
            kind: NodeKind::CookiePut,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("in")],
            outputs: vec![url_port("out")],
            params: params(&[
                ("name", "session"),
                ("value", "expired-read"),
                ("domain", "example.local"),
                ("allowDomains", "example.local"),
                ("expires", &expired),
            ]),
        },
        Node {
            id: "cookie_get".to_string(),
            kind: NodeKind::CookieGet,
            phase: LifecyclePhase::Search,
            inputs: vec![url_port("trigger")],
            outputs: vec![text_port("out")],
            params: params(&[
                ("name", "session"),
                ("domain", "example.local"),
                ("default", "miss"),
            ]),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input_url".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cookie_put".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cookie_get".to_string(),
                port_name: "trigger".to_string(),
            },
        },
    ];
    let rule = build_rule(
        nodes,
        edges,
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "cookie_get".to_string(),
                port_name: "out".to_string(),
            },
        )]),
    );

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input_url".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Url("http://example.local/seed".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("过期 Cookie 下 CookieGet 应成功返回 default");
    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("miss".to_string()))
    );
}

#[tokio::test]
async fn rule_rate_limit_delays_repeated_fetch_and_emits_node_log() {
    let first_url = spawn_single_response_http_server("first", "text/plain; charset=utf-8");
    let second_url = spawn_single_response_http_server("second", "text/plain; charset=utf-8");

    let nodes = vec![
        Node {
            id: "fetch_a".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("result")],
            params: params(&[("method", "get"), ("response", "text"), ("url", &first_url)]),
        },
        Node {
            id: "fetch_b".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("result")],
            params: params(&[
                ("method", "get"),
                ("response", "text"),
                ("url", &second_url),
            ]),
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "fetch_b".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule_with_rate_limit(
        nodes,
        vec![],
        normalized_outputs,
        RuleRateLimit {
            count: 1,
            period_ms: 220,
        },
    );

    let started = Instant::now();
    let result = execute_rule(&rule, EngineContext::default())
        .await
        .expect("触发限速时请求应延迟而非失败");
    let elapsed = started.elapsed();

    let node_logs = result
        .events
        .iter()
        .filter_map(|event| match event {
            NodeEvent::NodeLog { message, .. } => Some(message.clone()),
            _ => None,
        })
        .collect::<Vec<_>>();
    assert!(!node_logs.is_empty(), "触发限速后应产生 NodeLog");
    assert!(
        node_logs.iter().any(|message| message.contains("延迟请求")
            && message.contains("count=1")
            && message.contains("periodMs=220")),
        "NodeLog 应包含等待时间与窗口配置"
    );
    assert!(elapsed >= Duration::from_millis(180));
}

#[tokio::test]
async fn rule_rate_limit_under_quota_has_no_delay_or_node_log() {
    let first_url = spawn_single_response_http_server("first", "text/plain; charset=utf-8");
    let second_url = spawn_single_response_http_server("second", "text/plain; charset=utf-8");

    let nodes = vec![
        Node {
            id: "fetch_a".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("result")],
            params: params(&[("method", "get"), ("response", "text"), ("url", &first_url)]),
        },
        Node {
            id: "fetch_b".to_string(),
            kind: NodeKind::Fetch,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("result")],
            params: params(&[
                ("method", "get"),
                ("response", "text"),
                ("url", &second_url),
            ]),
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "fetch_b".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule_with_rate_limit(
        nodes,
        vec![],
        normalized_outputs,
        RuleRateLimit {
            count: 3,
            period_ms: 220,
        },
    );

    let started = Instant::now();
    let result = execute_rule(&rule, EngineContext::default())
        .await
        .expect("配额内请求应正常成功");
    let elapsed = started.elapsed();

    assert!(
        !result
            .events
            .iter()
            .any(|event| matches!(event, NodeEvent::NodeLog { .. })),
        "配额内不应产生限速 NodeLog"
    );
    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("second".to_string()))
    );
    assert!(
        elapsed < Duration::from_secs(1),
        "配额内请求不应出现异常长时间阻塞，实际耗时为 {elapsed:?}"
    );
}

#[tokio::test]
async fn parse_json_and_jsonpath_select_flow_through_engine_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "parse".to_string(),
            kind: NodeKind::Parse,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![json_port("json")],
            params: params(&[("format", "json")]),
        },
        Node {
            id: "select".to_string(),
            kind: NodeKind::Select,
            phase: LifecyclePhase::Search,
            inputs: vec![json_port("in")],
            outputs: vec![list_text_port("names")],
            params: params(&[("engine", "jsonpath"), ("query", "$.items[*].name")]),
        },
        Node {
            id: "join".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![list_text_port("in")],
            outputs: vec![text_port("joined")],
            params: params(&[("family", "list"), ("op", "join"), ("separator", ",")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "parse".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "parse".to_string(),
                port_name: "json".to_string(),
            },
            to: PortRef {
                node_id: "select".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "select".to_string(),
                port_name: "names".to_string(),
            },
            to: PortRef {
                node_id: "join".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "join".to_string(),
                port_name: "joined".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text(r#"{"items":[{"name":"A"},{"name":"B"}]}"#.to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("parse + jsonpath + list.join 链路应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("A,B".to_string()))
    );
}

#[tokio::test]
async fn xpath_selector_requires_explicit_attr_and_runs_in_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![html_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "select".to_string(),
            kind: NodeKind::Select,
            phase: LifecyclePhase::Search,
            inputs: vec![html_port("in")],
            outputs: vec![list_text_port("hrefs")],
            params: params(&[
                ("engine", "xpath"),
                ("query", "//a[@class='entry']"),
                ("extract", "attr"),
                ("attr", "href"),
            ]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![list_text_port("in")],
            outputs: vec![list_text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "select".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "select".to_string(),
                port_name: "hrefs".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Html(
            r#"<div><a class="entry" href="/a">A</a><a class="entry" href="/b">B</a></div>"#
                .to_string(),
        ),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("xpath attr 选择应成功");

    assert!(matches!(
        result.final_result,
        Some(RuntimeValue::List(ref items))
        if items == &vec![
            RuntimeValue::Text("/a".to_string()),
            RuntimeValue::Text("/b".to_string())
        ]
    ));
}

#[tokio::test]
async fn regex_selector_and_text_transform_run_in_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "select".to_string(),
            kind: NodeKind::Select,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![list_text_port("matched")],
            params: params(&[
                ("engine", "regex"),
                ("query", "ID-([A-Z]+)"),
                ("group", "1"),
            ]),
        },
        Node {
            id: "first".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![list_text_port("in")],
            outputs: vec![text_port("first")],
            params: params(&[("family", "list"), ("op", "first")]),
        },
        Node {
            id: "lower".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params(&[("family", "text"), ("op", "lower")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "select".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "select".to_string(),
                port_name: "matched".to_string(),
            },
            to: PortRef {
                node_id: "first".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "first".to_string(),
                port_name: "first".to_string(),
            },
            to: PortRef {
                node_id: "lower".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "lower".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("ID-AB ID-CD".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("regex + text.lower 链路应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("ab".to_string()))
    );
}

#[tokio::test]
async fn json_transform_stringify_runs_in_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![json_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "stringify".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![json_port("in")],
            outputs: vec![text_port("text")],
            params: params(&[("family", "json"), ("op", "stringify")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "stringify".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "stringify".to_string(),
                port_name: "text".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Json(serde_json::json!({"name":"Spectra"})),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("json.stringify 链路应成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("{\"name\":\"Spectra\"}".to_string()))
    );
}

#[tokio::test]
async fn text_transform_normalize_space_runs_in_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "normalize".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params(&[("family", "text"), ("op", "normalizeSpace")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "normalize".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "normalize".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("  A\n  B\t\tC  ".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("text.normalizeSpace 应通过真实引擎路径生效");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("A B C".to_string()))
    );
}

#[tokio::test]
async fn js_transform_runs_in_sandbox_runtime_dispatch() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "js".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params(&[("family", "js"), ("script", "return input.toUpperCase();")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "js".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "js".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("spectra".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("js transform 应可在沙箱中执行");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("SPECTRA".to_string()))
    );
}

#[tokio::test]
async fn js_transform_infinite_loop_is_interrupted_with_timeout_error() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "js".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params(&[("family", "js"), ("script", "while (true) {}")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "js".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "js".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("spectra".to_string()),
    );

    let result = execute_rule(&rule, context).await;

    assert!(matches!(
        result,
        Err(EngineError::JsTimeout { ref node_id, .. }) if node_id == "js"
    ));
}

#[tokio::test]
async fn repeated_same_node_and_input_uses_run_scoped_cache_and_marks_port_emit() {
    let node = Node {
        id: "repeat".to_string(),
        kind: NodeKind::Filter,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: BTreeMap::new(),
    };
    let output_store = Arc::new(Mutex::new(HashMap::new()));
    let node_stats = Arc::new(Mutex::new(BTreeMap::new()));
    let execution_cache = Arc::new(Mutex::new(HashMap::new()));
    let context = Arc::new(EngineContext::default());
    let (event_tx, event_rx) = mpsc::channel(16);
    let collector = tokio::spawn(super::collect_events(
        "run-cache".to_string(),
        None,
        event_rx,
    ));
    let run_context = super::RunNodeContext {
        rule_ir_version: "1.0.0".to_string(),
        context,
        output_store,
        node_stats,
        execution_cache,
        http_client: Arc::new(wreq::Client::new()),
        kv_store: Arc::new(super::RuntimeKvStore::from_persisted_json(None)),
        cookie_jar: Arc::new(super::RuntimeCookieJar::from_persisted_json(None)),
        rate_limiter: None,
        event_tx: event_tx.clone(),
    };

    super::run_node(
        runtime_node_with_single_input(node.clone(), RuntimeValue::Text("spectra".to_string())),
        run_context.clone(),
    )
    .await
    .expect("首次执行应成功");

    super::run_node(
        runtime_node_with_single_input(node, RuntimeValue::Text("spectra".to_string())),
        run_context,
    )
    .await
    .expect("相同输入的二次执行应命中缓存");

    drop(event_tx);
    let events = collector.await.expect("事件收集任务应成功结束");

    let cache_hits = events
        .iter()
        .filter_map(|event| match event {
            NodeEvent::PortEmit {
                node_id, cache_hit, ..
            } if node_id == "repeat" => Some(*cache_hit),
            _ => None,
        })
        .collect::<Vec<_>>();

    assert_eq!(cache_hits, vec![false, true]);
    assert!(
        events
            .windows(2)
            .all(|pair| event_seq(&pair[1]) > event_seq(&pair[0]))
    );
}

#[tokio::test]
async fn first_execution_and_changed_input_do_not_mark_cache_hit() {
    let node = Node {
        id: "repeat".to_string(),
        kind: NodeKind::Filter,
        phase: LifecyclePhase::Search,
        inputs: vec![text_port("in")],
        outputs: vec![text_port("out")],
        params: BTreeMap::new(),
    };
    let output_store = Arc::new(Mutex::new(HashMap::new()));
    let node_stats = Arc::new(Mutex::new(BTreeMap::new()));
    let execution_cache = Arc::new(Mutex::new(HashMap::new()));
    let context = Arc::new(EngineContext::default());
    let (event_tx, event_rx) = mpsc::channel(16);
    let collector = tokio::spawn(super::collect_events(
        "run-cache-different-input".to_string(),
        None,
        event_rx,
    ));
    let run_context = super::RunNodeContext {
        rule_ir_version: "1.0.0".to_string(),
        context,
        output_store,
        node_stats,
        execution_cache,
        http_client: Arc::new(wreq::Client::new()),
        kv_store: Arc::new(super::RuntimeKvStore::from_persisted_json(None)),
        cookie_jar: Arc::new(super::RuntimeCookieJar::from_persisted_json(None)),
        rate_limiter: None,
        event_tx: event_tx.clone(),
    };

    super::run_node(
        runtime_node_with_single_input(node.clone(), RuntimeValue::Text("spectra-a".to_string())),
        run_context.clone(),
    )
    .await
    .expect("首次执行应成功");

    super::run_node(
        runtime_node_with_single_input(node, RuntimeValue::Text("spectra-b".to_string())),
        run_context,
    )
    .await
    .expect("不同输入的执行不应因缓存失败");

    drop(event_tx);
    let events = collector.await.expect("事件收集任务应成功结束");

    let cache_hits = events
        .iter()
        .filter_map(|event| match event {
            NodeEvent::PortEmit {
                node_id, cache_hit, ..
            } if node_id == "repeat" => Some(*cache_hit),
            _ => None,
        })
        .collect::<Vec<_>>();

    assert_eq!(cache_hits, vec![false, false]);
}

#[tokio::test]
async fn cache_put_and_cache_get_share_run_scope_in_single_execution() {
    let nodes = vec![
        Node {
            id: "input".to_string(),
            kind: NodeKind::Input,
            phase: LifecyclePhase::Search,
            inputs: vec![],
            outputs: vec![text_port("out")],
            params: BTreeMap::new(),
        },
        Node {
            id: "cache_put".to_string(),
            kind: NodeKind::CachePut,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params(&[("key", "shared_key"), ("scope", "run")]),
        },
        Node {
            id: "cache_get".to_string(),
            kind: NodeKind::CacheGet,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("trigger")],
            outputs: vec![text_port("out")],
            params: params(&[("key", "shared_key"), ("scope", "run")]),
        },
        Node {
            id: "sink".to_string(),
            kind: NodeKind::Output,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("result")],
            params: BTreeMap::new(),
        },
    ];
    let edges = vec![
        Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cache_put".to_string(),
                port_name: "in".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cache_put".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cache_get".to_string(),
                port_name: "trigger".to_string(),
            },
        },
        Edge {
            from: PortRef {
                node_id: "cache_get".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "sink".to_string(),
                port_name: "in".to_string(),
            },
        },
    ];
    let mut normalized_outputs = BTreeMap::new();
    normalized_outputs.insert(
        LifecyclePhase::Search,
        PortRef {
            node_id: "sink".to_string(),
            port_name: "result".to_string(),
        },
    );
    let rule = build_rule(nodes, edges, normalized_outputs);

    let mut context = EngineContext::default();
    context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("run-value".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("run scope 缓存链路应执行成功");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("run-value".to_string()))
    );
    assert!(
        result.events.iter().any(|event| {
            matches!(
                event,
                NodeEvent::NodeLog { node_id, message, .. }
                if node_id == "cache_get" && message.contains("缓存命中")
            )
        }),
        "CacheGet 命中时应产生 NodeLog"
    );
}

#[tokio::test]
async fn cache_rule_scope_hits_in_second_execution_with_persisted_snapshot() {
    let put_rule = build_rule(
        vec![
            Node {
                id: "input".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cache_put".to_string(),
                kind: NodeKind::CachePut,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("out")],
                params: params(&[("key", "persisted_key"), ("scope", "rule")]),
            },
        ],
        vec![Edge {
            from: PortRef {
                node_id: "input".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cache_put".to_string(),
                port_name: "in".to_string(),
            },
        }],
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "cache_put".to_string(),
                port_name: "out".to_string(),
            },
        )]),
    );

    let mut first_context = EngineContext::default();
    first_context.port_inputs.insert(
        PortRef {
            node_id: "input".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("rule-value".to_string()),
    );
    let first_result = execute_rule(&put_rule, first_context)
        .await
        .expect("首次 rule scope 写入应成功");
    let persisted = first_result
        .rule_kv_json
        .clone()
        .expect("写入 rule scope 后应产出快照");

    let get_rule = build_rule(
        vec![
            Node {
                id: "trigger".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cache_get".to_string(),
                kind: NodeKind::CacheGet,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("trigger")],
                outputs: vec![text_port("out")],
                params: params(&[
                    ("key", "persisted_key"),
                    ("scope", "rule"),
                    ("default", "miss-default"),
                ]),
            },
            Node {
                id: "sink".to_string(),
                kind: NodeKind::Output,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("in")],
                outputs: vec![text_port("result")],
                params: BTreeMap::new(),
            },
        ],
        vec![
            Edge {
                from: PortRef {
                    node_id: "trigger".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "trigger".to_string(),
                },
            },
            Edge {
                from: PortRef {
                    node_id: "cache_get".to_string(),
                    port_name: "out".to_string(),
                },
                to: PortRef {
                    node_id: "sink".to_string(),
                    port_name: "in".to_string(),
                },
            },
        ],
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "sink".to_string(),
                port_name: "result".to_string(),
            },
        )]),
    );

    let mut second_context = EngineContext {
        persisted_rule_kv_json: Some(persisted),
        ..EngineContext::default()
    };
    second_context.port_inputs.insert(
        PortRef {
            node_id: "trigger".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("go".to_string()),
    );
    let second_result = execute_rule(&get_rule, second_context)
        .await
        .expect("二次执行应读取到 rule scope 缓存");

    assert_eq!(
        second_result.final_result,
        Some(RuntimeValue::Text("rule-value".to_string()))
    );
    assert!(
        second_result.events.iter().any(|event| {
            matches!(
                event,
                NodeEvent::NodeLog { node_id, message, .. }
                    if node_id == "cache_get" && message.contains("缓存命中")
            )
        }),
        "rule scope 命中应产生 NodeLog"
    );
}

#[tokio::test]
async fn cache_rule_scope_reload_from_snapshot_after_simulated_restart() {
    let persisted_value = serde_json::to_string(&HashMap::from([(
        "restart_key".to_string(),
        serde_json::json!({
            "type": "text",
            "value": "restart-value"
        }),
    )]))
    .expect("测试快照 JSON 序列化应成功");

    let rule = build_rule(
        vec![
            Node {
                id: "trigger".to_string(),
                kind: NodeKind::Input,
                phase: LifecyclePhase::Search,
                inputs: vec![],
                outputs: vec![text_port("out")],
                params: BTreeMap::new(),
            },
            Node {
                id: "cache_get".to_string(),
                kind: NodeKind::CacheGet,
                phase: LifecyclePhase::Search,
                inputs: vec![text_port("trigger")],
                outputs: vec![text_port("out")],
                params: params(&[
                    ("key", "restart_key"),
                    ("scope", "rule"),
                    ("default", "fallback"),
                ]),
            },
        ],
        vec![Edge {
            from: PortRef {
                node_id: "trigger".to_string(),
                port_name: "out".to_string(),
            },
            to: PortRef {
                node_id: "cache_get".to_string(),
                port_name: "trigger".to_string(),
            },
        }],
        BTreeMap::from([(
            LifecyclePhase::Search,
            PortRef {
                node_id: "cache_get".to_string(),
                port_name: "out".to_string(),
            },
        )]),
    );

    let mut context = EngineContext {
        persisted_rule_kv_json: Some(persisted_value),
        ..EngineContext::default()
    };
    context.port_inputs.insert(
        PortRef {
            node_id: "trigger".to_string(),
            port_name: "out".to_string(),
        },
        RuntimeValue::Text("go".to_string()),
    );

    let result = execute_rule(&rule, context)
        .await
        .expect("重启后加载快照应可命中 rule scope 缓存");

    assert_eq!(
        result.final_result,
        Some(RuntimeValue::Text("restart-value".to_string()))
    );
}

#[test]
fn truncate_utf8_keeps_nearest_valid_boundary_for_multibyte() {
    let value = format!("{}你", "a".repeat(1022));

    let (truncated, is_truncated) = super::truncate_utf8(value, 1024);

    assert!(is_truncated);
    assert_eq!(truncated.len(), 1022);
    assert_eq!(truncated, "a".repeat(1022));
    assert!(std::str::from_utf8(truncated.as_bytes()).is_ok());
}

fn event_seq(event: &crate::rules_ir::NodeEvent) -> u64 {
    match event {
        crate::rules_ir::NodeEvent::RunStarted { seq, .. }
        | crate::rules_ir::NodeEvent::NodeStarted { seq, .. }
        | crate::rules_ir::NodeEvent::PortEmit { seq, .. }
        | crate::rules_ir::NodeEvent::NodeLog { seq, .. }
        | crate::rules_ir::NodeEvent::NodeError { seq, .. }
        | crate::rules_ir::NodeEvent::NodeFinished { seq, .. }
        | crate::rules_ir::NodeEvent::RunFinished { seq, .. } => *seq,
    }
}
