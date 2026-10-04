use std::collections::{HashMap, HashSet};

use sqlx::{FromRow, MySql, QueryBuilder};

use super::model::{
    ListeningEventBatch, ListeningEventResult, OnboardingPiece, OnboardingState, TasteInput,
    TasteProfile,
};
use super::recommend::{Candidate, History};
use crate::comparison::repository::{ComparisonRepository, PUBLIC_COMPARISON_CTE};
use crate::db::DbPool;

/// 추천 후보는 비교 작품 전체다. 카탈로그가 이보다 커지면 미리 걸러야 한다
const MAX_CANDIDATES: i64 = 1_000;
/// 이 기간 안의 기록만 추천에 쓴다. 관심 없음은 기간과 상관없이 쓴다
const HISTORY_DAYS: i64 = 180;
const RECENT_DAYS: i64 = 7;

#[derive(Debug, FromRow)]
struct ProfileRow {
    listening_level: Option<String>,
    sounds: String,
    instrument: Option<String>,
    favorite_periods: String,
    onboarding_status: Option<String>,
    onboarding_version: Option<u16>,
    history_enabled: bool,
}

#[derive(Debug, FromRow)]
struct FeatureRow {
    piece_id: i32,
    period: String,
    lead_sound: Option<String>,
    ensemble_scale: Option<String>,
    familiarity: Option<String>,
    start_sector_id: Option<i32>,
}

#[derive(Debug, FromRow)]
struct SectorRow {
    piece_id: i32,
    sector_id: i32,
    sector_name: String,
}

#[derive(Debug, FromRow)]
struct ArtistRow {
    piece_id: i32,
    artist_id: i32,
    artist_name: String,
}

#[derive(Debug, FromRow)]
struct HistoryRow {
    piece_id: i32,
    finished: i64,
    skipped: i64,
    recent: i64,
    not_interested: i64,
}

fn parse_list(raw: &str) -> Vec<String> {
    serde_json::from_str(raw).unwrap_or_default()
}

fn to_json(values: &[String]) -> Result<String, sqlx::Error> {
    serde_json::to_string(values)
        .map_err(|error| sqlx::Error::Protocol(format!("목록 직렬화 실패: {error}")))
}

pub struct TasteRepository;

