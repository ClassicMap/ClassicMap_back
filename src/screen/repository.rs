use serde_json::Value;
use sqlx::FromRow;
use std::collections::HashMap;

use super::model::{
    CueEvidence, CueListen, FeaturedScreenCue, OfficialClip, PieceScreenCue, ScreenCue,
    ScreenCueStill, ScreenStillCandidates, ScreenTitleDetail, ScreenTitlePage, ScreenTitleSummary,
    StreamingLinks,
};
use crate::{comparison::repository::PUBLIC_COMPARISON_CTE, db::DbPool, search::SearchText};

pub const MAX_PAGE_SIZE: u32 = 50;
const DEFAULT_PAGE_SIZE: u32 = 24;

/// 작품 대표 그림 클립. 작품에 정한 예고편이 먼저, 없으면 스포일러가 아닌 큐의 공식 클립
const COVER_CLIP_SQL: &str = "COALESCE(t.cover_clip,
    (SELECT cover.official_clip
     FROM screen_music_cues cover
     WHERE cover.screen_title_id = t.id AND cover.editorial_status = 'PUBLISHED'
       AND cover.official_clip IS NOT NULL
     ORDER BY cover.spoiler ASC, cover.display_order ASC, cover.id ASC
     LIMIT 1))";

/// 대표 그림 클립의 한 필드. 필드마다 같은 클립에서 읽어 영상 id 와 썸네일 화질이 어긋나지 않는다
fn cover_field_sql(field: &str) -> String {
    format!(
        "CAST(JSON_UNQUOTE(JSON_EXTRACT({COVER_CLIP_SQL}, '$.{field}')) AS CHAR CHARACTER SET utf8mb4)"
    )
}

/// 대표 그림 영상 id 와 썸네일 화질 열
fn cover_columns_sql() -> String {
    format!(
        "{} AS cover_video_id, {} AS cover_thumb_jpg, {} AS cover_thumb_webp",
        cover_field_sql("videoId"),
        cover_field_sql("thumbJpg"),
        cover_field_sql("thumbWebp")
    )
}

/// 공개된 작품이면서 공개된 큐가 하나 이상 있는 작품만 보인다
fn summary_select() -> String {
    let cover_columns = cover_columns_sql();
    let cover_channel = cover_field_sql("channel");
    format!(
        "SELECT t.id, CAST(t.slug AS CHAR CHARACTER SET utf8mb4) AS slug, t.kind, t.title_ko, t.title_original,
            t.release_year, t.country_code, t.credit_line, t.poster_path, t.backdrop_path,
            t.poster_url, t.poster_credit,
            (SELECT COUNT(*) FROM screen_music_cues cue
             WHERE cue.screen_title_id = t.id AND cue.editorial_status = 'PUBLISHED') AS cue_count,
            {cover_columns},
            {cover_channel} AS cover_channel
     FROM screen_titles t
     WHERE t.editorial_status = 'PUBLISHED'
       AND EXISTS (SELECT 1 FROM screen_music_cues cue
                   WHERE cue.screen_title_id = t.id AND cue.editorial_status = 'PUBLISHED')"
    )
}

const CUE_SELECT: &str = "SELECT c.id, c.display_order, c.episode_label, c.composer_id,
            c.composer_name, c.piece_id, c.work_title, c.part_label, c.sector_id, c.usage_kind,
            c.arranged, c.approx_at_sec, c.scene_note, c.spoiler,
            CAST(c.official_clip AS CHAR CHARACTER SET utf8mb4) AS official_clip,
            CAST(c.evidence AS CHAR CHARACTER SET utf8mb4) AS evidence,
            c.still_path, piece.apple_music_url, piece.spotify_url, piece.youtube_music_url
     FROM screen_music_cues c
     LEFT JOIN pieces piece ON piece.id = c.piece_id";

pub const KINDS: [&str; 3] = ["MOVIE", "SERIES", "ANIME"];

#[derive(Debug, FromRow)]
struct CueRow {
    id: u64,
    display_order: u16,
    episode_label: Option<String>,
    composer_id: Option<i32>,
    composer_name: String,
    piece_id: Option<i32>,
    work_title: String,
    part_label: Option<String>,
    sector_id: Option<i32>,
    usage_kind: String,
    arranged: bool,
    approx_at_sec: Option<u32>,
    scene_note: String,
    spoiler: bool,
    official_clip: Option<String>,
    evidence: String,
    still_path: Option<String>,
    apple_music_url: Option<String>,
    spotify_url: Option<String>,
    youtube_music_url: Option<String>,
}

