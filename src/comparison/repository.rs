use super::model::{
    ComparisonCredit, ComparisonCreditRow, ComparisonPerformance, ComparisonPerformancePage,
    ComparisonPerformanceRow, ComparisonPiece, ComparisonPiecePerformer, ComparisonSector,
};
use crate::db::DbPool;
use sqlx::{FromRow, MySql, QueryBuilder, Transaction};
use std::{collections::HashMap, error::Error, fmt};

const DEFAULT_PAGE_SIZE: u32 = 20;
const MAX_PAGE_SIZE: u32 = 50;
/// 카탈로그 카드에 얼굴로 보여 줄 연주자 수
const CATALOG_PERFORMER_FACES: usize = 4;

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
    PublicationGateNotSatisfied,
    InvalidPublishTransition,
}

impl fmt::Display for ComparisonContractError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
            Self::InvalidCursor => formatter.write_str("유효하지 않은 페이지 커서"),
            Self::ClipNotReady => formatter.write_str("검증된 현재 클립 자산이 없음"),
            Self::PublicationGateNotSatisfied => {
                formatter.write_str("시드 performance의 권리 또는 편집 승인 조건이 충족되지 않음")
            }
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

#[derive(Debug, FromRow)]
struct PublicationState {
    publish_status: String,
    clip_id: u64,
    sector_id: i32,
    performance_source_id: u64,
    start_ms: u32,
    end_ms: u32,
    availability_status: String,
    rights_mode: String,
    sector_editorial_status: String,
    origin: String,
    editor_locked: bool,
}

fn allows_self_hosted_publication(rights_mode: &str) -> bool {
    matches!(
        rights_mode,
        "licensed_self_hosted" | "public_domain" | "permission_granted"
    )
}

/// 사용자에게 공개할 수 있는 비교 연주와 섹터.
///
/// `ready_performance`는 발행됐고 현재 클립이 준비됐으며 편집 승인된 섹터에 속한 연주다.
/// `public_sector`는 그 집합에서 서로 다른 primary artist가 3명 이상인 섹터다.
/// 곡 비교 화면과 아티스트 상세가 같은 기준을 쓰도록 세 조회가 이 CTE를 공유한다.
pub const PUBLIC_COMPARISON_CTE: &str = "WITH ready_performance AS (
        SELECT p.id,
               p.sector_id,
               p.piece_id,
               p.performance_source_id,
               p.start_ms,
               p.end_ms,
               clip.public_url AS clip_url
        FROM performances p
        JOIN performance_sectors sector
          ON sector.id = p.sector_id
         AND sector.piece_id = p.piece_id
        JOIN clip_assets clip
          ON clip.performance_id = p.id
         AND clip.is_current = TRUE
         AND clip.status IN ('READY', 'PUBLISHED')
         AND clip.public_url IS NOT NULL
         AND clip.public_url <> ''
        WHERE p.publish_status = 'PUBLISHED'
          AND p.performance_source_id IS NOT NULL
          AND p.start_ms IS NOT NULL
          AND p.end_ms IS NOT NULL
          AND sector.editorial_status IN ('EDITOR_REVIEWED', 'PUBLISHED')
    ),
    public_sector AS (
        SELECT ready.sector_id,
               COUNT(DISTINCT ready.id) AS ready_performance_count,
               COUNT(DISTINCT credit.artist_id) AS primary_artist_count
        FROM ready_performance ready
        LEFT JOIN performance_credits credit
          ON credit.performance_source_id = ready.performance_source_id
         AND credit.is_primary = TRUE
        GROUP BY ready.sector_id
        HAVING COUNT(DISTINCT credit.artist_id) >= 3
    )";

const PUBLIC_PERFORMANCE_SELECT: &str = "SELECT ready.id,
            source.id AS source_id,
            ready.sector_id,
            ready.piece_id,
            piece.title AS piece_title,
            composer.id AS composer_id,
            composer.name AS composer_name,
            COALESCE(sector.name_ko, sector.sector_name) AS sector_name,
            ready.start_ms,
            ready.end_ms,
            'ready' AS clip_status,
            ready.clip_url,
            CAST(source.provider_video_id AS CHAR CHARACTER SET utf8mb4) AS video_id
     FROM ready_performance ready
     JOIN public_sector ON public_sector.sector_id = ready.sector_id
     JOIN performance_sources source ON source.id = ready.performance_source_id
     JOIN performance_sectors sector ON sector.id = ready.sector_id
     JOIN pieces piece ON piece.id = ready.piece_id
     JOIN composers composer ON composer.id = piece.composer_id";

