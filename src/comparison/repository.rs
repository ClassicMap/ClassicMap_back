use super::model::{
    note_moments, pair_moments, parse_json_list, ClipAlignment, ClipAlignmentRow, ComparisonCredit,
    ComparisonCreditRow, ComparisonPerformance, ComparisonPerformancePage,
    ComparisonPerformanceRow, ComparisonPiece, ComparisonPiecePerformer, ComparisonSector,
    FeaturedPair, FeaturedPairRow, ListeningNoteRow, LoudnessProfile, LoudnessProfileRow,
    PerformanceListeningNote, StoredMoment,
};
use crate::{db::DbPool, logger::Logger};
use sqlx::{FromRow, MySql, QueryBuilder, Transaction};
use std::{collections::HashMap, error::Error, fmt};

/// 이보다 덜 맞는 정렬 지도는 내보내지 않는다. 판이 다른 편곡(조옮김·편성)이 여기서 걸린다.
/// 시드 검증의 교차 정렬 임계(align.py COST_THRESHOLD)와 같다
const MAX_ALIGNMENT_COST: f64 = 0.11;

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
               COUNT(DISTINCT credit.artist_id) AS primary_artist_count,
               MIN(ready.start_ms) AS first_start_ms
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
                    sector.sector_type,
                    sector.description,
                    sector.display_order,
                    sector.measure_start,
                    sector.measure_end,
                    public_sector.ready_performance_count,
                    public_sector.primary_artist_count
             FROM public_sector
             JOIN performance_sectors sector ON sector.id = public_sector.sector_id
             WHERE sector.piece_id = ?
             ORDER BY sector.display_order ASC, public_sector.first_start_ms ASC, sector.id ASC"
        );
        let mut sectors = sqlx::query_as::<_, ComparisonSector>(&sql)
            .bind(piece_id)
            .fetch_all(pool)
            .await?;
        if sectors.is_empty() {
            return Ok(Some(sectors));
        }

        let mut pairs = Self::find_published_pairs_by_piece(pool, piece_id).await?;
        for sector in &mut sectors {
            sector.featured_pair = pairs.remove(&sector.id);
        }

        Ok(Some(sectors))
    }

    /// 확정된 추천 비교. 두 연주가 서로 다르고 둘 다 그 구간의 공개 연주일 때만 준다
    async fn find_published_pairs_by_piece(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<HashMap<i32, FeaturedPair>, sqlx::Error> {
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT pair.sector_id,
                    pair.performance_a_id,
                    pair.performance_b_id,
                    pair.title,
                    pair.note,
                    CAST(pair.moments AS CHAR CHARACTER SET utf8mb4) AS moments,
                    ready_a.start_ms AS a_start_ms,
                    ready_a.end_ms AS a_end_ms,
                    ready_b.start_ms AS b_start_ms,
                    ready_b.end_ms AS b_end_ms
             FROM sector_featured_pairs pair
             JOIN public_sector ON public_sector.sector_id = pair.sector_id
             JOIN ready_performance ready_a
               ON ready_a.id = pair.performance_a_id
              AND ready_a.sector_id = pair.sector_id
             JOIN ready_performance ready_b
               ON ready_b.id = pair.performance_b_id
              AND ready_b.sector_id = pair.sector_id
             WHERE pair.editorial_status = 'PUBLISHED'
               AND pair.performance_a_id <> pair.performance_b_id
               AND ready_a.piece_id = ?"
        );
        let rows = sqlx::query_as::<_, FeaturedPairRow>(&sql)
            .bind(piece_id)
            .fetch_all(pool)
            .await?;

        Ok(rows
            .into_iter()
            .map(|row| {
                let stored = parse_json_list::<StoredMoment>(row.moments.as_deref())
                    .unwrap_or_else(|error| {
                        Logger::warn(
                            "COMPARISON",
                            &format!(
                                "구간 {} 추천 비교의 들을 곳을 읽지 못함: {error}",
                                row.sector_id
                            ),
                        );
                        Vec::new()
                    });
                let moments = pair_moments(
                    stored,
                    [
                        (row.performance_a_id, row.a_start_ms, row.a_end_ms),
                        (row.performance_b_id, row.b_start_ms, row.b_end_ms),
                    ],
                );
                (
                    row.sector_id,
                    FeaturedPair {
                        performance_ids: [row.performance_a_id, row.performance_b_id],
                        title: row.title,
                        note: row.note,
                        moments,
                    },
                )
            })
            .collect())
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
        let performance_ids = rows.iter().map(|row| row.id).collect::<Vec<_>>();
        let mut notes = Self::find_published_notes(pool, &performance_ids).await?;
        let mut profiles = Self::find_current_loudness(pool, &performance_ids).await?;
        let mut alignments = Self::find_current_alignments(pool, &performance_ids).await?;

        Ok(rows
            .into_iter()
            .map(|row| {
                let credits = credits_by_source
                    .get(&row.source_id)
                    .cloned()
                    .unwrap_or_default();
                let note = notes
                    .remove(&row.id)
                    .map(|note| Self::note_for_clip(note, row.start_ms, row.end_ms));

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
                    note,
                    loudness: profiles.remove(&row.id),
                    alignment: alignments.remove(&row.id),
                }
            })
            .collect())
    }

    /// 확정된 연주 노트
    async fn find_published_notes(
        pool: &DbPool,
        performance_ids: &[i32],
    ) -> Result<HashMap<i32, ListeningNoteRow>, sqlx::Error> {
        if performance_ids.is_empty() {
            return Ok(HashMap::new());
        }

        let mut query = QueryBuilder::<MySql>::new(
            "SELECT note.performance_id,
                    note.headline,
                    note.note,
                    CAST(note.moments AS CHAR CHARACTER SET utf8mb4) AS moments,
                    CAST(note.facts AS CHAR CHARACTER SET utf8mb4) AS facts
             FROM performance_listening_notes note
             WHERE note.editorial_status = 'PUBLISHED'
               AND note.performance_id IN (",
        );
        let mut separated = query.separated(", ");
        for performance_id in performance_ids {
            separated.push_bind(performance_id);
        }
        separated.push_unseparated(")");

        let rows = query
            .build_query_as::<ListeningNoteRow>()
            .fetch_all(pool)
            .await?;
        Ok(rows
            .into_iter()
            .map(|row| (row.performance_id, row))
            .collect())
    }

    /// 지금 클립을 잰 음량 곡선. 잰 파일의 해시가 지금 클립과 같을 때만 준다
    async fn find_current_loudness(
        pool: &DbPool,
        performance_ids: &[i32],
    ) -> Result<HashMap<i32, LoudnessProfile>, sqlx::Error> {
        if performance_ids.is_empty() {
            return Ok(HashMap::new());
        }

        let mut query = QueryBuilder::<MySql>::new(
            "SELECT clip.performance_id,
                    profile.step_ms,
                    CAST(profile.curve_rel_db AS CHAR CHARACTER SET utf8mb4) AS curve_rel_db,
                    CAST(profile.start_rel_db AS DOUBLE) AS start_rel_db,
                    profile.peak_ms,
                    CAST(profile.peak_ratio AS DOUBLE) AS peak_ratio,
                    CAST(profile.range_db AS DOUBLE) AS range_db
             FROM clip_loudness_profiles profile
             JOIN clip_assets clip
               ON clip.id = profile.clip_asset_id
              AND clip.is_current = TRUE
              AND clip.sha256 = profile.clip_sha256
             WHERE clip.performance_id IN (",
        );
        let mut separated = query.separated(", ");
        for performance_id in performance_ids {
            separated.push_bind(performance_id);
        }
        separated.push_unseparated(")");

        let rows = query
            .build_query_as::<LoudnessProfileRow>()
            .fetch_all(pool)
            .await?;
        Ok(rows
            .into_iter()
            .filter_map(|row| {
                let curve = match serde_json::from_str::<Vec<f64>>(&row.curve_rel_db) {
                    Ok(curve) => curve,
                    Err(error) => {
                        Logger::warn(
                            "COMPARISON",
                            &format!("연주 {} 음량 곡선을 읽지 못함: {error}", row.performance_id),
                        );
                        return None;
                    }
                };
                Some((
                    row.performance_id,
                    LoudnessProfile {
                        step_ms: row.step_ms,
                        curve_rel_db: curve,
                        start_rel_db: row.start_rel_db,
                        peak_ms: row.peak_ms,
                        peak_ratio: row.peak_ratio,
                        range_db: row.range_db,
                    },
                ))
            })
            .collect())
    }

    /// 지금 클립의 정렬 지도. 이 클립과 기준 클립이 모두 지금 클립이고 해시가 같으며,
    /// 기준 연주가 같은 구간에 있고 비용이 임계 안일 때만 준다
    async fn find_current_alignments(
        pool: &DbPool,
        performance_ids: &[i32],
    ) -> Result<HashMap<i32, ClipAlignment>, sqlx::Error> {
        if performance_ids.is_empty() {
            return Ok(HashMap::new());
        }

        let mut query = QueryBuilder::<MySql>::new(
            "SELECT clip.performance_id,
                    reference.performance_id AS reference_performance_id,
                    alignment.step_ms,
                    CAST(alignment.positions_ms AS CHAR CHARACTER SET utf8mb4) AS positions_ms
             FROM clip_alignments alignment
             JOIN clip_assets clip
               ON clip.id = alignment.clip_asset_id
              AND clip.is_current = TRUE
              AND clip.sha256 = alignment.clip_sha256
             JOIN clip_assets reference
               ON reference.id = alignment.reference_clip_asset_id
              AND reference.is_current = TRUE
              AND reference.sha256 = alignment.reference_clip_sha256
             JOIN performances performance ON performance.id = clip.performance_id
             JOIN performances reference_performance
               ON reference_performance.id = reference.performance_id
              AND reference_performance.sector_id = performance.sector_id
             WHERE alignment.cost <= ",
        );
        query.push_bind(MAX_ALIGNMENT_COST);
        query.push(" AND clip.performance_id IN (");
        let mut separated = query.separated(", ");
        for performance_id in performance_ids {
            separated.push_bind(performance_id);
        }
        separated.push_unseparated(")");

        let rows = query
            .build_query_as::<ClipAlignmentRow>()
            .fetch_all(pool)
            .await?;
        Ok(rows
            .into_iter()
            .filter_map(|row| {
                let positions = match serde_json::from_str::<Vec<u32>>(&row.positions_ms) {
                    Ok(positions) => positions,
                    Err(error) => {
                        Logger::warn(
                            "COMPARISON",
                            &format!("연주 {} 정렬 지도를 읽지 못함: {error}", row.performance_id),
                        );
                        return None;
                    }
                };
                Some((
                    row.performance_id,
                    ClipAlignment {
                        reference_performance_id: row.reference_performance_id,
                        step_ms: row.step_ms,
                        positions_ms: positions,
                    },
                ))
            })
            .collect())
    }

    /// 들을 곳을 클립 기준으로 바꾼다. 모양이 틀린 JSON 은 그 칸만 비우고 남긴다
    fn note_for_clip(
        row: ListeningNoteRow,
        start_ms: u32,
        end_ms: u32,
    ) -> PerformanceListeningNote {
        let warn = |field: &str, error: serde_json::Error| {
            Logger::warn(
                "COMPARISON",
                &format!(
                    "연주 {} 노트의 {field} 를 읽지 못함: {error}",
                    row.performance_id
                ),
            );
        };
        let moments =
            parse_json_list::<StoredMoment>(row.moments.as_deref()).unwrap_or_else(|error| {
                warn("moments", error);
                Vec::new()
            });
        let facts = parse_json_list::<String>(row.facts.as_deref()).unwrap_or_else(|error| {
            warn("facts", error);
            Vec::new()
        });
        PerformanceListeningNote {
            headline: row.headline,
            body: row.note,
            moments: note_moments(moments, start_ms, end_ms),
            facts,
        }
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
                    artist.image_url,
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