#[derive(Debug, FromRow)]
struct PublicSectorRow {
    piece_id: i32,
    sector_id: i32,
    ready_performance_count: i64,
}

fn non_empty(value: Option<String>) -> Option<String> {
    value.filter(|value| !value.trim().is_empty())
}

/// 큐의 곡을 들을 길을 고른다. 같은 대목 구간 → 같은 곡 다른 구간 → 스트리밍 링크 순
fn listen_for(row: &CueRow, sectors: &HashMap<i32, Vec<(i32, i64)>>) -> CueListen {
    let piece_sectors = row.piece_id.and_then(|piece_id| sectors.get(&piece_id));
    if let (Some(sector_id), Some(piece_sectors)) = (row.sector_id, piece_sectors) {
        if let Some((_, count)) = piece_sectors.iter().find(|(id, _)| *id == sector_id) {
            return CueListen {
                kind: "sector",
                sector_id: Some(sector_id),
                ready_performance_count: Some(*count),
                links: None,
            };
        }
    }
    if piece_sectors.is_some_and(|sectors| !sectors.is_empty()) && row.composer_id.is_some() {
        return CueListen {
            kind: "piece",
            sector_id: None,
            ready_performance_count: None,
            links: None,
        };
    }
    let links = StreamingLinks {
        apple_music_url: non_empty(row.apple_music_url.clone()),
        spotify_url: non_empty(row.spotify_url.clone()),
        youtube_music_url: non_empty(row.youtube_music_url.clone()),
    };
    if row.piece_id.is_some() && links != StreamingLinks::default() {
        return CueListen {
            kind: "external",
            sector_id: None,
            ready_performance_count: None,
            links: Some(links),
        };
    }
    CueListen {
        kind: "none",
        sector_id: None,
        ready_performance_count: None,
        links: None,
    }
}

fn parse_clip(text: Option<&str>) -> Option<OfficialClip> {
    text.and_then(|text| serde_json::from_str::<OfficialClip>(text).ok())
}

/// 근거는 공개 기준을 넘긴 1·2차만 저장돼 있다. 모양이 다른 항목은 빼고 준다
fn parse_evidence(text: &str) -> Vec<CueEvidence> {
    match serde_json::from_str::<Value>(text) {
        Ok(Value::Array(items)) => items
            .into_iter()
            .filter_map(|item| serde_json::from_value::<CueEvidence>(item).ok())
            .collect(),
        _ => Vec::new(),
    }
}

fn page_bounds(offset: Option<u32>, limit: Option<u32>) -> (u32, u32) {
    let limit = limit.unwrap_or(DEFAULT_PAGE_SIZE).clamp(1, MAX_PAGE_SIZE);
    (offset.unwrap_or(0), limit)
}

fn page_from(mut items: Vec<ScreenTitleSummary>, limit: u32) -> ScreenTitlePage {
    let has_more = items.len() > limit as usize;
    items.truncate(limit as usize);
    ScreenTitlePage { items, has_more }
}

pub struct ScreenRepository;

impl ScreenRepository {
    pub async fn list_titles(
        pool: &DbPool,
        kind: Option<&str>,
        offset: Option<u32>,
        limit: Option<u32>,
    ) -> Result<ScreenTitlePage, sqlx::Error> {
        let (offset, limit) = page_bounds(offset, limit);
        let summary = summary_select();
        let sql = format!(
            "{summary}
               AND (? IS NULL OR t.kind = ?)
             ORDER BY t.display_order ASC, t.id ASC
             LIMIT ? OFFSET ?"
        );
        let items = sqlx::query_as::<_, ScreenTitleSummary>(&sql)
            .bind(kind)
            .bind(kind)
            .bind(limit + 1)
            .bind(offset)
            .fetch_all(pool)
            .await?;
        Ok(page_from(items, limit))
    }