impl ComparisonRepository {
    /// 비교 카탈로그. 연주자 수가 많은 작품부터, 같으면 공개 섹터가 많은 작품부터.
    /// `composer_id`가 있으면 그 작곡가의 작품만 준다.
    pub async fn find_public_pieces(
        pool: &DbPool,
        composer_id: Option<i32>,
        offset: i64,
        limit: i64,
    ) -> Result<Vec<ComparisonPiece>, ComparisonContractError> {
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT piece.id AS piece_id,
                    piece.title AS piece_title,
                    piece.opus_number,
                    composer.id AS composer_id,
                    composer.name AS composer_name,
                    composer.avatar_url AS composer_avatar_url,
                    COUNT(DISTINCT public_sector.sector_id) AS sector_count,
                    COUNT(DISTINCT credit.artist_id) AS performer_count
             FROM public_sector
             JOIN performance_sectors sector ON sector.id = public_sector.sector_id
             JOIN pieces piece ON piece.id = sector.piece_id
             JOIN composers composer ON composer.id = piece.composer_id
             JOIN ready_performance ready ON ready.sector_id = public_sector.sector_id
             LEFT JOIN performance_credits credit
               ON credit.performance_source_id = ready.performance_source_id
              AND credit.is_primary = TRUE
             WHERE (? IS NULL OR composer.id = ?)
             GROUP BY piece.id, piece.title, piece.opus_number,
                      composer.id, composer.name, composer.avatar_url
             ORDER BY performer_count DESC, sector_count DESC, piece.id ASC
             LIMIT ? OFFSET ?"
        );
        let mut pieces = sqlx::query_as::<_, ComparisonPiece>(&sql)
            .bind(composer_id)
            .bind(composer_id)
            .bind(limit)
            .bind(offset)
            .fetch_all(pool)
            .await?;
        if pieces.is_empty() {
            return Ok(pieces);
        }

        let mut builder = QueryBuilder::<MySql>::new(format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT DISTINCT ready.piece_id, artist.id AS artist_id,
                    artist.name AS artist_name, artist.image_url
             FROM ready_performance ready
             JOIN public_sector ON public_sector.sector_id = ready.sector_id
             JOIN performance_credits credit
               ON credit.performance_source_id = ready.performance_source_id
              AND credit.is_primary = TRUE
             JOIN artists artist ON artist.id = credit.artist_id
             WHERE ready.piece_id IN ("
        ));
        let mut separated = builder.separated(", ");
        for piece in &pieces {
            separated.push_bind(piece.piece_id);
        }
        builder.push(") ORDER BY ready.piece_id, artist.id");
        let performers = builder
            .build_query_as::<ComparisonPiecePerformer>()
            .fetch_all(pool)
            .await?;

