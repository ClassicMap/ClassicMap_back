use super::model::{
    ComparisonCredit, ComparisonCreditRow, ComparisonPerformance, ComparisonPerformancePage,
    ComparisonPerformanceRow,
};
use crate::db::DbPool;
use sqlx::{MySql, QueryBuilder, Transaction};
use std::{collections::HashMap, error::Error, fmt};

const DEFAULT_PAGE_SIZE: u32 = 20;
const MAX_PAGE_SIZE: u32 = 50;

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ComparisonPageRequest {
    pub cursor: Option<i32>,
    pub limit: u32,
}

impl ComparisonPageRequest {
    pub fn parse(
        cursor: Option<&str>,
        limit: Option<u32>,
    ) -> Result<Self, ComparisonContractError> {
        let cursor = cursor
            .map(str::parse::<i32>)
            .transpose()
            .map_err(|_| ComparisonContractError::InvalidCursor)?;

        if cursor.is_some_and(|value| value <= 0) {
            return Err(ComparisonContractError::InvalidCursor);
        }

        Ok(Self {
            cursor,
            limit: limit.unwrap_or(DEFAULT_PAGE_SIZE).clamp(1, MAX_PAGE_SIZE),
        })
    }
}

#[derive(Debug)]
pub enum ComparisonContractError {
    Database(sqlx::Error),
    InvalidCursor,
    ClipNotReady,
    InvalidPublishTransition,
}

impl fmt::Display for ComparisonContractError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
            Self::InvalidCursor => formatter.write_str("유효하지 않은 페이지 커서"),
            Self::ClipNotReady => formatter.write_str("검증된 현재 클립 자산이 없음"),
            Self::InvalidPublishTransition => {
                formatter.write_str("performance를 발행할 수 없는 상태임")
            }
        }
    }
}

impl Error for ComparisonContractError {}

impl From<sqlx::Error> for ComparisonContractError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

pub struct ComparisonRepository;

impl ComparisonRepository {
    pub async fn find_published_by_artist(
        pool: &DbPool,
        artist_id: i32,
        page: ComparisonPageRequest,
    ) -> Result<ComparisonPerformancePage, ComparisonContractError> {
        let fetch_limit = page.limit.saturating_add(1);
        let mut rows = sqlx::query_as::<_, ComparisonPerformanceRow>(
            "SELECT p.id,
                    source.id AS source_id,
                    p.sector_id,
                    p.piece_id,
                    piece.title AS piece_title,
                    composer.id AS composer_id,
                    composer.name AS composer_name,
                    COALESCE(sector.name_ko, sector.sector_name) AS sector_name,
                    p.start_ms,
                    p.end_ms,
                    'ready' AS clip_status,
                    clip.public_url AS clip_url,
                    CAST(source.provider_video_id AS CHAR CHARACTER SET utf8mb4) AS video_id
             FROM performances p
             JOIN performance_sources source ON source.id = p.performance_source_id
             JOIN performance_sectors sector ON sector.id = p.sector_id
             JOIN pieces piece ON piece.id = p.piece_id
             JOIN composers composer ON composer.id = piece.composer_id
             JOIN clip_assets clip
               ON clip.performance_id = p.id
              AND clip.is_current = TRUE
              AND clip.status IN ('READY', 'PUBLISHED')
              AND clip.public_url IS NOT NULL
              AND clip.public_url <> ''
             WHERE p.publish_status = 'PUBLISHED'
               AND p.start_ms IS NOT NULL
               AND p.end_ms IS NOT NULL
               AND EXISTS (
                   SELECT 1
                   FROM performance_credits requested_credit
                   WHERE requested_credit.performance_source_id = source.id
                     AND requested_credit.artist_id = ?
               )
               AND (? IS NULL OR p.id < ?)
             ORDER BY p.id DESC
             LIMIT ?",
        )
        .bind(artist_id)
        .bind(page.cursor)
        .bind(page.cursor)
        .bind(fetch_limit)
        .fetch_all(pool)
        .await?;

        let has_more = rows.len() > page.limit as usize;
        rows.truncate(page.limit as usize);

        let source_ids = rows.iter().map(|row| row.source_id).collect::<Vec<_>>();
        let credits_by_source = Self::find_credits_by_source_ids(pool, &source_ids).await?;

        let items = rows
            .into_iter()
            .map(|row| {
                let credits = credits_by_source
                    .get(&row.source_id)
                    .cloned()
                    .unwrap_or_default();

                ComparisonPerformance {
                    id: row.id,
                    source_id: row.source_id,
                    sector_id: row.sector_id,
                    piece_id: row.piece_id,
                    piece_title: row.piece_title,
                    composer_id: row.composer_id,
                    composer_name: row.composer_name,
                    sector_name: row.sector_name,
                    start_ms: row.start_ms,
                    end_ms: row.end_ms,
                    clip_status: row.clip_status,
                    clip_url: row.clip_url,
                    video_id: row.video_id,
                    credits,
                }
            })
            .collect::<Vec<_>>();

        let next_cursor = has_more
            .then(|| items.last().map(|item| item.id.to_string()))
            .flatten();

        Ok(ComparisonPerformancePage { items, next_cursor })
    }