    /// 제목(띄어쓰기 무시 포함)이나 나온 곡·작곡가·악장 이름으로 찾는다. 제목이 맞는 작품이 먼저다
    pub async fn search_titles(
        pool: &DbPool,
        query: &SearchText,
        kind: Option<&str>,
        offset: Option<u32>,
        limit: Option<u32>,
    ) -> Result<ScreenTitlePage, sqlx::Error> {
        let (offset, limit) = page_bounds(offset, limit);
        let summary = summary_select();
        let (relevance, relevance_binds) =
            query.name_relevance(&["t.title_ko", "t.title_original"]);
        let compact = format!(
            "%{}%",
            crate::search::escape_like(&query.exact().replace(char::is_whitespace, ""))
        );
        let sql = format!(
            "SELECT * FROM (
                 SELECT summary.*, {relevance} AS relevance
                 FROM ({summary}) AS summary
                 JOIN screen_titles t ON t.id = summary.id
             ) ranked
             WHERE (ranked.relevance < 4
                OR REPLACE(ranked.title_ko, ' ', '') LIKE ?
                OR EXISTS (
                    SELECT 1 FROM screen_music_cues c
                    WHERE c.screen_title_id = ranked.id
                      AND c.editorial_status = 'PUBLISHED'
                      AND (c.work_title LIKE ? OR c.composer_name LIKE ? OR c.part_label LIKE ?)))
               AND (? IS NULL OR ranked.kind = ?)
             ORDER BY ranked.relevance ASC, ranked.id ASC
             LIMIT ? OFFSET ?"
        );
        let mut statement = sqlx::query_as::<_, ScreenTitleSummary>(&sql);
        for value in &relevance_binds {
            statement = statement.bind(value);
        }
        let items = statement
            .bind(&compact)
            .bind(query.contains())
            .bind(query.contains())
            .bind(query.contains())
            .bind(kind)
            .bind(kind)
            .bind(limit + 1)
            .bind(offset)
            .fetch_all(pool)
            .await?;
        Ok(page_from(items, limit))
    }

    pub async fn find_title(
        pool: &DbPool,
        title_id: i32,
    ) -> Result<Option<ScreenTitleDetail>, sqlx::Error> {
        let summary = summary_select();
        let sql = format!("{summary} AND t.id = ?");
        let Some(title) = sqlx::query_as::<_, ScreenTitleSummary>(&sql)
            .bind(title_id)
            .fetch_optional(pool)
            .await?
        else {
            return Ok(None);
        };

        let sql = format!(
            "{CUE_SELECT}
             WHERE c.screen_title_id = ? AND c.editorial_status = 'PUBLISHED'
             ORDER BY c.display_order ASC, c.id ASC"
        );
        let rows = sqlx::query_as::<_, CueRow>(&sql)
            .bind(title_id)
            .fetch_all(pool)
            .await?;
        let piece_ids = rows
            .iter()
            .filter_map(|row| row.piece_id)
            .collect::<Vec<_>>();
        let sectors = Self::public_sectors(pool, &piece_ids).await?;

        let cues = rows
            .into_iter()
            .map(|row| {
                let listen = listen_for(&row, &sectors);
                ScreenCue {
                    id: row.id,
                    order: row.display_order,
                    episode_label: row.episode_label,
                    composer_id: row.composer_id,
                    composer_name: row.composer_name,
                    piece_id: row.piece_id,
                    work_title: row.work_title,
                    part_label: row.part_label,
                    usage: row.usage_kind,
                    arranged: row.arranged,
                    approx_at_sec: row.approx_at_sec,
                    scene_note: row.scene_note,
                    spoiler: row.spoiler,
                    official_clip: parse_clip(row.official_clip.as_deref()),
                    evidence: parse_evidence(&row.evidence),
                    still_path: row.still_path,
                    listen,
                }
            })
            .collect();

        Ok(Some(ScreenTitleDetail { title, cues }))
    }

    /// 작품별 공개 비교 구간과 공개 연주 수. 구간 순서대로
    async fn public_sectors(
        pool: &DbPool,
        piece_ids: &[i32],
    ) -> Result<HashMap<i32, Vec<(i32, i64)>>, sqlx::Error> {
        if piece_ids.is_empty() {
            return Ok(HashMap::new());
        }
        let placeholders = vec!["?"; piece_ids.len()].join(", ");
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             SELECT sector.piece_id, public_sector.sector_id, public_sector.ready_performance_count
             FROM public_sector
             JOIN performance_sectors sector ON sector.id = public_sector.sector_id
             WHERE sector.piece_id IN ({placeholders})
             ORDER BY sector.piece_id, sector.display_order ASC, sector.id ASC"
        );
        let mut statement = sqlx::query_as::<_, PublicSectorRow>(&sql);
        for piece_id in piece_ids {
            statement = statement.bind(piece_id);
        }
        let mut sectors: HashMap<i32, Vec<(i32, i64)>> = HashMap::new();
        for row in statement.fetch_all(pool).await? {
            sectors
                .entry(row.piece_id)
                .or_default()
                .push((row.sector_id, row.ready_performance_count));
        }
        Ok(sectors)
    }

    pub async fn find_piece_cues(
        pool: &DbPool,
        piece_id: i32,
    ) -> Result<Vec<PieceScreenCue>, sqlx::Error> {
        let cover_columns = cover_columns_sql();
        let sql = format!(
            "SELECT c.id AS cue_id, t.id AS title_id, t.title_ko, t.kind, t.release_year,
                    t.poster_path, t.poster_url, t.poster_credit, c.part_label, c.episode_label,
                    c.sector_id,
                    c.usage_kind AS `usage`,
                    {cover_columns}
             FROM screen_music_cues c
             JOIN screen_titles t ON t.id = c.screen_title_id AND t.editorial_status = 'PUBLISHED'
             WHERE c.piece_id = ? AND c.editorial_status = 'PUBLISHED'
             ORDER BY t.display_order ASC, c.display_order ASC, c.id ASC"
        );
        sqlx::query_as::<_, PieceScreenCue>(&sql)
            .bind(piece_id)
            .fetch_all(pool)
            .await
    }

    /// 작품마다 하나씩, 화면 순서대로
    pub async fn find_featured_cues(
        pool: &DbPool,
        limit: Option<u32>,
    ) -> Result<Vec<FeaturedScreenCue>, sqlx::Error> {
        let limit = limit.unwrap_or(12).clamp(1, MAX_PAGE_SIZE);
        let cover_columns = cover_columns_sql();
        let sql = format!(
            "{PUBLIC_COMPARISON_CTE}
             , ranked_cue AS (
                 SELECT c.id AS cue_id, t.id AS title_id, t.title_ko, t.kind, t.poster_path,
                        t.poster_url, t.poster_credit,
                        c.composer_id, c.composer_name, c.piece_id, c.work_title, c.part_label,
                        c.sector_id, t.display_order AS title_order, c.display_order AS cue_order,
                        {cover_columns},
                        ROW_NUMBER() OVER (
                            PARTITION BY t.id ORDER BY c.display_order ASC, c.id ASC
                        ) AS title_rank
                 FROM screen_music_cues c
                 JOIN screen_titles t
                   ON t.id = c.screen_title_id AND t.editorial_status = 'PUBLISHED'
                 JOIN public_sector ON public_sector.sector_id = c.sector_id
                 JOIN performance_sectors sector
                   ON sector.id = c.sector_id AND sector.piece_id = c.piece_id
                 WHERE c.editorial_status = 'PUBLISHED' AND c.composer_id IS NOT NULL
             )
             SELECT cue_id, title_id, title_ko, kind, poster_path, poster_url, poster_credit,
                    composer_id, composer_name,
                    piece_id, work_title, part_label, sector_id, cover_video_id,
                    cover_thumb_jpg, cover_thumb_webp
             FROM ranked_cue
             WHERE title_rank = 1
             ORDER BY title_order ASC, cue_order ASC, cue_id ASC
             LIMIT ?"
        );
        sqlx::query_as::<_, FeaturedScreenCue>(&sql)
            .bind(limit)
            .fetch_all(pool)
            .await
    }

    pub async fn find_still_candidates(
        pool: &DbPool,
        title_id: i32,
    ) -> Result<Option<ScreenStillCandidates>, sqlx::Error> {
        let Some((backdrop_path, still_paths)) =
            sqlx::query_as::<_, (Option<String>, Option<String>)>(
                "SELECT backdrop_path, CAST(still_paths AS CHAR CHARACTER SET utf8mb4)
             FROM screen_titles WHERE id = ?",
            )
            .bind(title_id)
            .fetch_optional(pool)
            .await?
        else {
            return Ok(None);
        };
        let cues = sqlx::query_as::<_, ScreenCueStill>(
            "SELECT id, work_title, part_label, still_path
             FROM screen_music_cues
             WHERE screen_title_id = ?
             ORDER BY display_order ASC, id ASC",
        )
        .bind(title_id)
        .fetch_all(pool)
        .await?;
        Ok(Some(ScreenStillCandidates {
            title_id,
            backdrop_path,
            still_paths: parse_paths(still_paths.as_deref()),
            cues,
        }))
    }

    /// 관리자가 고른 장면 스틸을 저장한다. 그 작품의 후보(스틸·대표 스틸) 안에서만 고를 수 있다.
    /// 큐가 없으면 Ok(None), 후보 밖이면 Ok(Some(false))
    pub async fn set_cue_still(
        pool: &DbPool,
        cue_id: u64,
        still_path: Option<&str>,
    ) -> Result<Option<bool>, sqlx::Error> {
        let Some((backdrop_path, still_paths)) =
            sqlx::query_as::<_, (Option<String>, Option<String>)>(
                "SELECT t.backdrop_path, CAST(t.still_paths AS CHAR CHARACTER SET utf8mb4)
             FROM screen_music_cues c
             JOIN screen_titles t ON t.id = c.screen_title_id
             WHERE c.id = ?",
            )
            .bind(cue_id)
            .fetch_optional(pool)
            .await?
        else {
            return Ok(None);
        };
        if let Some(path) = still_path {
            let allowed = backdrop_path.as_deref() == Some(path)
                || parse_paths(still_paths.as_deref())
                    .iter()
                    .any(|candidate| candidate == path);
            if !allowed {
                return Ok(Some(false));
            }
        }
        sqlx::query("UPDATE screen_music_cues SET still_path = ? WHERE id = ?")
            .bind(still_path)
            .bind(cue_id)
            .execute(pool)
            .await?;
        Ok(Some(true))
    }
}

