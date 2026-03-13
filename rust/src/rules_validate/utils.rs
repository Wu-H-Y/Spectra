use super::types::PortDirection;
use crate::rules_ir::{DataType, Diagnostic, DiagnosticSeverity, LifecyclePhase};

pub(crate) fn data_type_compatible(from: &DataType, to: &DataType) -> bool {
    from == to
}

pub(crate) fn is_normalized_output_type(data_type: &DataType) -> bool {
    match data_type {
        DataType::NormalizedModel => true,
        DataType::List { item } => matches!(item.as_ref(), DataType::NormalizedModel),
        _ => false,
    }
}

pub(crate) fn data_type_label(data_type: &DataType) -> String {
    match data_type {
        DataType::Text => "text".to_string(),
        DataType::Html => "html".to_string(),
        DataType::Json => "json".to_string(),
        DataType::Url => "url".to_string(),
        DataType::List { item } => format!("list<{}>", data_type_label(item)),
        DataType::Record { fields } => {
            let labels = fields
                .iter()
                .map(|field| format!("{}:{}", field.name, data_type_label(&field.data_type)))
                .collect::<Vec<_>>()
                .join(", ");
            format!("record{{{labels}}}")
        }
        DataType::NormalizedModel => "normalizedModel".to_string(),
    }
}

pub(crate) fn port_direction_label(direction: PortDirection) -> &'static str {
    match direction {
        PortDirection::Input => "输入",
        PortDirection::Output => "输出",
    }
}

pub(crate) fn phase_key(phase: LifecyclePhase) -> &'static str {
    match phase {
        LifecyclePhase::Explore => "explore",
        LifecyclePhase::Search => "search",
        LifecyclePhase::Detail => "detail",
        LifecyclePhase::Toc => "toc",
        LifecyclePhase::Content => "content",
    }
}

pub(crate) fn normalize_param_value(value: &str) -> String {
    value.trim().to_ascii_lowercase()
}

pub(crate) fn normalize_cookie_domain(value: &str) -> String {
    value
        .trim()
        .to_ascii_lowercase()
        .trim_start_matches('.')
        .to_string()
}

pub(crate) fn diagnostic(
    code: &str,
    path: String,
    node_id: Option<String>,
    message: String,
) -> Diagnostic {
    Diagnostic {
        code: code.to_string(),
        severity: DiagnosticSeverity::Error,
        path: Some(path),
        node_id,
        message,
    }
}