impl TasteRepository {
    pub async fn find_profile(pool: &DbPool, user_id: i32) -> Result<TasteProfile, sqlx::Error> {
        let row = sqlx::query_as::<_, ProfileRow>(
            "SELECT listening_level,
                    CAST(sounds AS CHAR CHARACTER SET utf8mb4) AS sounds,
                    instrument,
                    CAST(favorite_periods AS CHAR CHARACTER SET utf8mb4) AS favorite_periods,
                    onboarding_status,
                    onboarding_version,
                    history_enabled
             FROM user_taste_profiles
             WHERE user_id = ?",
        )
        .bind(user_id)
        .fetch_optional(pool)
        .await?;
        let Some(row) = row else {
            return Ok(TasteProfile::default());
        };
        let seed_piece_ids = sqlx::query_scalar::<_, i32>(
            "SELECT piece_id FROM user_taste_seed_pieces WHERE user_id = ? ORDER BY created_at, piece_id",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await?;
        Ok(TasteProfile {
            listening_level: row.listening_level,
            sounds: parse_list(&row.sounds),
            instrument: row.instrument,
            favorite_periods: parse_list(&row.favorite_periods),
            seed_piece_ids,
            onboarding: OnboardingState {
                status: row.onboarding_status,
                version: row.onboarding_version,
            },
            history_enabled: row.history_enabled,
        })
    }

    /// 답 전체를 바꾼다. 온보딩 상태와 기록 설정은 요청에 있을 때만 바꾼다
    pub async fn save_profile(
        pool: &DbPool,
        user_id: i32,
        input: &TasteInput,
    ) -> Result<(), sqlx::Error> {
        let mut transaction = pool.begin().await?;
        sqlx::query(
            "INSERT INTO user_taste_profiles
                 (user_id, listening_level, sounds, instrument, favorite_periods,
                  onboarding_status, onboarding_version, onboarding_at, history_enabled)
             VALUES (?, ?, CAST(? AS JSON), ?, CAST(? AS JSON), ?, ?,
                     IF(? IS NULL, NULL, CURRENT_TIMESTAMP(6)), COALESCE(?, TRUE))
             ON DUPLICATE KEY UPDATE
                 listening_level = VALUES(listening_level),
                 sounds = VALUES(sounds),
                 instrument = VALUES(instrument),
                 favorite_periods = VALUES(favorite_periods),
                 onboarding_status = COALESCE(VALUES(onboarding_status), onboarding_status),
                 onboarding_version = COALESCE(VALUES(onboarding_version), onboarding_version),
                 onboarding_at = COALESCE(VALUES(onboarding_at), onboarding_at),
                 history_enabled = IF(? IS NULL, history_enabled, VALUES(history_enabled))",
        )
        .bind(user_id)
        .bind(&input.listening_level)
        .bind(to_json(&input.sounds)?)
        .bind(&input.instrument)
        .bind(to_json(&input.favorite_periods)?)
        .bind(
            input
                .onboarding
                .as_ref()
                .map(|onboarding| onboarding.status.clone()),
        )
        .bind(
            input
                .onboarding
                .as_ref()
                .map(|onboarding| onboarding.version),
        )
        .bind(
            input
                .onboarding
                .as_ref()
                .map(|onboarding| onboarding.status.clone()),
        )
        .bind(input.history_enabled)
        .bind(input.history_enabled)
        .execute(&mut *transaction)
        .await?;

        sqlx::query("DELETE FROM user_taste_seed_pieces WHERE user_id = ?")
            .bind(user_id)
            .execute(&mut *transaction)
            .await?;
        // 고른 순서를 지키려고 한 줄씩 넣는다. 없는 작품은 건너뛴다
        for (index, piece_id) in input.seed_piece_ids.iter().enumerate() {
            sqlx::query(
                "INSERT IGNORE INTO user_taste_seed_pieces (user_id, piece_id, created_at)
                 SELECT ?, id, TIMESTAMPADD(MICROSECOND, ?, CURRENT_TIMESTAMP(6))
                 FROM pieces WHERE id = ?",
            )
            .bind(user_id)
            .bind(index as i64)
            .bind(piece_id)
            .execute(&mut *transaction)
            .await?;
        }
        transaction.commit().await
    }

    pub async fn find_onboarding_pieces(
        pool: &DbPool,
    ) -> Result<Vec<OnboardingPiece>, sqlx::Error> {
        sqlx::query_as::<_, OnboardingPiece>(&format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT piece.id AS piece_id,
                    piece.title AS piece_title,
                    composer.id AS composer_id,
                    composer.name AS composer_name,
                    composer.avatar_url AS composer_avatar_url,
                    feature.lead_sound
             FROM piece_reco_features feature
             JOIN pieces piece ON piece.id = feature.piece_id
             JOIN composers composer ON composer.id = piece.composer_id
             WHERE feature.onboarding_order IS NOT NULL
               AND EXISTS (
                   SELECT 1 FROM public_sector
                   JOIN performance_sectors sector ON sector.id = public_sector.sector_id
                   WHERE sector.piece_id = piece.id
               )
             ORDER BY feature.onboarding_order"
        ))
        .fetch_all(pool)
        .await
    }