fn parse_paths(text: Option<&str>) -> Vec<String> {
    text.and_then(|text| serde_json::from_str::<Vec<String>>(text).ok())
        .unwrap_or_default()
}

#[cfg(test)]
mod tests {
    use super::{listen_for, page_bounds, parse_evidence, CueRow};
    use std::collections::HashMap;

    fn row(piece_id: Option<i32>, sector_id: Option<i32>, apple: Option<&str>) -> CueRow {
        CueRow {
            id: 1,
            display_order: 1,
            episode_label: None,
            composer_id: piece_id.map(|_| 16),
            composer_name: "하이든".to_string(),
            piece_id,
            work_title: "트럼펫 협주곡".to_string(),
            part_label: None,
            sector_id,
            usage_kind: "SOURCE".to_string(),
            arranged: false,
            approx_at_sec: None,
            scene_note: "장면".to_string(),
            spoiler: false,
            official_clip: None,
            evidence: "[]".to_string(),
            still_path: None,
            apple_music_url: apple.map(str::to_string),
            spotify_url: None,
            youtube_music_url: Some(" ".to_string()),
        }
    }

    #[test]
    fn listen_prefers_same_passage_then_piece_then_links() {
        let sectors = HashMap::from([(88, vec![(90, 3_i64), (91, 4)])]);
        let same = listen_for(&row(Some(88), Some(90), None), &sectors);
        assert_eq!(
            (same.kind, same.sector_id, same.ready_performance_count),
            ("sector", Some(90), Some(3))
        );
        let other = listen_for(&row(Some(88), Some(999), None), &sectors);
        assert_eq!(other.kind, "piece");
        let external = listen_for(
            &row(Some(28), None, Some("https://music.apple.com/a")),
            &sectors,
        );
        assert_eq!(external.kind, "external");
        assert_eq!(
            external.links.and_then(|links| links.youtube_music_url),
            None
        );
        assert_eq!(
            listen_for(&row(Some(28), None, None), &sectors).kind,
            "none"
        );
        assert_eq!(listen_for(&row(None, None, None), &sectors).kind, "none");
    }

    #[test]
    fn evidence_with_unknown_shape_is_dropped() {
        let evidence = parse_evidence(
            r#"[{"grade":"1","kind":"ost","url":"https://a.example","note":"트랙"},{"grade":"2"}]"#,
        );
        assert_eq!(evidence.len(), 1);
        assert!(parse_evidence("{}").is_empty());
    }

    #[test]
    fn page_size_is_clamped() {
        assert_eq!(page_bounds(None, None), (0, 24));
        assert_eq!(page_bounds(Some(10), Some(500)), (10, 50));
        assert_eq!(page_bounds(None, Some(0)), (0, 1));
    }
}
