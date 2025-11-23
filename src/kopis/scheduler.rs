use sqlx::MySqlPool;
use tokio::time::{sleep, Duration};
use chrono::{Local, Timelike};
use crate::logger::Logger;
use super::service::KopisService;

pub struct VenueSyncScheduler;

impl VenueSyncScheduler {
    /// 스케줄러 시작 (서버 시작 시 즉시 실행 + 매일 새벽 2시 실행)
    pub async fn start(pool: MySqlPool) {
        Logger::info("SCHEDULER", "Starting KOPIS venue sync scheduler");
        Logger::info("SCHEDULER", "Schedule: Immediate execution + Daily at 2:00 AM");

        // 서버 시작 시 즉시 1회 실행
        Logger::info("SCHEDULER", "Running initial venue sync...");
        Self::run_sync(&pool).await;

        // 백그라운드 태스크로 스케줄러 시작
        tokio::spawn(async move {
            loop {
                // 다음 실행 시간까지 대기
                let wait_duration = Self::calculate_wait_until_next_run();
                Logger::info(
                    "SCHEDULER",
                    &format!("Next venue sync scheduled in {} hours", wait_duration.as_secs() / 3600)
                );

                sleep(wait_duration).await;

                // 동기화 실행
                Self::run_sync(&pool).await;
            }
        });

        Logger::success("SCHEDULER", "Venue sync scheduler started successfully");
    }

    /// 동기화 실행
    async fn run_sync(pool: &MySqlPool) {
        Logger::info("SCHEDULER", "=== Starting scheduled venue sync ===");

        match KopisService::sync_venues(pool).await {
            Ok(result) => {
                Logger::success(
                    "SCHEDULER",
                    &format!(
                        "Sync completed successfully: {} added, {} updated, {} errors",
                        result.added, result.updated, result.errors
                    ),
                );
            }
            Err(e) => {
                Logger::error("SCHEDULER", &format!("Sync failed: {}", e));
            }
        }

        Logger::info("SCHEDULER", "=== Scheduled venue sync completed ===");
    }

    /// 다음 새벽 2시까지 남은 시간 계산
    fn calculate_wait_until_next_run() -> Duration {
        let now = Local::now();
        let target_hour = 2u32;  // 새벽 2시

        // 오늘 새벽 2시
        let mut next_run = now.date_naive()
            .and_hms_opt(target_hour, 0, 0)
            .unwrap();

        // 현재 시각을 타임존 고려하여 NaiveDateTime으로 변환
        let now_naive = now.naive_local();

        // 이미 오늘 새벽 2시가 지났다면 내일 새벽 2시로 설정
        if now_naive >= next_run {
            next_run = (now.date_naive() + chrono::Duration::days(1))
                .and_hms_opt(target_hour, 0, 0)
                .unwrap();
        }

        // 남은 시간 계산
        let duration = next_run.signed_duration_since(now_naive);
        let seconds = duration.num_seconds().max(0) as u64;

        Duration::from_secs(seconds)
    }

    /// 수동 동기화 트리거 (API 엔드포인트에서 호출 가능)
    pub async fn trigger_sync(pool: &MySqlPool) -> Result<super::service::SyncResult, String> {
        Logger::info("SCHEDULER", "Manual venue sync triggered");
        KopisService::sync_venues(pool).await
    }
}
