mod context;
mod error;
mod events;
mod execution;
mod graph;
mod limiter;
mod nodes;
mod result;
mod stats;
mod storage;
mod value;

#[cfg(test)]
mod tests;

pub use context::{EngineContext, EngineRunResult};
pub use error::EngineError;
pub(crate) use events::{EventCommand, emit_node_log};
#[cfg(test)]
pub(crate) use events::{collect_events, truncate_utf8};
pub use execution::execute_rule;
#[cfg(test)]
pub(crate) use execution::{RunNodeContext, run_node};
pub(crate) use limiter::RuleRateLimiter;
pub use stats::NodeStats;
pub(crate) use storage::{
    CacheScope, PersistedCookieEntry, RuntimeCookieJar, RuntimeKvStore,
    current_unix_timestamp_secs, extract_domain_from_url, normalize_cookie_domain,
    normalize_cookie_path, parse_cache_scope,
};
pub use value::RuntimeValue;
pub(crate) const DEFAULT_CACHE_VALUE_MAX_BYTES: usize = 65_536;
pub(crate) const MAX_CACHE_VALUE_BYTES_LIMIT: usize = 262_144;
