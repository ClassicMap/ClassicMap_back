//! 시드 실행 하나를 발행 직전 상태로 올린다.
//!
//! 지금까지는 배치마다 `approve` 마이그레이션을 손으로 써서 롤아웃 때 적용했다.
//! 그 방식은 클러스터 안에서 적재할 때 순서가 뒤집힌다 — 롤아웃이 먼저이고 적재가
//! 나중이라, 마이그레이션이 아직 없는 행을 UPDATE 해 아무 일도 하지 않고 끝난다.
//! sqlx 는 마이그레이션을 한 번만 실행하므로 그 뒤로는 영영 적용되지 않는다.
//!
//! 세 UPDATE 는 스키마 변경이 아니라 상태 전이라서 애초에 마이그레이션에 있을
//! 물건이 아니었다. 여기로 옮기고 **시드 실행 id 로 범위를 한정한다.**
//! 판단 근거는 배치 폴더의 `review-report.md` 에 남긴다.

use serde::Serialize;
use sqlx::{MySql, Pool};
use std::fmt;

/// 상태 전이 결과. 각 값은 실제로 바뀐 행 수다.
#[derive(Debug, Default, Serialize, PartialEq, Eq)]
#[serde(rename_all = "camelCase")]
pub struct SeedApprovalReport {
    pub run_id: String,
    pub dry_run: bool,
    pub rights_mode_updated: u64,
    pub sectors_reviewed: u64,
    pub candidates_approved: u64,
}

impl SeedApprovalReport {
    pub fn total(&self) -> u64 {
        self.rights_mode_updated + self.sectors_reviewed + self.candidates_approved
    }
}

#[derive(Debug)]
pub enum SeedApprovalError {
    UnknownRun(String),
    EmptyRun(String),
    Database(sqlx::Error),
}

impl SeedApprovalError {
    pub fn code(&self) -> &'static str {
        match self {
            Self::UnknownRun(_) => "UNKNOWN_SEED_RUN",
            Self::EmptyRun(_) => "EMPTY_SEED_RUN",
            Self::Database(_) => "DATABASE_ERROR",
        }
    }
}

impl fmt::Display for SeedApprovalError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::UnknownRun(run_id) => {
                write!(formatter, "시드 실행 id 가 seed_runs 에 없음: {run_id}")
            }
            Self::EmptyRun(run_id) => {
                write!(formatter, "시드 실행에 clip_jobs 가 없음: {run_id}")
            }
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
        }
    }
}

impl std::error::Error for SeedApprovalError {}

impl From<sqlx::Error> for SeedApprovalError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// `dry_run` 이면 바뀔 행을 세기만 하고 쓰지 않는다.
pub async fn approve_seed_run(
    pool: &Pool<MySql>,
    run_id: &str,
    dry_run: bool,
) -> Result<SeedApprovalReport, SeedApprovalError> {
    let known: Option<i64> = sqlx::query_scalar("SELECT 1 FROM seed_runs WHERE id = ?")
        .bind(run_id)
        .fetch_optional(pool)
        .await?;
    if known.is_none() {
        return Err(SeedApprovalError::UnknownRun(run_id.to_string()));
    }

    let jobs: i64 = sqlx::query_scalar("SELECT COUNT(*) FROM clip_jobs WHERE seed_run_id = ?")
        .bind(run_id)
        .fetch_one(pool)
        .await?;
    if jobs == 0 {
        return Err(SeedApprovalError::EmptyRun(run_id.to_string()));
    }

    let mut report = SeedApprovalReport {
        run_id: run_id.to_string(),
        dry_run,
        ..Default::default()
    };

    let mut transaction = pool.begin().await?;

    // 권리 표기. licensed_self_hosted 는 내부 검증 표기일 뿐 실제 이용 허락이 아니다.
    report.rights_mode_updated = run_step(
        &mut transaction,
        dry_run,
        "SELECT COUNT(*) FROM performance_sources source
         WHERE source.rights_mode = 'unknown'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.performance_source_id = source.id
                 AND job.seed_run_id = ?
           )",
        "UPDATE performance_sources source
         SET source.rights_mode = 'licensed_self_hosted',
             source.last_checked_at = CURRENT_TIMESTAMP(6)
         WHERE source.rights_mode = 'unknown'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.performance_source_id = source.id
                 AND job.seed_run_id = ?
           )",
        run_id,
    )
    .await?;

    report.sectors_reviewed = run_step(
        &mut transaction,
        dry_run,
        "SELECT COUNT(*) FROM performance_sectors sector
         WHERE sector.editorial_status = 'FACTS_VERIFIED'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.sector_id = sector.id
                 AND job.seed_run_id = ?
           )",
        "UPDATE performance_sectors sector
         SET sector.editorial_status = 'EDITOR_REVIEWED'
         WHERE sector.editorial_status = 'FACTS_VERIFIED'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.sector_id = sector.id
                 AND job.seed_run_id = ?
           )",
        run_id,
    )
    .await?;

    report.candidates_approved = run_step(
        &mut transaction,
        dry_run,
        "SELECT COUNT(*) FROM performance_candidates candidate
         WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.sector_id = candidate.sector_id
                 AND performance.performance_source_id = candidate.performance_source_id
                 AND performance.start_ms = candidate.proposed_start_ms
                 AND performance.end_ms = candidate.proposed_end_ms
                 AND job.seed_run_id = ?
           )",
        "UPDATE performance_candidates candidate
         SET candidate.candidate_status = 'APPROVED'
         WHERE candidate.candidate_status = 'REVIEW_REQUIRED'
           AND EXISTS (
               SELECT 1 FROM performances performance
               JOIN clip_jobs job ON job.performance_id = performance.id
               WHERE performance.sector_id = candidate.sector_id
                 AND performance.performance_source_id = candidate.performance_source_id
                 AND performance.start_ms = candidate.proposed_start_ms
                 AND performance.end_ms = candidate.proposed_end_ms
                 AND job.seed_run_id = ?
           )",
        run_id,
    )
    .await?;

    if dry_run {
        transaction.rollback().await?;
    } else {
        transaction.commit().await?;
    }

    Ok(report)
}

/// 편집 잠금을 건드리지 않도록 UPDATE 는 상태 값으로만 거른다. `editor_locked` 인
/// 행은 애초에 이 상태에 있지 않다 — 수동 데이터는 FACTS_VERIFIED 를 거치지 않는다.
async fn run_step(
    transaction: &mut sqlx::Transaction<'_, MySql>,
    dry_run: bool,
    count_sql: &str,
    update_sql: &str,
    run_id: &str,
) -> Result<u64, sqlx::Error> {
    if dry_run {
        let count: i64 = sqlx::query_scalar(count_sql)
            .bind(run_id)
            .fetch_one(&mut **transaction)
            .await?;
        return Ok(count as u64);
    }
    let result = sqlx::query(update_sql)
        .bind(run_id)
        .execute(&mut **transaction)
        .await?;
    Ok(result.rows_affected())
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn total_sums_three_steps() {
        let report = SeedApprovalReport {
            run_id: "run".to_string(),
            dry_run: false,
            rights_mode_updated: 9,
            sectors_reviewed: 3,
            candidates_approved: 9,
        };
        assert_eq!(report.total(), 21);
    }

    #[test]
    fn error_codes_are_stable() {
        assert_eq!(
            SeedApprovalError::UnknownRun("x".into()).code(),
            "UNKNOWN_SEED_RUN"
        );
        assert_eq!(
            SeedApprovalError::EmptyRun("x".into()).code(),
            "EMPTY_SEED_RUN"
        );
    }
}
