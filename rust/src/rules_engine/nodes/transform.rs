use std::{
    collections::BTreeMap,
    sync::{
        atomic::{AtomicBool, Ordering},
        Arc,
    },
    time::{Duration, Instant},
};

use aes::{
    cipher::{block_padding::Pkcs7, BlockDecryptMut, BlockEncryptMut, KeyInit, KeyIvInit},
    Aes128, Aes192, Aes256,
};
use base64::{engine::general_purpose::STANDARD as BASE64_STANDARD, Engine as _};
use cbc::{Decryptor as AesCbcDecryptor, Encryptor as AesCbcEncryptor};
use chrono::{DateTime, Utc};
use ecb::{Decryptor as AesEcbDecryptor, Encryptor as AesEcbEncryptor};
use encoding_rs::GBK;
use percent_encoding::{utf8_percent_encode, AsciiSet, CONTROLS};
use rquickjs::{context::intrinsic, Context, Ctx, Runtime};
use url::Url;

use super::{
    map_single_value_to_outputs, node_failure, normalize_param_value, optional_param,
    primary_input_value, reject_unknown_params, required_param,
};
use crate::{
    rules_engine::{EngineError, RuntimeValue},
    rules_ir::{KeyRef, KeyRefProvider, Node},
};

const JS_TIMEOUT_MS: u64 = 100;
const JS_MEMORY_LIMIT_BYTES: usize = 8 * 1024 * 1024;
const JS_MAX_STACK_BYTES: usize = 512 * 1024;
const AES_BLOCK_SIZE: usize = 16;
const ENCODE_URI_ASCII_SET: &AsciiSet = &CONTROLS
    .add(b' ')
    .add(b'"')
    .add(b'<')
    .add(b'>')
    .add(b'\\')
    .add(b'^')
    .add(b'`')
    .add(b'{')
    .add(b'|')
    .add(b'}');

#[derive(Debug, Clone, Copy)]
enum AesTransformation {
    CbcPkcs7,
    EcbPkcs7,
}

#[derive(Debug, Clone, Copy)]
enum AesOperation {
    Encode,
    Decode,
}

pub(crate) fn execute(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    reject_unknown_params(
        node,
        &[
            "base",
            "family",
            "iv",
            "ivRef",
            "key",
            "keyRef",
            "op",
            "pattern",
            "replacement",
            "script",
            "separator",
            "transformation",
        ],
    )?;

    let family = normalize_param_value(required_param(node, "family")?);
    match family.as_str() {
        "text" => execute_text(node, inputs),
        "list" => execute_list(node, inputs),
        "json" => execute_json(node, inputs),
        "convert" => execute_convert(node, inputs),
        "url" => execute_url(node, inputs),
        "js" => execute_js(node, inputs),
        "codec" => execute_codec(node, inputs),
        "crypto" => execute_crypto(node, inputs),
        other => Err(node_failure(
            node,
            format!("不支持 family=`{other}`，仅支持 text/list/json/convert/url/js/codec/crypto"),
        )),
    }
}

