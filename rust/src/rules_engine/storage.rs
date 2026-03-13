use std::{
    collections::HashMap,
    time::{SystemTime, UNIX_EPOCH},
};

use serde_json::Value as JsonValue;
use tokio::sync::Mutex;

use super::{
    RuntimeValue,
    value::{runtime_value_from_repr, runtime_value_hash_repr},
};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub(crate) enum CacheScope {
    Run,
    Rule,
}

#[derive(Debug)]
pub(crate) struct RuntimeKvStore {
    run_scope: Mutex<HashMap<String, RuntimeValue>>,
    rule_scope: Mutex<HashMap<String, RuntimeValue>>,
}

#[derive(Debug)]
pub(crate) struct RuntimeCookieJar {
    current_request_domain: Mutex<Option<String>>,
    entries: Mutex<Vec<PersistedCookieEntry>>,
}

#[derive(Debug, Clone, PartialEq, Eq, serde::Serialize, serde::Deserialize)]
#[serde(rename_all = "camelCase")]
pub(crate) struct PersistedCookieEntry {
    pub(crate) name: String,
    pub(crate) value: String,
    pub(crate) domain: String,
    pub(crate) path: String,
    pub(crate) secure: bool,
    pub(crate) http_only: bool,
    #[serde(default)]
    pub(crate) expires_at_unix: Option<i64>,
}

impl RuntimeKvStore {
    pub(crate) fn from_persisted_json(persisted_rule_kv_json: Option<&str>) -> Self {
        let mut rule_scope = HashMap::new();

        if let Some(payload) = persisted_rule_kv_json
            && let Ok(map) = serde_json::from_str::<HashMap<String, JsonValue>>(payload)
        {
            for (key, value_repr) in map {
                if let Some(value) = runtime_value_from_repr(&value_repr) {
                    rule_scope.insert(key, value);
                }
            }
        }

        Self {
            run_scope: Mutex::new(HashMap::new()),
            rule_scope: Mutex::new(rule_scope),
        }
    }

    pub(crate) async fn get(&self, scope: CacheScope, key: &str) -> Option<RuntimeValue> {
        match scope {
            CacheScope::Run => self.run_scope.lock().await.get(key).cloned(),
            CacheScope::Rule => self.rule_scope.lock().await.get(key).cloned(),
        }
    }

    pub(crate) async fn put(
        &self,
        scope: CacheScope,
        key: String,
        value: RuntimeValue,
        max_value_bytes: usize,
    ) -> Result<usize, usize> {
        let value_bytes = serde_json::to_vec(&runtime_value_hash_repr(&value))
            .map(|bytes| bytes.len())
            .unwrap_or(0);
        if value_bytes > max_value_bytes {
            return Err(value_bytes);
        }

        match scope {
            CacheScope::Run => {
                self.run_scope.lock().await.insert(key, value);
            }
            CacheScope::Rule => {
                self.rule_scope.lock().await.insert(key, value);
            }
        }

        Ok(value_bytes)
    }

    pub(crate) async fn snapshot_rule_scope_json(&self) -> Option<String> {
        let guard = self.rule_scope.lock().await;
        if guard.is_empty() {
            return None;
        }

        let map = guard
            .iter()
            .map(|(key, value)| (key.clone(), runtime_value_hash_repr(value)))
            .collect::<HashMap<_, _>>();
        serde_json::to_string(&map).ok()
    }
}

impl RuntimeCookieJar {
    pub(crate) fn from_persisted_json(persisted_cookie_jar_json: Option<&str>) -> Self {
        let entries = persisted_cookie_jar_json
            .and_then(|payload| serde_json::from_str::<Vec<PersistedCookieEntry>>(payload).ok())
            .unwrap_or_default();
        Self {
            current_request_domain: Mutex::new(None),
            entries: Mutex::new(entries),
        }
    }

