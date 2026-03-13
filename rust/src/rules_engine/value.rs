use std::collections::BTreeMap;

use serde_json::{Value as JsonValue, json};

use crate::rules_ir::{DataType, NormalizedModel};

/// 运行时负载值。
#[derive(Debug, Clone, PartialEq)]
pub enum RuntimeValue {
    Text(String),
    Html(String),
    Json(JsonValue),
    Url(String),
    List(Vec<RuntimeValue>),
    Record(BTreeMap<String, RuntimeValue>),
    NormalizedModel(Box<NormalizedModel>),
}

pub(crate) fn runtime_values_hash_repr(inputs: &BTreeMap<String, Vec<RuntimeValue>>) -> JsonValue {
    json!(
        inputs
            .iter()
            .map(|(port_name, values)| {
                (
                    port_name.clone(),
                    values
                        .iter()
                        .map(runtime_value_hash_repr)
                        .collect::<Vec<_>>(),
                )
            })
            .collect::<BTreeMap<_, _>>()
    )
}

pub(crate) fn stable_input_hash(inputs: &BTreeMap<String, Vec<RuntimeValue>>) -> Option<String> {
    let payload = serde_json::to_string(&runtime_values_hash_repr(inputs)).ok()?;
    Some(stable_hash_hex(payload.as_bytes()))
}

fn stable_hash_hex(bytes: &[u8]) -> String {
    const FNV_OFFSET_BASIS: u64 = 0xcbf29ce484222325;
    const FNV_PRIME: u64 = 0x100000001b3;

    let mut hash = FNV_OFFSET_BASIS;
    for byte in bytes {
        hash ^= u64::from(*byte);
        hash = hash.wrapping_mul(FNV_PRIME);
    }

    format!("{hash:016x}")
}

pub(crate) fn runtime_value_hash_repr(value: &RuntimeValue) -> JsonValue {
    match value {
        RuntimeValue::Text(value) => json!({ "type": "text", "value": value }),
        RuntimeValue::Html(value) => json!({ "type": "html", "value": value }),
        RuntimeValue::Json(value) => json!({ "type": "json", "value": value }),
        RuntimeValue::Url(value) => json!({ "type": "url", "value": value }),
        RuntimeValue::List(values) => json!({
            "type": "list",
            "items": values.iter().map(runtime_value_hash_repr).collect::<Vec<_>>(),
        }),
        RuntimeValue::Record(fields) => json!({
            "type": "record",
            "fields": fields
                .iter()
                .map(|(key, value)| (key.clone(), runtime_value_hash_repr(value)))
                .collect::<BTreeMap<_, _>>(),
        }),
        RuntimeValue::NormalizedModel(model) => {
            json!({ "type": "normalizedModel", "value": model })
        }
    }
}

pub(crate) fn runtime_value_from_repr(value: &JsonValue) -> Option<RuntimeValue> {
    let JsonValue::Object(map) = value else {
        return None;
    };

    let kind = map.get("type")?.as_str()?;
    match kind {
        "text" => Some(RuntimeValue::Text(map.get("value")?.as_str()?.to_string())),
        "html" => Some(RuntimeValue::Html(map.get("value")?.as_str()?.to_string())),
        "url" => Some(RuntimeValue::Url(map.get("value")?.as_str()?.to_string())),
        "json" => Some(RuntimeValue::Json(map.get("value")?.clone())),
        "list" => {
            let items = map
                .get("items")?
                .as_array()?
                .iter()
                .filter_map(runtime_value_from_repr)
                .collect::<Vec<_>>();
            Some(RuntimeValue::List(items))
        }
        "record" => {
            let fields = map
                .get("fields")?
                .as_object()?
                .iter()
                .filter_map(|(key, value)| {
                    runtime_value_from_repr(value).map(|runtime| (key.clone(), runtime))
                })
                .collect::<BTreeMap<_, _>>();
            Some(RuntimeValue::Record(fields))
        }
        "normalizedModel" => serde_json::from_value::<NormalizedModel>(map.get("value")?.clone())
            .ok()
            .map(|model| RuntimeValue::NormalizedModel(Box::new(model))),
        _ => None,
    }
}

impl RuntimeValue {
    pub(crate) fn matches_type(&self, data_type: &DataType) -> bool {
        match (self, data_type) {
            (Self::Text(_), DataType::Text) => true,
            (Self::Html(_), DataType::Html) => true,
            (Self::Json(_), DataType::Json) => true,
            (Self::Url(_), DataType::Url) => true,
            (Self::NormalizedModel(_), DataType::NormalizedModel) => true,
            (Self::List(items), DataType::List { item }) => {
                items.iter().all(|value| value.matches_type(item))
            }
            (Self::Record(fields), DataType::Record { fields: expected }) => {
                expected.iter().all(|field| {
                    fields
                        .get(&field.name)
                        .map(|value| value.matches_type(&field.data_type))
                        .unwrap_or(field.optional)
                })
            }
            _ => false,
        }
    }

    pub(crate) fn type_label(&self) -> &'static str {
        match self {
            Self::Text(_) => "text",
            Self::Html(_) => "html",
            Self::Json(_) => "json",
            Self::Url(_) => "url",
            Self::List(_) => "list",
            Self::Record(_) => "record",
            Self::NormalizedModel(_) => "normalizedModel",
        }
    }
}

impl serde::Serialize for RuntimeValue {
    fn serialize<S>(&self, serializer: S) -> Result<S::Ok, S::Error>
    where
        S: serde::Serializer,
    {
        match self {
            Self::Text(value) | Self::Html(value) | Self::Url(value) => {
                serializer.serialize_str(value)
            }
            Self::Json(value) => value.serialize(serializer),
            Self::List(values) => values.serialize(serializer),
            Self::Record(fields) => fields.serialize(serializer),
            Self::NormalizedModel(model) => model.serialize(serializer),
        }
    }
}