    /// 추천 후보: 공개 비교 작품 전체와 속성·첫 구간·주 연주자
    pub async fn find_candidates(pool: &DbPool) -> Result<Vec<Candidate>, sqlx::Error> {
        let pieces = ComparisonRepository::find_public_pieces(pool, None, 0, MAX_CANDIDATES)
            .await
            .map_err(|error| sqlx::Error::Protocol(format!("비교 작품을 읽지 못함: {error}")))?;
        if pieces.is_empty() {
            return Ok(Vec::new());
        }

        let mut builder = QueryBuilder::<MySql>::new(
            "SELECT piece.id AS piece_id,
                    CAST(composer.period AS CHAR CHARACTER SET utf8mb4) AS period,
                    feature.lead_sound,
                    feature.ensemble_scale,
                    feature.familiarity,
                    feature.start_sector_id
             FROM pieces piece
             JOIN composers composer ON composer.id = piece.composer_id
             LEFT JOIN piece_reco_features feature ON feature.piece_id = piece.id
             WHERE piece.id IN (",
        );
        let mut separated = builder.separated(", ");
        for piece in &pieces {
            separated.push_bind(piece.piece_id);
        }
        builder.push(")");
        let features: HashMap<i32, FeatureRow> = builder
            .build_query_as::<FeatureRow>()
            .fetch_all(pool)
            .await?
            .into_iter()
            .map(|row| (row.piece_id, row))
            .collect();

        let sectors = sqlx::query_as::<_, SectorRow>(&format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT sector.piece_id,
                    sector.id AS sector_id,
                    COALESCE(sector.name_ko, sector.sector_name) AS sector_name
             FROM public_sector
             JOIN performance_sectors sector ON sector.id = public_sector.sector_id"
        ))
        .fetch_all(pool)
        .await?;
        let public_sectors: HashMap<i32, (i32, String)> = sectors
            .into_iter()
            .map(|row| (row.sector_id, (row.piece_id, row.sector_name)))
            .collect();

        let artists = sqlx::query_as::<_, ArtistRow>(&format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT DISTINCT ready.piece_id, artist.id AS artist_id, artist.name AS artist_name
             FROM ready_performance ready
             JOIN public_sector ON public_sector.sector_id = ready.sector_id
             JOIN performance_credits credit
               ON credit.performance_source_id = ready.performance_source_id
              AND credit.is_primary = TRUE
             JOIN artists artist ON artist.id = credit.artist_id
             ORDER BY ready.piece_id, artist.id"
        ))
        .fetch_all(pool)
        .await?;
        let mut artists_by_piece: HashMap<i32, Vec<(i32, String)>> = HashMap::new();
        for row in artists {
            artists_by_piece
                .entry(row.piece_id)
                .or_default()
                .push((row.artist_id, row.artist_name));
        }

