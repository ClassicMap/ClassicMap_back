//! Clerk 에서 지워진 계정의 DB 행을 하루 한 번 정리한다.
//!
//! 앱에서 탈퇴하면 `DELETE /me` 가 행을 지우지만, 관리자가 Clerk 대시보드에서 바로 지운 계정은 행이 남는다.
//! 웹훅은 쓰지 않는다. users 의 clerk id 를 하나씩 Clerk Backend API(`GET /v1/users/{id}`)로 물어
//! 404 인 계정만 `DELETE /me` 와 같은 `UserService::delete_account` 로 지운다.
//!
//! 안전장치
//! - `CLERK_SECRET_KEY` 가 없으면 돌지 않는다.
//! - 200·404 가 아닌 응답(401·403·429·5xx·네트워크 오류)이 하나라도 나오면 그 회차는 하나도 지우지 않는다.
//! - 404 가 `MAX_DELETIONS` 를 넘거나, 있는 계정(200)을 하나도 확인하지 못했으면 하나도 지우지 않는다.
//!   키가 다른 인스턴스 것이면 모든 계정이 404 로 나오기 때문이다.
//! - 로그에는 users.id 와 개수만 남긴다(이메일·clerk id 는 남기지 않는다).

use super::repository::UserRepository;
use super::service::UserService;
use crate::db::DbPool;
use crate::logger::Logger;
use chrono::{DateTime, FixedOffset, NaiveTime, Utc};
use std::future::Future;
use std::time::Duration;
use tokio::time::sleep;

const SECRET_KEY_ENV: &str = "CLERK_SECRET_KEY";
const CLERK_API_BASE: &str = "https://api.clerk.com/v1";
/// 한 회차에 지울 수 있는 계정 수. 404 가 이보다 많으면 하나도 지우지 않는다
pub const MAX_DELETIONS: usize = 20;
/// 요청 사이 간격. Clerk Backend API 한도(개발 인스턴스 10초에 100건)의 1/10 만 쓴다
pub const REQUEST_INTERVAL: Duration = Duration::from_secs(1);
const REQUEST_TIMEOUT: Duration = Duration::from_secs(15);
/// 매일 이 시각(KST)에 돈다. KOPIS 공연장(11시)·공연(12시)·Apple Music(13시) 동기화와 겹치지 않는 새벽
const DAILY_HOUR_KST: u32 = 4;
const DAILY_MINUTE_KST: u32 = 30;
const KST_OFFSET_SECS: i32 = 9 * 3600;
const LOG_TAG: &str = "CLERK_RECONCILE";

/// Clerk Backend API secret key. Authorization 헤더로만 보낸다
#[derive(Clone)]
pub struct ClerkSecretKey(String);

impl std::fmt::Debug for ClerkSecretKey {
    // 키가 로그에 찍히지 않게 값은 숨긴다
    fn fmt(&self, formatter: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        formatter.write_str("ClerkSecretKey(***)")
    }
}

impl ClerkSecretKey {
    pub fn from_env() -> Option<Self> {
        Self::from_lookup(|name| std::env::var(name).ok())
    }

    /// 값이 없거나 비어 있으면 None (정리 작업을 끈다)
    pub fn from_lookup(read: impl Fn(&str) -> Option<String>) -> Option<Self> {
        read(SECRET_KEY_ENV)
            .map(|value| value.trim().to_string())
            .filter(|value| !value.is_empty())
            .map(Self)
    }
}

/// Clerk 에 계정을 물은 결과
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ClerkLookup {
    /// 200. 계정이 있다
    Exists,
    /// 404. 계정이 없다(지울 후보)
    Gone,
    /// 그 밖의 응답이나 요청 실패. 이유에는 상태 코드나 오류 종류만 담는다
    Unexpected(String),
}

pub fn classify_status(status: u16) -> ClerkLookup {
    match status {
        200 => ClerkLookup::Exists,
        404 => ClerkLookup::Gone,
        other => ClerkLookup::Unexpected(format!("HTTP {other}")),
    }
}

/// Clerk 계정 조회. 시험에서는 가짜로 바꿔 끼운다
pub trait ClerkUserDirectory {
    fn lookup(&self, clerk_id: &str) -> impl Future<Output = ClerkLookup> + Send;
}

pub struct HttpClerkUsers {
    client: reqwest::Client,
    key: ClerkSecretKey,
}