        let mut by_piece: HashMap<i32, Vec<ComparisonPiecePerformer>> = HashMap::new();
        for performer in performers {
            let list = by_piece.entry(performer.piece_id).or_default();
            if list.len() < CATALOG_PERFORMER_FACES {
                list.push(performer);
            }
        }
        for piece in &mut pieces {
            piece.performers = by_piece.remove(&piece.piece_id).unwrap_or_default();
        }
        Ok(pieces)
    }

    pub async fn find_published_by_artist(
        pool: &DbPool,
        artist_id: i32,
        page: ComparisonPageRequest,
    ) -> Result<ComparisonPerformancePage, ComparisonContractError> {
        let fetch_limit = page.limit.saturating_add(1);
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             {PUBLIC_PERFORMANCE_SELECT}
             WHERE EXISTS (
                   SELECT 1
                   FROM performance_credits requested_credit
                   WHERE requested_credit.performance_source_id = source.id
                     AND requested_credit.artist_id = ?
               )
               AND (? IS NULL OR ready.id < ?)
             ORDER BY ready.id DESC
             LIMIT ?"
        );
        let mut rows = sqlx::query_as::<_, ComparisonPerformanceRow>(&sql)
            .bind(artist_id)
            .bind(page.cursor)
            .bind(page.cursor)
            .bind(fetch_limit)
            .fetch_all(pool)
            .await?;

        let has_more = rows.len() > page.limit as usize;
        rows.truncate(page.limit as usize);

        let items = Self::attach_credits(pool, rows).await?;
        let next_cursor = has_more
            .then(|| items.last().map(|item| item.id.to_string()))
            .flatten();

        Ok(ComparisonPerformancePage { items, next_cursor })
    }

    /// 작품이 없으면 `None`, 작품은 있는데 공개 섹터가 없으면 빈 목록을 준다.
    pub async fn find_public_sectors_by_piece(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Option<Vec<ComparisonSector>>, ComparisonContractError> {
        let piece_exists =
            sqlx::query_scalar::<_, i64>("SELECT EXISTS(SELECT 1 FROM pieces WHERE id = ?)")
                .bind(piece_id)
                .fetch_one(pool)
                .await?
                == 1;
        if !piece_exists {
            return Ok(None);
        }

        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT sector.id,
                    sector.piece_id,
                    COALESCE(sector.name_ko, sector.sector_name) AS sector_name,
                    sector.name_en AS sector_name_en,
                    sector.description,
                    sector.display_order,
                    sector.measure_start,
                    sector.measure_end,
                    public_sector.ready_performance_count,
                    public_sector.primary_artist_count
             FROM public_sector
             JOIN performance_sectors sector ON sector.id = public_sector.sector_id
             WHERE sector.piece_id = ?
             ORDER BY sector.display_order ASC, sector.id ASC"
        );
        let sectors = sqlx::query_as::<_, ComparisonSector>(&sql)
            .bind(piece_id)
            .fetch_all(pool)
            .await?;

        Ok(Some(sectors))
    }

    /// 섹터가 없으면 `None`, 섹터는 있는데 공개 기준에 못 미치면 빈 목록을 준다.
    pub async fn find_public_performances_by_sector(
        pool: &DbPool,
        sector_id: i32,
    ) -> Result<Option<Vec<ComparisonPerformance>>, ComparisonContractError> {
        let sector_exists = sqlx::query_scalar::<_, i64>(
            "SELECT EXISTS(SELECT 1 FROM performance_sectors WHERE id = ?)",
        )
        .bind(sector_id)
        .fetch_one(pool)
        .await?
            == 1;
        if !sector_exists {
            return Ok(None);
        }

        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             {PUBLIC_PERFORMANCE_SELECT}
             WHERE ready.sector_id = ?
             ORDER BY ready.id ASC"
        );
        let rows = sqlx::query_as::<_, ComparisonPerformanceRow>(&sql)
            .bind(sector_id)
            .fetch_all(pool)
            .await?;

        Ok(Some(Self::attach_credits(pool, rows).await?))
    }

    async fn attach_credits(
        pool: &DbPool,
        rows: Vec<ComparisonPerformanceRow>,
    ) -> Result<Vec<ComparisonPerformance>, sqlx::Error> {
        let source_ids = rows.iter().map(|row| row.source_id).collect::<Vec<_>>();
        let credits_by_source = Self::find_credits_by_source_ids(pool, &source_ids).await?;

        Ok(rows
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
            .collect())
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

        let state = sqlx::query_as::<_, PublicationState>(
            "SELECT CAST(performance.publish_status AS CHAR CHARACTER SET utf8mb4) AS publish_status,
                    clip.id AS clip_id,
                    performance.sector_id,
                    performance.performance_source_id,
                    performance.start_ms,
                    performance.end_ms,
                    CAST(source.availability_status AS CHAR CHARACTER SET utf8mb4) AS availability_status,
                    CAST(source.rights_mode AS CHAR CHARACTER SET utf8mb4) AS rights_mode,
                    CAST(sector.editorial_status AS CHAR CHARACTER SET utf8mb4) AS sector_editorial_status,
                    CAST(performance.origin AS CHAR CHARACTER SET utf8mb4) AS origin,
                    performance.editor_locked
             FROM performances performance
             JOIN performance_sources source
               ON source.id = performance.performance_source_id
             JOIN performance_sectors sector
               ON sector.id = performance.sector_id
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

        if state.publish_status == "RETIRED" {
            return Err(ComparisonContractError::InvalidPublishTransition);
        }

        let self_hosted_rights = allows_self_hosted_publication(&state.rights_mode);
        let sector_is_approved = matches!(
            state.sector_editorial_status.as_str(),
            "EDITOR_REVIEWED" | "PUBLISHED"
        );
        if state.origin != "seed"
            || state.editor_locked
            || state.availability_status != "AVAILABLE"
            || !self_hosted_rights
            || !sector_is_approved
        {
            return Err(ComparisonContractError::PublicationGateNotSatisfied);
        }

        let candidate_status = sqlx::query_scalar::<_, String>(
            "SELECT CAST(candidate_status AS CHAR CHARACTER SET utf8mb4)
             FROM performance_candidates
             WHERE sector_id = ?
               AND performance_source_id = ?
               AND proposed_start_ms = ?
               AND proposed_end_ms = ?
             FOR UPDATE",
        )
        .bind(state.sector_id)
        .bind(state.performance_source_id)
        .bind(state.start_ms)
        .bind(state.end_ms)
        .fetch_optional(&mut **transaction)
        .await?;
        if candidate_status.as_deref() != Some("APPROVED") {
            return Err(ComparisonContractError::PublicationGateNotSatisfied);
        }

        if state.publish_status != "PUBLISHED" {
            let updated = sqlx::query(
                "UPDATE performances
                 SET publish_status = 'PUBLISHED'
                 WHERE id = ? AND publish_status IN ('DRAFT', 'READY')
                   AND origin = 'seed' AND editor_locked = FALSE",
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
        .bind(state.clip_id)
        .execute(&mut **transaction)
        .await?;
        mutations += published.rows_affected();

        Ok(mutations)
    }
}

#[cfg(test)]
mod tests {
    use super::{allows_self_hosted_publication, ComparisonPageRequest};

    #[test]
    fn publication_rights_allow_only_self_hosted_modes() {
        for rights_mode in [
            "licensed_self_hosted",
            "public_domain",
            "permission_granted",
        ] {
            assert!(allows_self_hosted_publication(rights_mode));
        }
        for rights_mode in ["unknown", "youtube_embed_only"] {
            assert!(!allows_self_hosted_publication(rights_mode));
        }
    }

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