        Ok(pieces
            .into_iter()
            .map(|piece| {
                let feature = features.get(&piece.piece_id);
                let start_sector = feature
                    .and_then(|feature| feature.start_sector_id)
                    .and_then(|sector_id| {
                        public_sectors
                            .get(&sector_id)
                            .filter(|(piece_id, _)| *piece_id == piece.piece_id)
                            .map(|(_, name)| (sector_id, name.clone()))
                    });
                Candidate {
                    period: feature
                        .map(|feature| feature.period.clone())
                        .unwrap_or_default(),
                    lead_sound: feature.and_then(|feature| feature.lead_sound.clone()),
                    scale: feature.and_then(|feature| feature.ensemble_scale.clone()),
                    familiarity: feature.and_then(|feature| feature.familiarity.clone()),
                    start_sector,
                    artists: artists_by_piece.remove(&piece.piece_id).unwrap_or_default(),
                    piece,
                }
            })
            .collect())
    }

    pub async fn find_favorite_ids(
        pool: &DbPool,
        user_id: i32,
    ) -> Result<(HashSet<i32>, HashSet<i32>, HashSet<i32>), sqlx::Error> {
        let composers = sqlx::query_scalar::<_, i32>(
            "SELECT composer_id FROM user_favorite_composers WHERE user_id = ?",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await?;
        let artists = sqlx::query_scalar::<_, i32>(
            "SELECT artist_id FROM user_favorite_artists WHERE user_id = ?",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await?;
        let pieces = sqlx::query_scalar::<_, i32>(
            "SELECT piece_id FROM user_favorite_pieces WHERE user_id = ?",
        )
        .bind(user_id)
        .fetch_all(pool)
        .await?;
        Ok((
            composers.into_iter().collect(),
            artists.into_iter().collect(),
            pieces.into_iter().collect(),
        ))
    }

    /// 기록을 끈 사람은 관심 없음만 쓴다
    pub async fn find_history(
        pool: &DbPool,
        user_id: i32,
        history_enabled: bool,
    ) -> Result<History, sqlx::Error> {
        let rows = sqlx::query_as::<_, HistoryRow>(
            "SELECT piece_id,
                    CAST(SUM(kind = 'finish') AS SIGNED) AS finished,
                    CAST(SUM(kind = 'skip') AS SIGNED) AS skipped,
                    CAST(MAX(kind = 'open' AND created_at > NOW(6) - INTERVAL ? DAY) AS SIGNED) AS recent,
                    CAST(MAX(kind = 'not_interested') AS SIGNED) AS not_interested
             FROM user_listening_events
             WHERE user_id = ?
               AND (kind = 'not_interested'
                    OR (? AND created_at > NOW(6) - INTERVAL ? DAY))
             GROUP BY piece_id",
        )
        .bind(RECENT_DAYS)
        .bind(user_id)
        .bind(history_enabled)
        .bind(HISTORY_DAYS)
        .fetch_all(pool)
        .await?;
        let mut history = History::default();
        for row in rows {
            if row.finished > 0 {
                history.finished.insert(row.piece_id, row.finished as u32);
            }
            if row.skipped > 0 {
                history.skipped.insert(row.piece_id, row.skipped as u32);
            }
            if row.recent > 0 {
                history.recent.insert(row.piece_id);
            }
            if row.not_interested > 0 {
                history.not_interested.insert(row.piece_id);
            }
        }
        Ok(history)
    }

    /// 기록을 끈 사람에게서는 관심 없음만 받는다. 없는 작품·구간·연주를 가리키는 줄은 버린다
    pub async fn insert_events(
        pool: &DbPool,
        user_id: i32,
        history_enabled: bool,
        batch: &ListeningEventBatch,
    ) -> Result<ListeningEventResult, sqlx::Error> {
        let mut accepted = 0;
        let mut ignored = 0;
        let mut transaction = pool.begin().await?;
        for event in &batch.events {
            if !history_enabled && event.kind != "not_interested" {
                ignored += 1;
                continue;
            }
            let result = sqlx::query(
                "INSERT INTO user_listening_events (user_id, piece_id, sector_id, performance_id, kind)
                 SELECT ?, piece.id,
                        (SELECT sector.id FROM performance_sectors sector
                         WHERE sector.id = ? AND sector.piece_id = piece.id),
                        (SELECT performance.id FROM performances performance
                         WHERE performance.id = ? AND performance.piece_id = piece.id),
                        ?
                 FROM pieces piece
                 WHERE piece.id = ?",
            )
            .bind(user_id)
            .bind(event.sector_id)
            .bind(event.performance_id)
            .bind(&event.kind)
            .bind(event.piece_id)
            .execute(&mut *transaction)
            .await?;
            if result.rows_affected() > 0 {
                accepted += 1;
            } else {
                ignored += 1;
            }
        }
        transaction.commit().await?;
        Ok(ListeningEventResult { accepted, ignored })
    }

    /// 작품과 종류를 주면 그것만, 안 주면 모두 지운다
    pub async fn delete_events(
        pool: &DbPool,
        user_id: i32,
        piece_id: Option<i32>,
        kind: Option<&str>,
    ) -> Result<u64, sqlx::Error> {
        let result = sqlx::query(
            "DELETE FROM user_listening_events
             WHERE user_id = ?
               AND (? IS NULL OR piece_id = ?)
               AND (? IS NULL OR kind = ?)",
        )
        .bind(user_id)
        .bind(piece_id)
        .bind(piece_id)
        .bind(kind)
        .bind(kind)
        .execute(pool)
        .await?;
        Ok(result.rows_affected())
    }
}