impl HttpClerkUsers {
    pub fn new(key: ClerkSecretKey) -> Result<Self, String> {
        let client = reqwest::Client::builder()
            .timeout(REQUEST_TIMEOUT)
            .build()
            .map_err(|error| format!("failed to build HTTP client: {}", error.without_url()))?;
        Ok(Self { client, key })
    }
}

impl ClerkUserDirectory for HttpClerkUsers {
    async fn lookup(&self, clerk_id: &str) -> ClerkLookup {
        let url = format!("{CLERK_API_BASE}/users/{clerk_id}");
        match self.client.get(url).bearer_auth(&self.key.0).send().await {
            Ok(response) => classify_status(response.status().as_u16()),
            // 오류 문구에는 주소(clerk id)가 섞이므로 종류만 남긴다
            Err(error) if error.is_timeout() => ClerkLookup::Unexpected("timeout".to_string()),
            Err(error) if error.is_connect() => {
                ClerkLookup::Unexpected("connect error".to_string())
            }
            Err(_) => ClerkLookup::Unexpected("request error".to_string()),
        }
    }
}

/// Clerk 에 물어볼 사용자 한 명
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct AccountRef {
    pub user_id: i32,
    pub clerk_id: String,
}

/// Clerk 사용자 id 모양(`user_` + 영숫자)만 묻는다. 시험용·옛 행은 건드리지 않고, 주소 경로도 안전하게 둔다
pub fn is_clerk_user_id(clerk_id: &str) -> bool {
    clerk_id.len() <= 100
        && clerk_id
            .strip_prefix("user_")
            .is_some_and(|rest| !rest.is_empty() && rest.chars().all(|c| c.is_ascii_alphanumeric()))
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ReconcilePlan {
    /// 지울 계정(비어 있을 수 있다)
    Delete {
        checked: usize,
        skipped: usize,
        targets: Vec<AccountRef>,
    },
    /// 200·404 가 아닌 응답이 나와 멈췄다. 하나도 지우지 않는다
    Halted {
        checked: usize,
        user_id: i32,
        reason: String,
    },
    /// 404 가 상한을 넘었다. 하나도 지우지 않는다
    OverLimit { checked: usize, gone: usize },
    /// 404 는 있는데 있는 계정을 하나도 확인하지 못했다(키가 다른 인스턴스 것일 수 있다). 하나도 지우지 않는다
    NoLiveAccount { checked: usize, gone: usize },
}

/// 계정마다 Clerk 에 물어 지울 계정을 고른다. DB 는 건드리지 않는다
pub async fn plan_deletions<D: ClerkUserDirectory>(
    directory: &D,
    accounts: &[AccountRef],
    interval: Duration,
    max_deletions: usize,
) -> ReconcilePlan {
    let mut checked = 0;
    let mut skipped = 0;
    let mut live = 0;
    let mut targets: Vec<AccountRef> = Vec::new();
    for account in accounts {
        if !is_clerk_user_id(&account.clerk_id) {
            skipped += 1;
            continue;
        }
        if checked > 0 {
            sleep(interval).await;
        }
        checked += 1;
        match directory.lookup(&account.clerk_id).await {
            ClerkLookup::Exists => live += 1,
            ClerkLookup::Gone => {
                targets.push(account.clone());
                if targets.len() > max_deletions {
                    return ReconcilePlan::OverLimit {
                        checked,
                        gone: targets.len(),
                    };
                }
            }
            ClerkLookup::Unexpected(reason) => {
                return ReconcilePlan::Halted {
                    checked,
                    user_id: account.user_id,
                    reason,
                }
            }
        }
    }
    if !targets.is_empty() && live == 0 {
        return ReconcilePlan::NoLiveAccount {
            checked,
            gone: targets.len(),
        };
    }
    ReconcilePlan::Delete {
        checked,
        skipped,
        targets,
    }
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ReconcileReport {
    pub plan: ReconcilePlan,
    pub deleted: usize,
    pub failed: usize,
}

/// 한 회차. 사용자 목록을 읽고, Clerk 에 묻고, 고른 계정만 `DELETE /me` 와 같은 길로 지운다
pub async fn reconcile_once<D: ClerkUserDirectory>(
    pool: &DbPool,
    directory: &D,
    interval: Duration,
    max_deletions: usize,
) -> Result<ReconcileReport, String> {
    let accounts: Vec<AccountRef> = UserRepository::find_clerk_ids(pool)
        .await
        .map_err(|error| format!("failed to list users: {error}"))?
        .into_iter()
        .map(|(user_id, clerk_id)| AccountRef { user_id, clerk_id })
        .collect();
    Logger::info(
        LOG_TAG,
        &format!("Checking {} accounts against Clerk", accounts.len()),
    );

    let plan = plan_deletions(directory, &accounts, interval, max_deletions).await;
    let mut deleted = 0;
    let mut failed = 0;
    if let ReconcilePlan::Delete { targets, .. } = &plan {
        for target in targets {
            match UserService::delete_account(pool, target.user_id, &target.clerk_id).await {
                Ok(()) => {
                    deleted += 1;
                    Logger::info(
                        LOG_TAG,
                        &format!("Deleted user {} (gone from Clerk)", target.user_id),
                    );
                }
                Err(error) => {
                    failed += 1;
                    Logger::warn(
                        LOG_TAG,
                        &format!("Failed to delete user {}: {}", target.user_id, error),
                    );
                }
            }
        }
    }
    Ok(ReconcileReport {
        plan,
        deleted,
        failed,
    })
}

fn log_report(report: &ReconcileReport) {
    match &report.plan {
        ReconcilePlan::Delete {
            checked,
            skipped,
            targets,
        } => Logger::success(
            LOG_TAG,
            &format!(
                "Done: {} checked, {} skipped (not a Clerk user id), {} gone, {} deleted, {} failed",
                checked,
                skipped,
                targets.len(),
                report.deleted,
                report.failed
            ),
        ),
        ReconcilePlan::Halted {
            checked,
            user_id,
            reason,
        } => Logger::warn(
            LOG_TAG,
            &format!(
                "Halted at user {} ({}) after {} checks. Nothing deleted",
                user_id, reason, checked
            ),
        ),
        ReconcilePlan::OverLimit { checked, gone } => Logger::warn(
            LOG_TAG,
            &format!(
                "{} accounts missing from Clerk after {} checks (limit {}). Nothing deleted. Check that CLERK_SECRET_KEY belongs to the same Clerk instance as CLERK_PEM_PUBLIC_KEY",
                gone, checked, MAX_DELETIONS
            ),
        ),
        ReconcilePlan::NoLiveAccount { checked, gone } => Logger::warn(
            LOG_TAG,
            &format!(
                "{} of {} checked accounts missing from Clerk and none confirmed to exist. Nothing deleted. Check that CLERK_SECRET_KEY belongs to the same Clerk instance as CLERK_PEM_PUBLIC_KEY",
                gone, checked
            ),
        ),
    }
}

/// 다음 KST hour:minute 까지 남은 시간. 서버 시간대(파드는 UTC)와 상관없이 KST 로 맞춘다
pub fn wait_until_kst(now: DateTime<Utc>, hour: u32, minute: u32) -> Duration {
    let (Some(kst), Some(at)) = (
        FixedOffset::east_opt(KST_OFFSET_SECS),
        NaiveTime::from_hms_opt(hour, minute, 0),
    ) else {
        return Duration::from_secs(24 * 3600);
    };
    let local = now.with_timezone(&kst).naive_local();
    let mut next = local.date().and_time(at);
    if local >= next {
        next += chrono::Duration::days(1);
    }
    Duration::from_secs(next.signed_duration_since(local).num_seconds().max(60) as u64)
}

pub struct ClerkReconcileScheduler;

impl ClerkReconcileScheduler {
    /// 키가 없으면 로그 한 줄만 남기고 끈다. 서버는 그대로 뜬다. 작업을 띄웠으면 true
    pub fn start(pool: DbPool) -> bool {
        Self::start_with(pool, ClerkSecretKey::from_env())
    }

    pub fn start_with(pool: DbPool, key: Option<ClerkSecretKey>) -> bool {
        let Some(key) = key else {
            Logger::info(
                LOG_TAG,
                "Clerk deleted-account cleanup disabled: CLERK_SECRET_KEY not set",
            );
            return false;
        };
        let directory = match HttpClerkUsers::new(key) {
            Ok(directory) => directory,
            Err(error) => {
                Logger::error(LOG_TAG, &format!("Clerk cleanup disabled: {error}"));
                return false;
            }
        };
        Logger::info(
            "SCHEDULER",
            &format!(
                "Clerk deleted-account cleanup: daily at {:02}:{:02} KST",
                DAILY_HOUR_KST, DAILY_MINUTE_KST
            ),
        );
        tokio::spawn(async move {
            loop {
                sleep(wait_until_kst(Utc::now(), DAILY_HOUR_KST, DAILY_MINUTE_KST)).await;
                Self::run(&pool, &directory).await;
            }
        });
        true
    }

    async fn run(pool: &DbPool, directory: &HttpClerkUsers) {
        Logger::info(LOG_TAG, "=== Starting Clerk deleted-account cleanup ===");
        match reconcile_once(pool, directory, REQUEST_INTERVAL, MAX_DELETIONS).await {
            Ok(report) => log_report(&report),
            Err(error) => Logger::error(LOG_TAG, &format!("Cleanup failed: {error}")),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::TimeZone;
    use std::collections::HashMap;
    use std::sync::atomic::{AtomicUsize, Ordering};

    /// 정해 둔 답을 돌려주는 가짜 Clerk. 적지 않은 계정은 있다(200)고 답한다
    struct ScriptedClerk {
        answers: HashMap<String, ClerkLookup>,
        calls: AtomicUsize,
    }

    impl ScriptedClerk {
        fn new(answers: &[(&str, ClerkLookup)]) -> Self {
            Self::from_answers(
                answers
                    .iter()
                    .map(|(id, answer)| (id.to_string(), answer.clone())),
            )
        }

        fn from_answers(answers: impl IntoIterator<Item = (String, ClerkLookup)>) -> Self {
            Self {
                answers: answers.into_iter().collect(),
                calls: AtomicUsize::new(0),
            }
        }

        fn calls(&self) -> usize {
            self.calls.load(Ordering::SeqCst)
        }
    }

    impl ClerkUserDirectory for ScriptedClerk {
        async fn lookup(&self, clerk_id: &str) -> ClerkLookup {
            self.calls.fetch_add(1, Ordering::SeqCst);
            self.answers
                .get(clerk_id)
                .cloned()
                .unwrap_or(ClerkLookup::Exists)
        }
    }

    fn account(user_id: i32, clerk_id: &str) -> AccountRef {
        AccountRef {
            user_id,
            clerk_id: clerk_id.to_string(),
        }
    }

    fn accounts(count: i32) -> Vec<AccountRef> {
        (1..=count)
            .map(|id| account(id, &format!("user_{id:03}")))
            .collect()
    }

    async fn plan(clerk: &ScriptedClerk, accounts: &[AccountRef]) -> ReconcilePlan {
        plan_deletions(clerk, accounts, Duration::ZERO, MAX_DELETIONS).await
    }

    #[test]
    fn only_404_is_a_deletion_candidate() {
        assert_eq!(classify_status(200), ClerkLookup::Exists);
        assert_eq!(classify_status(404), ClerkLookup::Gone);
        for status in [204, 301, 400, 401, 403, 410, 422, 429, 500, 502, 503] {
            assert_eq!(
                classify_status(status),
                ClerkLookup::Unexpected(format!("HTTP {status}")),
                "status {status}"
            );
        }
    }

    #[tokio::test]
    async fn deletes_only_accounts_clerk_reports_missing() {
        let clerk = ScriptedClerk::new(&[("user_002", ClerkLookup::Gone)]);
        let result = plan(&clerk, &accounts(3)).await;
        assert_eq!(
            result,
            ReconcilePlan::Delete {
                checked: 3,
                skipped: 0,
                targets: vec![account(2, "user_002")],
            }
        );
    }

    #[tokio::test]
    async fn any_unexpected_response_halts_the_run() {
        for reason in [
            "HTTP 401",
            "HTTP 403",
            "HTTP 429",
            "HTTP 500",
            "timeout",
            "connect error",
        ] {
            let clerk = ScriptedClerk::new(&[
                ("user_001", ClerkLookup::Gone),
                ("user_002", ClerkLookup::Unexpected(reason.to_string())),
                ("user_003", ClerkLookup::Gone),
            ]);
            let result = plan(&clerk, &accounts(4)).await;
            assert_eq!(
                result,
                ReconcilePlan::Halted {
                    checked: 2,
                    user_id: 2,
                    reason: reason.to_string(),
                },
                "{reason}"
            );
            // 멈춘 뒤에는 더 묻지 않는다
            assert_eq!(clerk.calls(), 2);
        }
    }

    #[tokio::test]
    async fn too_many_missing_accounts_deletes_nothing() {
        let all = accounts(30);
        let clerk = ScriptedClerk::from_answers(
            all.iter()
                .take(MAX_DELETIONS + 1)
                .map(|a| (a.clerk_id.clone(), ClerkLookup::Gone)),
        );
        let result = plan(&clerk, &all).await;
        assert_eq!(
            result,
            ReconcilePlan::OverLimit {
                checked: MAX_DELETIONS + 1,
                gone: MAX_DELETIONS + 1,
            }
        );
    }

    #[tokio::test]
    async fn exactly_the_limit_is_still_deleted() {
        let all = accounts(25);
        let clerk = ScriptedClerk::from_answers(
            all.iter()
                .take(MAX_DELETIONS)
                .map(|a| (a.clerk_id.clone(), ClerkLookup::Gone)),
        );
        match plan(&clerk, &all).await {
            ReconcilePlan::Delete { targets, .. } => assert_eq!(targets.len(), MAX_DELETIONS),
            other => panic!("expected Delete, got {other:?}"),
        }
    }

    #[tokio::test]
    async fn all_missing_with_no_live_account_deletes_nothing() {
        // 키가 다른 인스턴스 것이면 사용자가 상한보다 적어도 전부 404 가 나온다
        let clerk = ScriptedClerk::new(&[
            ("user_001", ClerkLookup::Gone),
            ("user_002", ClerkLookup::Gone),
        ]);
        let result = plan(&clerk, &accounts(2)).await;
        assert_eq!(
            result,
            ReconcilePlan::NoLiveAccount {
                checked: 2,
                gone: 2,
            }
        );
    }

    #[tokio::test]
    async fn skips_ids_that_are_not_clerk_user_ids() {
        let clerk = ScriptedClerk::new(&[]);
        let rows = vec![
            account(1, "user_abc123"),
            account(2, ""),
            account(3, "user-provision-integration"),
            account(4, "user_../../users"),
            account(5, "user_"),
        ];
        let result = plan(&clerk, &rows).await;
        assert_eq!(
            result,
            ReconcilePlan::Delete {
                checked: 1,
                skipped: 4,
                targets: vec![],
            }
        );
        assert_eq!(clerk.calls(), 1);
    }

    #[test]
    fn missing_or_blank_key_disables_cleanup() {
        assert!(ClerkSecretKey::from_lookup(|_| None).is_none());
        assert!(ClerkSecretKey::from_lookup(|_| Some("   ".to_string())).is_none());
        let key = ClerkSecretKey::from_lookup(|name| {
            (name == "CLERK_SECRET_KEY").then(|| " sk_test_placeholder ".to_string())
        })
        .expect("key");
        assert_eq!(format!("{key:?}"), "ClerkSecretKey(***)");
    }

    #[tokio::test]
    async fn scheduler_does_not_start_without_key() {
        // 연결하지 않는 풀. 작업이 돌면 연결을 시도하겠지만 키가 없으면 띄우지도 않는다
        let pool = sqlx::mysql::MySqlPoolOptions::new()
            .connect_lazy("mysql://nobody:nothing@127.0.0.1:1/none")
            .expect("lazy pool");
        assert!(!ClerkReconcileScheduler::start_with(pool, None));
    }

    #[test]
    fn waits_until_next_dawn_in_kst() {
        // 2026-11-10 19:00 UTC = 11-11 04:00 KST → 30분 뒤
        let before = Utc.with_ymd_and_hms(2026, 11, 10, 19, 0, 0).unwrap();
        assert_eq!(wait_until_kst(before, 4, 30), Duration::from_secs(30 * 60));
        // 정각이면 다음 날
        let at = Utc.with_ymd_and_hms(2026, 11, 10, 19, 30, 0).unwrap();
        assert_eq!(wait_until_kst(at, 4, 30), Duration::from_secs(24 * 3600));
        // KOPIS 공연 동기화(12:00 KST = 03:00 UTC) 때면 16시간 30분 뒤
        let noon = Utc.with_ymd_and_hms(2026, 11, 10, 3, 0, 0).unwrap();
        assert_eq!(
            wait_until_kst(noon, 4, 30),
            Duration::from_secs((16 * 60 + 30) * 60)
        );
    }
}