fn execute_codec(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let input_text = runtime_value_to_text(node, input)?;
    let op = normalize_param_value(required_param(node, "op")?);

    let value = match op.as_str() {
        "base64encode" => RuntimeValue::Text(BASE64_STANDARD.encode(input_text.as_bytes())),
        "base64decode" => {
            let bytes = BASE64_STANDARD
                .decode(input_text.as_bytes())
                .map_err(|error| node_failure(node, format!("Base64 解码失败：{error}")))?;
            RuntimeValue::Text(String::from_utf8(bytes).map_err(|error| {
                node_failure(node, format!("Base64 解码结果不是合法 UTF-8 文本：{error}"))
            })?)
        }
        "md532" => RuntimeValue::Text(format!("{:x}", md5::compute(input_text.as_bytes()))),
        "md516" => {
            let digest = format!("{:x}", md5::compute(input_text.as_bytes()));
            RuntimeValue::Text(digest[8..24].to_string())
        }
        "encodeuri" => {
            RuntimeValue::Text(utf8_percent_encode(&input_text, ENCODE_URI_ASCII_SET).to_string())
        }
        "utf8togbk" => {
            let (encoded, _, had_errors) = GBK.encode(&input_text);
            if had_errors {
                return Err(node_failure(node, "utf8ToGbk 转码失败，存在无法编码字符"));
            }
            let mut output = String::new();
            for byte in encoded.as_ref() {
                output.push_str(format!("%{byte:02X}").as_str());
            }
            RuntimeValue::Text(output)
        }
        "htmlformat" => RuntimeValue::Text(format_html_text(&input_text)),
        "timeformat" => {
            let pattern = optional_param(node, "pattern").unwrap_or("%Y-%m-%d %H:%M:%S");
            RuntimeValue::Text(format_time_text(node, &input_text, pattern)?)
        }
        other => {
            return Err(node_failure(
                node,
                format!(
                    "codec family 不支持 op=`{other}`，仅支持 base64Encode/base64Decode/md532/md516/encodeURI/utf8ToGbk/htmlFormat/timeFormat"
                ),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn execute_crypto(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let input_text = runtime_value_to_text(node, input)?;
    let op = normalize_param_value(required_param(node, "op")?);
    let (operation, transformation) = parse_aes_operation_and_transformation(node, &op)?;
    let key = resolve_secret_value(node, "key", "keyRef")?;
    let iv = resolve_secret_value_optional(node, "iv", "ivRef")?;

    let key_bytes = key.as_bytes().to_vec();
    let iv_bytes = iv.map(|value| value.into_bytes());

    let value = match operation {
        AesOperation::Encode => {
            let encrypted = aes_encrypt(
                node,
                transformation,
                input_text.as_bytes(),
                &key_bytes,
                iv_bytes.as_deref(),
            )?;
            RuntimeValue::Text(BASE64_STANDARD.encode(encrypted))
        }
        AesOperation::Decode => {
            let bytes = BASE64_STANDARD
                .decode(input_text.as_bytes())
                .map_err(|error| {
                    node_failure(node, format!("AES 输入密文不是合法 Base64：{error}"))
                })?;
            let decrypted = aes_decrypt(node, transformation, &bytes, &key_bytes, iv_bytes.as_deref())?;
            RuntimeValue::Text(String::from_utf8(decrypted).map_err(|error| {
                node_failure(node, format!("AES 解密结果不是合法 UTF-8 文本：{error}"))
            })?)
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn parse_aes_transformation(value: &str) -> Option<AesTransformation> {
    let normalized = normalize_param_value(value).replace([' ', '_'], "");
    match normalized.as_str() {
        "aes/cbc/pkcs7padding" | "aes/cbc/pkcs7" => Some(AesTransformation::CbcPkcs7),
        "aes/ecb/pkcs7padding" | "aes/ecb/pkcs7" => Some(AesTransformation::EcbPkcs7),
        _ => None,
    }
}

fn parse_aes_operation_and_transformation(
    node: &Node,
    op: &str,
) -> Result<(AesOperation, AesTransformation), EngineError> {
    match op {
        "aesencode" => Ok((
            AesOperation::Encode,
            parse_aes_transformation(
                optional_param(node, "transformation").unwrap_or("AES/CBC/PKCS7Padding"),
            )
            .ok_or_else(|| {
                node_failure(
                    node,
                    "AES transformation 不支持，当前仅支持 AES/CBC/PKCS7Padding 与 AES/ECB/PKCS7Padding",
                )
            })?,
        )),
        "aesdecode" => Ok((
            AesOperation::Decode,
            parse_aes_transformation(
                optional_param(node, "transformation").unwrap_or("AES/CBC/PKCS7Padding"),
            )
            .ok_or_else(|| {
                node_failure(
                    node,
                    "AES transformation 不支持，当前仅支持 AES/CBC/PKCS7Padding 与 AES/ECB/PKCS7Padding",
                )
            })?,
        )),
        "aescbcencode" => Ok((AesOperation::Encode, AesTransformation::CbcPkcs7)),
        "aescbcdecode" => Ok((AesOperation::Decode, AesTransformation::CbcPkcs7)),
        "aesecbencode" => Ok((AesOperation::Encode, AesTransformation::EcbPkcs7)),
        "aesecbdecode" => Ok((AesOperation::Decode, AesTransformation::EcbPkcs7)),
        other => Err(node_failure(
            node,
            format!(
                "crypto family 不支持 op=`{other}`，仅支持 aesEncode/aesDecode/aesCbcEncode/aesCbcDecode/aesEcbEncode/aesEcbDecode"
            ),
        )),
    }
}

fn resolve_secret_value(
    node: &Node,
    inline_param: &str,
    key_ref_param: &str,
) -> Result<String, EngineError> {
    if let Some(value) = resolve_secret_value_optional(node, inline_param, key_ref_param)? {
        return Ok(value);
    }

    Err(node_failure(
        node,
        format!("缺少 `{inline_param}` 或 `{key_ref_param}` 参数"),
    ))
}

fn resolve_secret_value_optional(
    node: &Node,
    inline_param: &str,
    key_ref_param: &str,
) -> Result<Option<String>, EngineError> {
    if let Some(inline) = optional_param(node, inline_param)
        && !inline.trim().is_empty()
    {
        return Ok(Some(inline.to_string()));
    }

    let Some(raw_ref) = optional_param(node, key_ref_param) else {
        return Ok(None);
    };
    if raw_ref.trim().is_empty() {
        return Ok(None);
    }

    let key_ref = serde_json::from_str::<KeyRef>(raw_ref).map_err(|error| {
        node_failure(
            node,
            format!("{key_ref_param} 不是合法 KeyRef JSON：{error}"),
        )
    })?;
    let value = match key_ref.provider {
        KeyRefProvider::Inline => {
            let inline = key_ref.value.as_deref().unwrap_or_default().trim();
            if inline.is_empty() {
                return Err(node_failure(node, format!("{key_ref_param}.value 不能为空")));
            }
            inline.to_string()
        }
        KeyRefProvider::Variable => {
            let name = key_ref.name.as_deref().unwrap_or_default().trim();
            if name.is_empty() {
                return Err(node_failure(node, format!("{key_ref_param}.name 不能为空")));
            }
            std::env::var(name).map_err(|_| {
                node_failure(node, format!("环境变量 `{name}` 未设置，无法解析 {key_ref_param}"))
            })?
        }
        KeyRefProvider::SecureStore => {
            return Err(node_failure(
                node,
                "provider=secureStore 尚未接入实际适配器，请先配置 secure-store 运行时后再使用",
            ));
        }
    };

    Ok(Some(value))
}

fn aes_encrypt(
    node: &Node,
    transformation: AesTransformation,
    plaintext: &[u8],
    key: &[u8],
    iv: Option<&[u8]>,
) -> Result<Vec<u8>, EngineError> {
    match transformation {
        AesTransformation::CbcPkcs7 => {
            let iv = require_aes_iv(node, iv)?;
            match key.len() {
                16 => encrypt_cbc::<Aes128>(node, key, iv, plaintext),
                24 => encrypt_cbc::<Aes192>(node, key, iv, plaintext),
                32 => encrypt_cbc::<Aes256>(node, key, iv, plaintext),
                _ => Err(node_failure(node, "AES key 长度必须为 16/24/32 字节")),
            }
        }
        AesTransformation::EcbPkcs7 => match key.len() {
            16 => encrypt_ecb::<Aes128>(node, key, plaintext),
            24 => encrypt_ecb::<Aes192>(node, key, plaintext),
            32 => encrypt_ecb::<Aes256>(node, key, plaintext),
            _ => Err(node_failure(node, "AES key 长度必须为 16/24/32 字节")),
        },
    }
}

fn aes_decrypt(
    node: &Node,
    transformation: AesTransformation,
    ciphertext: &[u8],
    key: &[u8],
    iv: Option<&[u8]>,
) -> Result<Vec<u8>, EngineError> {
    match transformation {
        AesTransformation::CbcPkcs7 => {
            let iv = require_aes_iv(node, iv)?;
            match key.len() {
                16 => decrypt_cbc::<Aes128>(node, key, iv, ciphertext),
                24 => decrypt_cbc::<Aes192>(node, key, iv, ciphertext),
                32 => decrypt_cbc::<Aes256>(node, key, iv, ciphertext),
                _ => Err(node_failure(node, "AES key 长度必须为 16/24/32 字节")),
            }
        }
        AesTransformation::EcbPkcs7 => match key.len() {
            16 => decrypt_ecb::<Aes128>(node, key, ciphertext),
            24 => decrypt_ecb::<Aes192>(node, key, ciphertext),
            32 => decrypt_ecb::<Aes256>(node, key, ciphertext),
            _ => Err(node_failure(node, "AES key 长度必须为 16/24/32 字节")),
        },
    }
}

fn require_aes_iv<'a>(node: &Node, iv: Option<&'a [u8]>) -> Result<&'a [u8], EngineError> {
    let Some(iv) = iv else {
        return Err(node_failure(node, "当前 AES transformation 需要 iv 参数"));
    };
    if iv.len() != AES_BLOCK_SIZE {
        return Err(node_failure(node, "AES iv 长度必须为 16 字节"));
    }
    Ok(iv)
}

fn encrypt_cbc<Cipher>(
    node: &Node,
    key: &[u8],
    iv: &[u8],
    plaintext: &[u8],
) -> Result<Vec<u8>, EngineError>
where
    Cipher: KeyInit + aes::cipher::BlockCipher + aes::cipher::BlockEncrypt,
{
    let cipher = AesCbcEncryptor::<Cipher>::new_from_slices(key, iv)
        .map_err(|error| node_failure(node, format!("AES/CBC 初始化失败：{error}")))?;
    let mut buffer = plaintext.to_vec();
    let padded_size = ((buffer.len() / AES_BLOCK_SIZE) + 1) * AES_BLOCK_SIZE;
    buffer.resize(padded_size, 0);
    let encrypted = cipher
        .encrypt_padded_mut::<Pkcs7>(&mut buffer, plaintext.len())
        .map_err(|error| node_failure(node, format!("AES/CBC 加密失败：{error}")))?;
    Ok(encrypted.to_vec())
}

fn decrypt_cbc<Cipher>(
    node: &Node,
    key: &[u8],
    iv: &[u8],
    ciphertext: &[u8],
) -> Result<Vec<u8>, EngineError>
where
    Cipher: KeyInit + aes::cipher::BlockCipher + aes::cipher::BlockDecrypt,
{
    let cipher = AesCbcDecryptor::<Cipher>::new_from_slices(key, iv)
        .map_err(|error| node_failure(node, format!("AES/CBC 初始化失败：{error}")))?;
    let mut buffer = ciphertext.to_vec();
    let decrypted = cipher
        .decrypt_padded_mut::<Pkcs7>(&mut buffer)
        .map_err(|error| node_failure(node, format!("AES/CBC 解密失败：{error}")))?;
    Ok(decrypted.to_vec())
}

fn encrypt_ecb<Cipher>(node: &Node, key: &[u8], plaintext: &[u8]) -> Result<Vec<u8>, EngineError>
where
    Cipher: KeyInit + aes::cipher::BlockCipher + aes::cipher::BlockEncrypt,
{
    let cipher = AesEcbEncryptor::<Cipher>::new_from_slice(key)
        .map_err(|error| node_failure(node, format!("AES/ECB 初始化失败：{error}")))?;
    let mut buffer = plaintext.to_vec();
    let padded_size = ((buffer.len() / AES_BLOCK_SIZE) + 1) * AES_BLOCK_SIZE;
    buffer.resize(padded_size, 0);
    let encrypted = cipher
        .encrypt_padded_mut::<Pkcs7>(&mut buffer, plaintext.len())
        .map_err(|error| node_failure(node, format!("AES/ECB 加密失败：{error}")))?;
    Ok(encrypted.to_vec())
}

fn decrypt_ecb<Cipher>(node: &Node, key: &[u8], ciphertext: &[u8]) -> Result<Vec<u8>, EngineError>
where
    Cipher: KeyInit + aes::cipher::BlockCipher + aes::cipher::BlockDecrypt,
{
    let cipher = AesEcbDecryptor::<Cipher>::new_from_slice(key)
        .map_err(|error| node_failure(node, format!("AES/ECB 初始化失败：{error}")))?;
    let mut buffer = ciphertext.to_vec();
    let decrypted = cipher
        .decrypt_padded_mut::<Pkcs7>(&mut buffer)
        .map_err(|error| node_failure(node, format!("AES/ECB 解密失败：{error}")))?;
    Ok(decrypted.to_vec())
}

fn format_time_text(node: &Node, input_text: &str, pattern: &str) -> Result<String, EngineError> {
    let input = input_text.trim();
    if input.is_empty() {
        return Err(node_failure(node, "timeFormat 输入不能为空"));
    }

    let datetime = if let Ok(value) = input.parse::<i64>() {
        let (seconds, nanos) = if value.unsigned_abs() >= 1_000_000_000_000 {
            (
                value / 1_000,
                (value.rem_euclid(1_000) as u32).saturating_mul(1_000_000),
            )
        } else {
            (value, 0)
        };
        DateTime::<Utc>::from_timestamp(seconds, nanos)
    } else {
        DateTime::parse_from_rfc3339(input)
            .ok()
            .map(|value| value.with_timezone(&Utc))
    }
    .ok_or_else(|| {
        node_failure(
            node,
            "timeFormat 输入必须是 Unix 秒/毫秒时间戳，或 RFC3339 时间文本",
        )
    })?;

    Ok(datetime.format(pattern).to_string())
}

fn format_html_text(input: &str) -> String {
    let mut lines = Vec::new();
    let mut previous_blank = false;

    for line in input.replace("\r\n", "\n").lines() {
        let trimmed = line.trim();
        if trimmed.is_empty() {
            if !previous_blank {
                lines.push(String::new());
            }
            previous_blank = true;
            continue;
        }

        previous_blank = false;
        lines.push(trimmed.to_string());
    }

    lines.join("\n")
}

fn execute_js(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let input_text = runtime_value_to_text(node, input)?;
    let script = required_param(node, "script")?;

    let value = execute_js_script(node, script, &input_text)?;
    Ok(map_single_value_to_outputs(node, value))
}

fn execute_js_script(node: &Node, script: &str, input: &str) -> Result<RuntimeValue, EngineError> {
    let runtime = Runtime::new()
        .map_err(|error| node_failure(node, format!("JS 运行时初始化失败：{error}")))?;
    runtime.set_memory_limit(JS_MEMORY_LIMIT_BYTES);
    runtime.set_max_stack_size(JS_MAX_STACK_BYTES);

    let timeout = Duration::from_millis(JS_TIMEOUT_MS);
    let started_at = Instant::now();
    let interrupted = Arc::new(AtomicBool::new(false));
    let interrupted_for_handler = interrupted.clone();
    runtime.set_interrupt_handler(Some(Box::new(move || {
        let should_interrupt = started_at.elapsed() >= timeout;
        if should_interrupt {
            interrupted_for_handler.store(true, Ordering::Relaxed);
        }
        should_interrupt
    })));

    let context = Context::builder()
        .with::<intrinsic::Eval>()
        .build(&runtime)
        .map_err(|error| node_failure(node, format!("JS 上下文初始化失败：{error}")))?;
    let wrapped = format!(
        "(function(input){{\n\"use strict\";\n{script}\n}})({input_json})",
        input_json = serde_json::to_string(input)
            .map_err(|error| node_failure(node, format!("JS 输入序列化失败：{error}")))?
    );

    let eval_result = context
        .with(|ctx: Ctx<'_>| -> Result<String, rquickjs::Error> { ctx.eval(wrapped.as_str()) });
    runtime.set_interrupt_handler(None);

    if interrupted.load(Ordering::Relaxed) {
        return Err(EngineError::JsTimeout {
            node_id: node.id.clone(),
            message: format!("JS 执行超时（>{}ms），脚本已被中断", JS_TIMEOUT_MS),
        });
    }

    let output =
        eval_result.map_err(|error| node_failure(node, format!("JS 执行失败：{error}")))?;
    Ok(RuntimeValue::Text(output))
}

fn execute_text(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let text = match input {
        RuntimeValue::Text(text) | RuntimeValue::Html(text) | RuntimeValue::Url(text) => text,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "text family 只支持 text/html/url 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let op = normalize_param_value(required_param(node, "op")?);
    let value = match op.as_str() {
        "trim" => RuntimeValue::Text(text.trim().to_string()),
        "lower" => RuntimeValue::Text(text.to_lowercase()),
        "upper" => RuntimeValue::Text(text.to_uppercase()),
        "replace" => {
            let pattern = required_param(node, "pattern")?;
            let replacement = required_param(node, "replacement")?;
            RuntimeValue::Text(text.replace(pattern, replacement))
        }
        "normalizespace" => RuntimeValue::Text(normalize_space(&text)),
        other => {
            return Err(node_failure(
                node,
                format!(
                    "text family 不支持 op=`{other}`，仅支持 trim/lower/upper/replace/normalizespace"
                ),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn execute_list(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let items = match input {
        RuntimeValue::List(items) => items,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "list family 只支持 list 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let op = normalize_param_value(required_param(node, "op")?);
    let value = match op.as_str() {
        "join" => {
            let separator = optional_param(node, "separator").unwrap_or("");
            let mut texts = Vec::with_capacity(items.len());
            for item in items {
                match item {
                    RuntimeValue::Text(text)
                    | RuntimeValue::Html(text)
                    | RuntimeValue::Url(text) => {
                        texts.push(text);
                    }
                    other => {
                        return Err(node_failure(
                            node,
                            format!(
                                "list.join 只支持字符串列表，实际元素为 `{}`",
                                other.type_label()
                            ),
                        ));
                    }
                }
            }
            RuntimeValue::Text(texts.join(separator))
        }
        "first" => items
            .into_iter()
            .next()
            .ok_or_else(|| node_failure(node, "list.first 输入列表为空"))?,
        other => {
            return Err(node_failure(
                node,
                format!("list family 不支持 op=`{other}`，仅支持 join/first"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn execute_json(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;
    let json = match input {
        RuntimeValue::Json(json) => json,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "json family 只支持 json 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    let op = normalize_param_value(required_param(node, "op")?);
    let value = match op.as_str() {
        "stringify" => RuntimeValue::Text(
            serde_json::to_string(&json)
                .map_err(|error| node_failure(node, format!("JSON 序列化失败：{error}")))?,
        ),
        other => {
            return Err(node_failure(
                node,
                format!("json family 不支持 op=`{other}`，仅支持 stringify"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn execute_convert(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;

    let op = normalize_param_value(required_param(node, "op")?);
    let value = match op.as_str() {
        "text" => RuntimeValue::Text(runtime_value_to_text(node, input)?),
        "url" => RuntimeValue::Url(parse_url_from_runtime(node, input)?.to_string()),
        other => {
            return Err(node_failure(
                node,
                format!("convert family 不支持 op=`{other}`，仅支持 text/url"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn execute_url(
    node: &Node,
    inputs: &BTreeMap<String, Vec<RuntimeValue>>,
) -> Result<BTreeMap<String, Vec<RuntimeValue>>, EngineError> {
    let input = primary_input_value(node, inputs)?;

    let op = normalize_param_value(required_param(node, "op")?);
    let value = match op.as_str() {
        "normalize" => RuntimeValue::Url(parse_url_from_runtime(node, input)?.to_string()),
        "join" => {
            let relative = runtime_value_to_text(node, input)?;
            let base = Url::parse(required_param(node, "base")?)
                .map_err(|error| node_failure(node, format!("base URL 无效：{error}")))?;
            RuntimeValue::Url(
                base.join(&relative)
                    .map_err(|error| node_failure(node, format!("URL 拼接失败：{error}")))?
                    .to_string(),
            )
        }
        other => {
            return Err(node_failure(
                node,
                format!("url family 不支持 op=`{other}`，仅支持 normalize/join"),
            ));
        }
    };

    Ok(map_single_value_to_outputs(node, value))
}

fn runtime_value_to_text(node: &Node, value: RuntimeValue) -> Result<String, EngineError> {
    match value {
        RuntimeValue::Text(text) | RuntimeValue::Html(text) | RuntimeValue::Url(text) => Ok(text),
        RuntimeValue::Json(json) => serde_json::to_string(&json)
            .map_err(|error| node_failure(node, format!("JSON 序列化失败：{error}"))),
        other => Err(node_failure(
            node,
            format!("无法转换 `{}` 为文本", other.type_label()),
        )),
    }
}

fn parse_url_from_runtime(node: &Node, value: RuntimeValue) -> Result<Url, EngineError> {
    let text = match value {
        RuntimeValue::Text(text) | RuntimeValue::Url(text) => text,
        other => {
            return Err(node_failure(
                node,
                format!(
                    "URL 转换只支持 text/url 输入，实际为 `{}`",
                    other.type_label()
                ),
            ));
        }
    };

    Url::parse(&text).map_err(|error| node_failure(node, format!("URL 解析失败：{error}")))
}

fn normalize_space(input: &str) -> String {
    input.split_whitespace().collect::<Vec<_>>().join(" ")
}

#[cfg(test)]
mod tests {
    use std::collections::BTreeMap;

    use crate::{
        rules_engine::RuntimeValue,
        rules_ir::{DataType, LifecyclePhase, Node, NodeKind, Port},
    };

    use super::execute;

    fn text_port(name: &str) -> Port {
        Port {
            name: name.to_string(),
            data_type: DataType::Text,
            optional: false,
        }
    }

    fn transform_node(params: &[(&str, &str)]) -> Node {
        Node {
            id: "transform_test".to_string(),
            kind: NodeKind::Transform,
            phase: LifecyclePhase::Search,
            inputs: vec![text_port("in")],
            outputs: vec![text_port("out")],
            params: params
                .iter()
                .map(|(key, value)| ((*key).to_string(), (*value).to_string()))
                .collect(),
        }
    }

    fn run_transform(params: &[(&str, &str)], input: &str) -> RuntimeValue {
        let node = transform_node(params);
        let mut inputs = BTreeMap::new();
        inputs.insert(
            "in".to_string(),
            vec![RuntimeValue::Text(input.to_string())],
        );
        let outputs = execute(&node, &inputs).expect("transform 节点应执行成功");
        outputs
            .get("out")
            .and_then(|values| values.last())
            .cloned()
            .expect("应输出 out 值")
    }

    #[test]
    fn codec_base64_encode_and_decode_work() {
        let encoded = run_transform(&[("family", "codec"), ("op", "base64Encode")], "spectra");
        assert_eq!(encoded, RuntimeValue::Text("c3BlY3RyYQ==".to_string()));

        let decoded = run_transform(
            &[("family", "codec"), ("op", "base64Decode")],
            "c3BlY3RyYQ==",
        );
        assert_eq!(decoded, RuntimeValue::Text("spectra".to_string()));
    }

    #[test]
    fn codec_md5_32_and_16_work() {
        let md5_32 = run_transform(&[("family", "codec"), ("op", "md532")], "spectra");
        assert_eq!(
            md5_32,
            RuntimeValue::Text("1695b0899cfb20cbad69d66802d2d63c".to_string())
        );

        let md5_16 = run_transform(&[("family", "codec"), ("op", "md516")], "spectra");
        assert_eq!(md5_16, RuntimeValue::Text("9cfb20cbad69d668".to_string()));
    }

    #[test]
    fn codec_encode_uri_utf8_to_gbk_html_and_time_format_work() {
        let encoded_uri = run_transform(
            &[("family", "codec"), ("op", "encodeURI")],
            "https://example.com/中文?q=空 格#hash",
        );
        assert_eq!(
            encoded_uri,
            RuntimeValue::Text(
                "https://example.com/%E4%B8%AD%E6%96%87?q=%E7%A9%BA%20%E6%A0%BC#hash".to_string()
            )
        );

        let gbk = run_transform(&[("family", "codec"), ("op", "utf8ToGbk")], "中文");
        assert_eq!(gbk, RuntimeValue::Text("%D6%D0%CE%C4".to_string()));

        let html = run_transform(
            &[("family", "codec"), ("op", "htmlFormat")],
            "  <div>A</div>\r\n\r\n\r\n  <p>B</p>  ",
        );
        assert_eq!(
            html,
            RuntimeValue::Text("<div>A</div>\n\n<p>B</p>".to_string())
        );

        let time = run_transform(
            &[
                ("family", "codec"),
                ("op", "timeFormat"),
                ("pattern", "%Y-%m-%d"),
            ],
            "1704067200",
        );
        assert_eq!(time, RuntimeValue::Text("2024-01-01".to_string()));
    }

    #[test]
    fn crypto_aes_cbc_pkcs7_encode_decode_work() {
        let ciphertext = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesEncode"),
                ("transformation", "AES/CBC/PKCS7Padding"),
                ("key", "1234567890abcdef"),
                ("iv", "fedcba0987654321"),
            ],
            "hello-spectra",
        );
        let RuntimeValue::Text(ciphertext) = ciphertext else {
            panic!("AES/CBC 输出应为文本");
        };

        let plaintext = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesDecode"),
                ("transformation", "AES/CBC/PKCS7Padding"),
                ("key", "1234567890abcdef"),
                ("iv", "fedcba0987654321"),
            ],
            ciphertext.as_str(),
        );
        assert_eq!(plaintext, RuntimeValue::Text("hello-spectra".to_string()));
    }

    #[test]
    fn crypto_aes_ecb_pkcs7_encode_decode_work() {
        let ciphertext = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesEncode"),
                ("transformation", "AES/ECB/PKCS7Padding"),
                ("key", "1234567890abcdef"),
            ],
            "hello-spectra",
        );
        let RuntimeValue::Text(ciphertext) = ciphertext else {
            panic!("AES/ECB 输出应为文本");
        };

        let plaintext = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesDecode"),
                ("transformation", "AES/ECB/PKCS7Padding"),
                ("key", "1234567890abcdef"),
            ],
            ciphertext.as_str(),
        );
        assert_eq!(plaintext, RuntimeValue::Text("hello-spectra".to_string()));
    }

    #[test]
    fn crypto_aes_named_ops_match_known_answers() {
        let cbc = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesCbcEncode"),
                ("key", "1234567890abcdef"),
                ("iv", "fedcba0987654321"),
            ],
            "hello-spectra",
        );
        assert_eq!(cbc, RuntimeValue::Text("UpvU71M71rJfGplhMzu/UQ==".to_string()));

        let ecb = run_transform(
            &[
                ("family", "crypto"),
                ("op", "aesEcbEncode"),
                ("key", "1234567890abcdef"),
            ],
            "hello-spectra",
        );
        assert_eq!(ecb, RuntimeValue::Text("DNNM4HLlUckSwVf6C6Qj0w==".to_string()));
    }

    #[test]
    fn crypto_key_ref_rule_kv_provider_is_rejected() {
        let node = transform_node(&[
            ("family", "crypto"),
            ("op", "aesCbcEncode"),
            (
                "keyRef",
                r#"{"provider":"secureStore","name":"secret.key"}"#,
            ),
            (
                "ivRef",
                r#"{"provider":"secureStore","name":"secret.iv"}"#,
            ),
        ]);
        let mut inputs = BTreeMap::new();
        inputs.insert(
            "in".to_string(),
            vec![RuntimeValue::Text("hello-spectra".to_string())],
        );

        let error = execute(&node, &inputs).expect_err("secureStore KeyRef 在运行时应被拒绝");
        let message = error.to_string();
        assert!(message.contains("provider=secureStore"));
    }

    #[test]
    fn crypto_variable_key_ref_reports_missing_variable() {
        let node = transform_node(&[
            ("family", "crypto"),
            ("op", "aesEcbEncode"),
            (
                "keyRef",
                r#"{"provider":"variable","name":"SPECTRA_AES_KEY_MISSING_FOR_TEST"}"#,
            ),
        ]);
        let mut inputs = BTreeMap::new();
        inputs.insert(
            "in".to_string(),
            vec![RuntimeValue::Text("hello-spectra".to_string())],
        );

        let error = execute(&node, &inputs).expect_err("缺失变量引用应报错");
        let message = error.to_string();
        assert!(message.contains("环境变量"));
    }
}