    pub(crate) async fn snapshot_json(&self) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let mut guard = self.entries.lock().await;
        guard.retain(|entry| !cookie_is_expired(entry, now));
        if guard.is_empty() {
            return None;
        }
        serde_json::to_string(&*guard).ok()
    }

    pub(crate) async fn set_current_request_domain(&self, domain: Option<String>) {
        *self.current_request_domain.lock().await = domain;
    }

    pub(crate) async fn current_request_domain(&self) -> Option<String> {
        self.current_request_domain.lock().await.clone()
    }

    pub(crate) async fn put_entry(&self, entry: PersistedCookieEntry) {
        let now = current_unix_timestamp_secs();
        let mut guard = self.entries.lock().await;
        guard.retain(|candidate| {
            !(candidate.name == entry.name
                && candidate.domain == entry.domain
                && candidate.path == entry.path)
        });
        if cookie_is_expired(&entry, now) {
            return;
        }
        guard.push(entry);
    }

    pub(crate) async fn hydrate_client(&self, client: &wreq::Client) {
        let now = current_unix_timestamp_secs();
        let entries = self.entries.lock().await.clone();
        for entry in entries {
            if cookie_is_expired(&entry, now) {
                continue;
            }
            let scheme = if entry.secure { "https" } else { "http" };
            let target_url = format!("{scheme}://{}{}", entry.domain, entry.path);
            let Ok(url) = target_url.parse::<wreq::Url>() else {
                continue;
            };

            let mut cookie = format!("{}={}; Path={}", entry.name, entry.value, entry.path);
            if let Some(expires_at_unix) = entry.expires_at_unix {
                let max_age = expires_at_unix.saturating_sub(now);
                cookie.push_str(format!("; Max-Age={max_age}").as_str());
            }
            if entry.secure {
                cookie.push_str("; Secure");
            }
            if entry.http_only {
                cookie.push_str("; HttpOnly");
            }
            if let Ok(header) = wreq::header::HeaderValue::from_str(cookie.as_str()) {
                client.set_cookies(&url, [header]);
            }
        }
    }

    pub(crate) async fn get_cookie_value(
        &self,
        name: &str,
        domain: Option<&str>,
        path: Option<&str>,
    ) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let requested_domain = domain.map(normalize_cookie_domain);
        let requested_path = path.unwrap_or("/");

        let mut guard = self.entries.lock().await;
        guard.retain(|cookie| !cookie_is_expired(cookie, now));
        guard.iter().find_map(|cookie| {
            if cookie.name != name {
                return None;
            }
            if let Some(domain) = requested_domain.as_ref()
                && !cookie_domain_matches(&cookie.domain, domain)
            {
                return None;
            }
            if !requested_path.starts_with(cookie.path.as_str()) {
                return None;
            }
            Some(cookie.value.clone())
        })
    }

    pub(crate) async fn cookie_header_for_url(&self, url: &str) -> Option<String> {
        let now = current_unix_timestamp_secs();
        let parsed = url::Url::parse(url).ok()?;
        let host = normalize_cookie_domain(parsed.host_str()?);
        let request_path = parsed.path();
        let is_https = parsed.scheme().eq_ignore_ascii_case("https");

        let mut guard = self.entries.lock().await;
        guard.retain(|cookie| !cookie_is_expired(cookie, now));
        let cookie_pairs = guard
            .iter()
            .filter(|cookie| {
                cookie_domain_matches(&cookie.domain, &host)
                    && request_path.starts_with(cookie.path.as_str())
                    && (!cookie.secure || is_https)
            })
            .map(|cookie| format!("{}={}", cookie.name, cookie.value))
            .collect::<Vec<_>>();

        if cookie_pairs.is_empty() {
            None
        } else {
            Some(cookie_pairs.join("; "))
        }
    }

    pub(crate) async fn absorb_set_cookie_headers(
        &self,
        response_url: &str,
        headers: &wreq::header::HeaderMap,
    ) {
        let Some(default_domain) = extract_domain_from_url(response_url) else {
            return;
        };

        for header in headers.get_all(wreq::header::SET_COOKIE) {
            let Ok(raw_cookie) = header.to_str() else {
                continue;
            };
            if let Some(entry) = parse_set_cookie_entry(raw_cookie, &default_domain) {
                self.put_entry(entry).await;
            }
        }
    }
}

fn parse_set_cookie_entry(raw_cookie: &str, default_domain: &str) -> Option<PersistedCookieEntry> {
    let mut segments = raw_cookie.split(';');
    let first = segments.next()?.trim();
    let (name, value) = first.split_once('=')?;
    let mut entry = PersistedCookieEntry {
        name: name.trim().to_string(),
        value: value.trim().to_string(),
        domain: default_domain.to_string(),
        path: "/".to_string(),
        secure: false,
        http_only: false,
        expires_at_unix: None,
    };
    if entry.name.is_empty() {
        return None;
    }

    for segment in segments {
        let token = segment.trim();
        if token.eq_ignore_ascii_case("secure") {
            entry.secure = true;
            continue;
        }
        if token.eq_ignore_ascii_case("httponly") {
            entry.http_only = true;
            continue;
        }

        let Some((key, value)) = token.split_once('=') else {
            continue;
        };
        let key = key.trim().to_ascii_lowercase();
        let value = value.trim();
        match key.as_str() {
            "domain" => {
                let normalized = normalize_cookie_domain(value);
                if !normalized.is_empty() {
                    entry.domain = normalized;
                }
            }
            "path" => {
                if !value.is_empty() {
                    entry.path = normalize_cookie_path(value);
                }
            }
            "max-age" => {
                if let Ok(seconds) = value.parse::<i64>() {
                    entry.expires_at_unix =
                        Some(current_unix_timestamp_secs().saturating_add(seconds));
                }
            }
            _ => {}
        }
    }

    Some(entry)
}

fn cookie_is_expired(entry: &PersistedCookieEntry, now_unix: i64) -> bool {
    entry
        .expires_at_unix
        .map(|expires_at| expires_at <= now_unix)
        .unwrap_or(false)
}

pub(crate) fn current_unix_timestamp_secs() -> i64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs() as i64
}

pub(crate) fn normalize_cookie_domain(domain: &str) -> String {
    domain
        .trim()
        .to_ascii_lowercase()
        .trim_start_matches('.')
        .to_string()
}

pub(crate) fn normalize_cookie_path(path: &str) -> String {
    let trimmed = path.trim();
    if trimmed.is_empty() {
        return "/".to_string();
    }
    if trimmed.starts_with('/') {
        trimmed.to_string()
    } else {
        format!("/{trimmed}")
    }
}

pub(crate) fn extract_domain_from_url(url: &str) -> Option<String> {
    let parsed = url::Url::parse(url).ok()?;
    parsed.host_str().map(normalize_cookie_domain)
}

pub(crate) fn cookie_domain_matches(cookie_domain: &str, request_domain: &str) -> bool {
    if cookie_domain == request_domain {
        return true;
    }
    request_domain.ends_with(format!(".{cookie_domain}").as_str())
}

pub(crate) fn parse_cache_scope(value: &str) -> Option<CacheScope> {
    match value.trim().to_ascii_lowercase().as_str() {
        "run" => Some(CacheScope::Run),
        "rule" => Some(CacheScope::Rule),
        _ => None,
    }
}