    async fn find_credits_by_source_ids(
        pool: &DbPool,
        source_ids: &[u64],
    ) -> Result<HashMap<u64, Vec<ComparisonCredit>>, sqlx::Error> {
        if source_ids.is_empty() {
            return Ok(HashMap::new());
        }

        let mut query = QueryBuilder::<MySql>::new(
            "SELECT credit.performance_source_id AS source_id,
                    credit.artist_id,
                    artist.name AS artist_name,
                    CASE
                        WHEN credit.role_code IN (
                            'soloist', 'conductor', 'orchestra', 'ensemble',
                            'accompanist', 'vocalist', 'other'
                        ) THEN CAST(credit.role_code AS CHAR CHARACTER SET utf8mb4)
                        WHEN credit.role_code = 'primary_performer' THEN
                            CASE
                                WHEN LOWER(artist.category) LIKE '%conductor%'
                                  OR artist.category LIKE '%지휘%'
                                    THEN 'conductor'
                                WHEN LOWER(artist.category) LIKE '%orchestra%'
                                  OR artist.category LIKE '%오케스트라%'
                                    THEN 'orchestra'
                                WHEN LOWER(artist.category) LIKE '%ensemble%'
                                  OR LOWER(artist.category) LIKE '%choir%'
                                  OR artist.category LIKE '%앙상블%'
                                  OR artist.category LIKE '%합창%'
                                    THEN 'ensemble'
                                WHEN LOWER(artist.category) LIKE '%soprano%'
                                  OR LOWER(artist.category) LIKE '%tenor%'
                                  OR LOWER(artist.category) LIKE '%baritone%'
                                  OR LOWER(artist.category) LIKE '%mezzo%'
                                  OR LOWER(artist.category) LIKE '%vocal%'
                                  OR artist.category LIKE '%성악%'
                                    THEN 'vocalist'
                                ELSE 'soloist'
                            END
                        ELSE 'other'
                    END AS role,
                    credit.is_primary,
                    credit.display_order
             FROM performance_credits credit
             JOIN artists artist ON artist.id = credit.artist_id
             WHERE credit.performance_source_id IN (",
        );

        let mut separated = query.separated(", ");
        for source_id in source_ids {
            separated.push_bind(source_id);
        }
        separated.push_unseparated(
            ") ORDER BY credit.performance_source_id, credit.display_order, credit.id",
        );

        let rows = query
            .build_query_as::<ComparisonCreditRow>()
            .fetch_all(pool)
            .await?;

        let mut credits_by_source = HashMap::<u64, Vec<ComparisonCredit>>::new();
        for row in rows {
            credits_by_source
                .entry(row.source_id)
                .or_default()
                .push(row.into());
        }

        Ok(credits_by_source)
    }

    pub async fn publish_ready_performance(
        pool: &DbPool,
        performance_id: i32,
    ) -> Result<(), ComparisonContractError> {
        let mut transaction = pool.begin().await?;

        Self::publish_ready_performance_in_transaction(&mut transaction, performance_id).await?;

        transaction.commit().await?;
        Ok(())
    }

    pub(crate) async fn publish_ready_performance_in_transaction(
        transaction: &mut Transaction<'_, MySql>,
        performance_id: i32,
    ) -> Result<u64, ComparisonContractError> {
        let mut mutations = 0;

        let state = sqlx::query_as::<_, (String, u64)>(
            "SELECT performance.publish_status, clip.id
             FROM performances performance
             JOIN clip_assets clip
               ON clip.performance_id = performance.id
              AND clip.is_current = TRUE
              AND clip.status IN ('READY', 'PUBLISHED')
              AND clip.file_size > 0
              AND clip.duration_ms > 0
              AND clip.sha256 IS NOT NULL
              AND clip.ffprobe_result IS NOT NULL
              AND clip.range_verified = TRUE
              AND clip.public_url IS NOT NULL
              AND clip.public_url <> ''
             WHERE performance.id = ?
               AND performance.performance_source_id IS NOT NULL
             FOR UPDATE",
        )
        .bind(performance_id)
        .fetch_optional(&mut **transaction)
        .await?
        .ok_or(ComparisonContractError::ClipNotReady)?;

        if state.0 == "RETIRED" {
            return Err(ComparisonContractError::InvalidPublishTransition);
        }

        if state.0 != "PUBLISHED" {
            let updated = sqlx::query(
                "UPDATE performances
                 SET publish_status = 'PUBLISHED'
                 WHERE id = ? AND publish_status IN ('DRAFT', 'READY')",
            )
            .bind(performance_id)
            .execute(&mut **transaction)
            .await?;

            if updated.rows_affected() != 1 {
                return Err(ComparisonContractError::InvalidPublishTransition);
            }
            mutations += updated.rows_affected();
        }

        let published = sqlx::query(
            "UPDATE clip_assets
             SET status = 'PUBLISHED', published_at = COALESCE(published_at, CURRENT_TIMESTAMP(6))
             WHERE id = ? AND status <> 'PUBLISHED'",
        )
        .bind(state.1)
        .execute(&mut **transaction)
        .await?;
        mutations += published.rows_affected();

        Ok(mutations)
    }
}

#[cfg(test)]
mod tests {
    use super::ComparisonPageRequest;

    #[test]
    fn page_request_applies_safe_defaults_and_limits() {
        let default_page = ComparisonPageRequest::parse(None, None).expect("기본 페이지");
        assert_eq!(default_page.cursor, None);
        assert_eq!(default_page.limit, 20);

        let capped = ComparisonPageRequest::parse(Some("42"), Some(500)).expect("최대 제한");
        assert_eq!(capped.cursor, Some(42));
        assert_eq!(capped.limit, 50);

        let minimum = ComparisonPageRequest::parse(None, Some(0)).expect("최소 제한");
        assert_eq!(minimum.limit, 1);
    }

    #[test]
    fn page_request_rejects_invalid_cursor() {
        assert!(ComparisonPageRequest::parse(Some("not-a-number"), None).is_err());
        assert!(ComparisonPageRequest::parse(Some("0"), None).is_err());
        assert!(ComparisonPageRequest::parse(Some("-1"), None).is_err());
    }
}
