use sqlx::MySqlPool;
use tokio::time::{sleep, Duration};
use chrono::{Local, Timelike};
use crate::logger::Logger;
use super::service::KopisService;

pub struct ConcertSyncScheduler;

impl ConcertSyncScheduler {
    /// 스케줄러 시작 (서버 시작 시 즉시 실행 + 매일 새벽 3시 실행)
    /// venue 동기화 이후에 실행되어야 함
    pub async fn start(pool: MySqlPool) {
        Logger::info("SCHEDULER", "Starting KOPIS concert sync scheduler");
        Logger::info("SCHEDULER", "Schedule: Immediate execution + Daily at 3:00 AM");

        // 서버 시작 시 즉시 1회 실행
        Logger::info("SCHEDULER", "Running initial concert sync...");
        Self::run_sync(&pool).await;

        // 백그라운드 태스크로 스케줄러 시작
        tokio::spawn(async move {
            loop {
                // 다음 실행 시간까지 대기
                let wait_duration = Self::calculate_wait_until_next_run();
                Logger::info(
                    "SCHEDULER",
                    &format!("Next concert sync scheduled in {} hours", wait_duration.as_secs() / 3600)
                );

                sleep(wait_duration).await;

                // 동기화 실행
                Self::run_sync(&pool).await;
            }
        });

        Logger::success("SCHEDULER", "Concert sync scheduler started successfully");
    }

    /// 동기화 실행 (공연 + 예매상황판 순위)
    async fn run_sync(pool: &MySqlPool) {
        Logger::info("SCHEDULER", "=== Starting scheduled concert sync ===");

        // 1. 공연 동기화
        match KopisService::sync_concerts(pool).await {
            Ok(result) => {
                Logger::success(
                    "SCHEDULER",
                    &format!(
                        "Concert sync completed: {} added, {} updated, {} errors",
                        result.added, result.updated, result.errors
                    ),
                );
            }
            Err(e) => {
                Logger::error("SCHEDULER", &format!("Concert sync failed: {}", e));
                // 공연 동기화 실패해도 순위 동기화는 시도
            }
        }

        // 2. 예매상황판 순위 동기화
        match KopisService::sync_boxoffice_rankings(pool).await {
            Ok(result) => {
                Logger::success(
                    "SCHEDULER",
                    &format!(
                        "Boxoffice sync completed: {} rankings added, {} errors",
                        result.added, result.errors
                    ),
                );
            }
            Err(e) => {
                Logger::error("SCHEDULER", &format!("Boxoffice sync failed: {}", e));
            }
        }

        Logger::info("SCHEDULER", "=== Scheduled concert sync completed ===");
    }

    /// 다음 새벽 3시까지 남은 시간 계산
    fn calculate_wait_until_next_run() -> Duration {
        let now = Local::now();
        let target_hour = 3u32;  // 새벽 3시

        // 오늘 새벽 3시
        let mut next_run = now.date_naive()
            .and_hms_opt(target_hour, 0, 0)
            .unwrap();

        // 현재 시각을 타임존 고려하여 NaiveDateTime으로 변환
        let now_naive = now.naive_local();

        // 이미 오늘 새벽 3시가 지났다면 내일 새벽 3시로 설정
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
    pub async fn trigger_sync(pool: &MySqlPool) -> Result<(super::service::SyncResult, super::service::SyncResult), String> {
        Logger::info("SCHEDULER", "Manual concert sync triggered");

        let concert_result = KopisService::sync_concerts(pool).await?;
        let boxoffice_result = KopisService::sync_boxoffice_rankings(pool).await?;

        Ok((concert_result, boxoffice_result))
    }
}
