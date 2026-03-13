use std::{
    collections::VecDeque,
    time::{Duration, Instant},
};

use tokio::sync::Mutex;

use crate::rules_ir::RuleRateLimit;

#[derive(Debug)]
pub(crate) struct RuleRateLimiter {
    pub(crate) count: usize,
    pub(crate) period: Duration,
    timestamps: Mutex<VecDeque<Instant>>,
}

#[derive(Debug, Clone, Copy)]
pub(crate) struct RateLimitDelayInfo {
    pub(crate) wait: Duration,
    pub(crate) count: usize,
    pub(crate) period: Duration,
}

impl RuleRateLimiter {
    pub(crate) fn from_config(config: &RuleRateLimit) -> Option<Self> {
        if config.count == 0 || config.period_ms == 0 {
            return None;
        }

        Some(Self {
            count: config.count as usize,
            period: Duration::from_millis(config.period_ms),
            timestamps: Mutex::new(VecDeque::new()),
        })
    }

    pub(crate) async fn poll_delay(&self) -> Option<RateLimitDelayInfo> {
        loop {
            let wait = {
                let mut guard = self.timestamps.lock().await;
                let now = Instant::now();

                while let Some(timestamp) = guard.front().copied() {
                    if now.duration_since(timestamp) >= self.period {
                        guard.pop_front();
                    } else {
                        break;
                    }
                }

                if guard.len() < self.count {
                    guard.push_back(now);
                    return None;
                }

                let Some(oldest) = guard.front().copied() else {
                    continue;
                };
                self.period.saturating_sub(now.duration_since(oldest))
            };

            if wait.is_zero() {
                tokio::task::yield_now().await;
                continue;
            }

            return Some(RateLimitDelayInfo {
                wait,
                count: self.count,
                period: self.period,
            });
        }
    }
}
