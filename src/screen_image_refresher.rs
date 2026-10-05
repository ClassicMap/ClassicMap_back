//! 영화 속 클래식 포스터·스틸 경로 갱신.
//!
//! TMDB 이미지 API 에서 작품의 포스터·대표 스틸·스틸 후보 파일 경로를 받아 `screen_titles` 에 적는다.
//! 이미지 파일은 받지 않고 경로만 둔다(앱이 image.tmdb.org 에서 바로 그린다).
//! TMDB 약관상 받은 정보를 6개월 넘게 두지 않으므로 오래된 작품부터 다시 받는다(CronJob 으로 매달).
//! 이 값은 시드 데이터가 아니라 TMDB 응답을 잠깐 들고 있는 것이라 스냅샷을 남기지 않는다.
//! 관리자가 고른 큐 스틸(`screen_music_cues.still_path`)은 건드리지 않는다.

use serde::{Deserialize, Serialize};
use std::{fmt, time::Duration};

use crate::db::DbPool;

const TMDB_API: &str = "https://api.themoviedb.org/3";
const MAX_STILL_CANDIDATES: usize = 16;
const MAX_EPISODE_STILLS: usize = 6;

/// TMDB v4 읽기 토큰. Authorization 헤더로만 보낸다.
/// v3 API 키는 주소 쿼리에 붙어 오류 문구·보고서에 섞일 수 있어 받지 않는다
#[derive(Clone)]
pub struct TmdbReadToken(pub String);

impl std::fmt::Debug for TmdbReadToken {
    fn fmt(&self, formatter: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        formatter.write_str("TmdbReadToken(***)")
    }
}

#[derive(Debug, Clone)]
pub struct ScreenImageRefreshOptions {
    pub dry_run: bool,
    /// 한 번에 새로 받을 작품 수 상한
    pub limit: Option<usize>,
    pub run_id: Option<String>,
    /// 이 날수보다 오래 전에 받은 작품만 다시 받는다. 0 이면 전부
    pub stale_days: u32,
}

#[derive(Debug, Clone, Deserialize)]
struct TmdbImage {
    file_path: String,
    iso_639_1: Option<String>,
    #[serde(default)]
    vote_average: f64,
    #[serde(default)]
    vote_count: u32,
}

#[derive(Debug, Clone, Default, Deserialize)]
struct TmdbImages {
    #[serde(default)]
    posters: Vec<TmdbImage>,
    #[serde(default)]
    backdrops: Vec<TmdbImage>,
    #[serde(default)]
    stills: Vec<TmdbImage>,
}

#[derive(Debug, Clone, PartialEq, Eq, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ImageSelection {
    pub poster_path: Option<String>,
    pub backdrop_path: Option<String>,
    pub still_paths: Vec<String>,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct RefreshedTitle {
    pub slug: String,
    pub changed: bool,
    pub poster: bool,
    pub still_count: usize,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct SkippedTitle {
    pub slug: String,
    pub reason: String,
}

#[derive(Debug, Clone, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct ScreenImageRefreshReport {
    pub status: &'static str,
    pub dry_run: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub run_id: Option<String>,
    pub considered: usize,
    pub planned_updates: usize,
    pub updated: usize,
    pub refreshed: Vec<RefreshedTitle>,
    pub skipped: Vec<SkippedTitle>,
}

#[derive(Debug)]
pub enum ScreenImageRefreshError {
    Database(sqlx::Error),
    Http(String),
}

impl ScreenImageRefreshError {
    pub const fn code(&self) -> &'static str {
        match self {
            Self::Database(_) => "DATABASE_ERROR",
            Self::Http(_) => "TMDB_CLIENT_ERROR",
        }
    }

    pub const fn exit_code(&self) -> i32 {
        3
    }
}

impl fmt::Display for ScreenImageRefreshError {
    fn fmt(&self, formatter: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Self::Database(error) => write!(formatter, "데이터베이스 오류: {error}"),
            Self::Http(message) => write!(formatter, "TMDB 요청 준비 오류: {message}"),
        }
    }
}

impl std::error::Error for ScreenImageRefreshError {}

impl From<sqlx::Error> for ScreenImageRefreshError {
    fn from(error: sqlx::Error) -> Self {
        Self::Database(error)
    }
}

/// 가장 표가 많은 것부터. 같으면 평점, 그다음 경로 순으로 정해 매번 같은 답을 낸다
fn ranked(images: &[TmdbImage]) -> Vec<&TmdbImage> {
    let mut sorted = images.iter().collect::<Vec<_>>();
    sorted.sort_by(|a, b| {
        b.vote_count
            .cmp(&a.vote_count)
            .then(b.vote_average.total_cmp(&a.vote_average))
            .then(a.file_path.cmp(&b.file_path))
    });
    sorted
}

fn language_is(image: &TmdbImage, language: Option<&str>) -> bool {
    image.iso_639_1.as_deref().filter(|code| !code.is_empty()) == language
}

/// 포스터는 한국어 → 영어 → 글자 없는 것 → 아무거나. 대표 스틸은 글자 없는 것 → 아무거나.
/// 스틸 후보는 글자 없는 배경 그림을 먼저 두고 회차 스틸을 뒤에 붙인다
pub(crate) fn select_images(title: &TmdbImagesForSelection) -> ImageSelection {
    let posters = ranked(&title.images.posters);
    let poster_path = [Some("ko"), Some("en"), None]
        .iter()
        .find_map(|language| posters.iter().find(|image| language_is(image, *language)))
        .or_else(|| posters.first())
        .map(|image| image.file_path.clone());

    let backdrops = ranked(&title.images.backdrops);
    let textless = backdrops
        .iter()
        .filter(|image| language_is(image, None))
        .copied()
        .collect::<Vec<_>>();
    let backdrop_path = textless
        .first()
        .or_else(|| backdrops.first())
        .map(|image| image.file_path.clone());

    let mut still_paths = Vec::new();
    let mut push = |path: &str| {
        if !still_paths.iter().any(|existing: &String| existing == path) {
            still_paths.push(path.to_string());
        }
    };
    for image in textless.iter().take(MAX_STILL_CANDIDATES) {
        push(&image.file_path);
    }
    for episode in &title.episode_stills {
        for image in ranked(episode).into_iter().take(MAX_EPISODE_STILLS) {
            push(&image.file_path);
        }
    }

    ImageSelection {
        poster_path,
        backdrop_path,
        still_paths,
    }
}

pub(crate) struct TmdbImagesForSelection {
    images: TmdbImages,
    episode_stills: Vec<Vec<TmdbImage>>,
}

/// "S1E3" · "E24" 를 (시즌, 회) 로. "여러 회" 같은 글은 None
pub fn parse_episode(label: &str) -> Option<(u32, u32)> {
    let label = label.trim();
    let (season, episode) = match label.strip_prefix('S') {
        Some(rest) => {
            let (season, episode) = rest.split_once('E')?;
            (season.parse().ok()?, episode.parse().ok()?)
        }
        None => (1, label.strip_prefix('E')?.parse().ok()?),
    };
    (season > 0 && episode > 0).then_some((season, episode))
}

#[derive(Debug, sqlx::FromRow)]
struct TitleTarget {
    id: i32,
    slug: String,
    namespace: String,
    external_id: String,
    poster_path: Option<String>,
    backdrop_path: Option<String>,
    still_paths: Option<String>,
}

struct TmdbClient {
    http: reqwest::Client,
    token: TmdbReadToken,
}

impl TmdbClient {
    fn new(token: TmdbReadToken) -> Result<Self, ScreenImageRefreshError> {
        let http = reqwest::Client::builder()
            .timeout(Duration::from_secs(20))
            .user_agent("ClassicMap/1.0 (screen image refresh)")
            .build()
            .map_err(|error| ScreenImageRefreshError::Http(error.to_string()))?;
        Ok(Self { http, token })
    }

    async fn images(&self, path: &str) -> Result<TmdbImages, String> {
        let url = format!("{TMDB_API}{path}");
        let response = self
            .http
            .get(&url)
            .query(&[("include_image_language", "ko,en,null")])
            .bearer_auth(&self.token.0)
            .send()
            .await
            .map_err(|error| error.without_url().to_string())?;
        let status = response.status();
        if !status.is_success() {
            return Err(format!("TMDB {status} ({path})"));
        }
        response
            .json::<TmdbImages>()
            .await
            .map_err(|error| error.without_url().to_string())
    }
}

pub struct ScreenImageRefresher;

impl ScreenImageRefresher {
    pub async fn refresh(
        pool: &DbPool,
        token: TmdbReadToken,
        options: &ScreenImageRefreshOptions,
    ) -> Result<ScreenImageRefreshReport, ScreenImageRefreshError> {
        let client = TmdbClient::new(token)?;
        let targets = sqlx::query_as::<_, TitleTarget>(
            "SELECT t.id, CAST(t.slug AS CHAR CHARACTER SET utf8mb4) AS slug,
                    CAST(identifier.namespace AS CHAR CHARACTER SET utf8mb4) AS namespace,
                    CAST(identifier.external_id AS CHAR CHARACTER SET utf8mb4) AS external_id,
                    t.poster_path, t.backdrop_path,
                    CAST(t.still_paths AS CHAR CHARACTER SET utf8mb4) AS still_paths
             FROM screen_titles t
             JOIN screen_title_identifiers identifier
               ON identifier.screen_title_id = t.id
              AND identifier.namespace IN ('tmdb_movie', 'tmdb_tv')
             WHERE ? = 0
                OR t.images_fetched_at IS NULL
                OR t.images_fetched_at < NOW(6) - INTERVAL ? DAY
             ORDER BY t.images_fetched_at IS NOT NULL, t.images_fetched_at ASC, t.id ASC",
        )
        .bind(options.stale_days)
        .bind(options.stale_days)
        .fetch_all(pool)
        .await?;
        let missing = sqlx::query_scalar::<_, String>(
            "SELECT CAST(t.slug AS CHAR CHARACTER SET utf8mb4) FROM screen_titles t
             WHERE NOT EXISTS (
                 SELECT 1 FROM screen_title_identifiers identifier
                 WHERE identifier.screen_title_id = t.id
                   AND identifier.namespace IN ('tmdb_movie', 'tmdb_tv'))
             ORDER BY t.slug",
        )
        .fetch_all(pool)
        .await?;

        let targets = match options.limit {
            Some(limit) => targets.into_iter().take(limit).collect::<Vec<_>>(),
            None => targets,
        };
        let mut skipped = missing
            .into_iter()
            .map(|slug| SkippedTitle {
                slug,
                reason: "NO_TMDB_ID".to_string(),
            })
            .collect::<Vec<_>>();
        let mut refreshed = Vec::new();
        let mut planned_updates = 0;
        let mut updated = 0;

        for target in &targets {
            let selection = match Self::fetch(pool, &client, target).await {
                Ok(selection) => selection,
                Err(reason) => {
                    skipped.push(SkippedTitle {
                        slug: target.slug.clone(),
                        reason,
                    });
                    continue;
                }
            };
            let stored_stills = target
                .still_paths
                .as_deref()
                .and_then(|text| serde_json::from_str::<Vec<String>>(text).ok())
                .unwrap_or_default();
            let changed = target.poster_path != selection.poster_path
                || target.backdrop_path != selection.backdrop_path
                || stored_stills != selection.still_paths;
            if changed {
                planned_updates += 1;
            }
            if !options.dry_run {
                // 바뀌지 않아도 받은 시각은 새로 적는다(6개월 기준은 받은 때부터 센다)
                let stills = serde_json::to_string(&selection.still_paths)
                    .unwrap_or_else(|_| "[]".to_string());
                sqlx::query(
                    "UPDATE screen_titles
                     SET poster_path = ?, backdrop_path = ?, still_paths = CAST(? AS JSON),
                         images_fetched_at = NOW(6)
                     WHERE id = ?",
                )
                .bind(&selection.poster_path)
                .bind(&selection.backdrop_path)
                .bind(stills)
                .bind(target.id)
                .execute(pool)
                .await?;
                if changed {
                    updated += 1;
                }
            }
            refreshed.push(RefreshedTitle {
                slug: target.slug.clone(),
                changed,
                poster: selection.poster_path.is_some(),
                still_count: selection.still_paths.len(),
            });
            // TMDB 요청 한도에 한참 못 미치게 천천히 돈다
            tokio::time::sleep(Duration::from_millis(250)).await;
        }

        Ok(ScreenImageRefreshReport {
            status: if refreshed.len() == targets.len() {
                "succeeded"
            } else {
                "partial"
            },
            dry_run: options.dry_run,
            run_id: options.run_id.clone(),
            considered: targets.len(),
            planned_updates,
            updated,
            refreshed,
            skipped,
        })
    }

    async fn fetch(
        pool: &DbPool,
        client: &TmdbClient,
        target: &TitleTarget,
    ) -> Result<ImageSelection, String> {
        let id = target
            .external_id
            .parse::<u64>()
            .map_err(|_| format!("TMDB id 가 숫자가 아님: {}", target.external_id))?;
        let is_tv = target.namespace == "tmdb_tv";
        let base = if is_tv {
            format!("/tv/{id}")
        } else {
            format!("/movie/{id}")
        };
        let images = client.images(&format!("{base}/images")).await?;

        let mut episode_stills = Vec::new();
        if is_tv {
            let labels = sqlx::query_scalar::<_, String>(
                "SELECT DISTINCT episode_label FROM screen_music_cues
                 WHERE screen_title_id = ? AND episode_label IS NOT NULL
                 ORDER BY episode_label",
            )
            .bind(target.id)
            .fetch_all(pool)
            .await
            .map_err(|error| error.to_string())?;
            for (season, episode) in labels.iter().filter_map(|label| parse_episode(label)) {
                let path = format!("{base}/season/{season}/episode/{episode}/images");
                // 회차 스틸이 없는 회차도 있다. 작품 그림은 받았으니 그 회차만 건너뛴다
                if let Ok(episode_images) = client.images(&path).await {
                    episode_stills.push(episode_images.stills);
                }
            }
        }

        Ok(select_images(&TmdbImagesForSelection {
            images,
            episode_stills,
        }))
    }
}

#[cfg(test)]
mod tests {
    use super::{parse_episode, select_images, TmdbImage, TmdbImages, TmdbImagesForSelection};

    fn image(path: &str, language: Option<&str>, votes: u32) -> TmdbImage {
        TmdbImage {
            file_path: path.to_string(),
            iso_639_1: language.map(str::to_string),
            vote_average: 5.0,
            vote_count: votes,
        }
    }

    #[test]
    fn episode_labels_are_parsed() {
        assert_eq!(parse_episode("S1E3"), Some((1, 3)));
        assert_eq!(parse_episode("E24"), Some((1, 24)));
        assert_eq!(parse_episode("S2E10"), Some((2, 10)));
        assert_eq!(parse_episode("여러 회"), None);
        assert_eq!(parse_episode("S0E1"), None);
        assert_eq!(parse_episode("E"), None);
    }

    #[test]
    fn korean_poster_and_textless_backdrop_are_preferred() {
        let selection = select_images(&TmdbImagesForSelection {
            images: TmdbImages {
                posters: vec![
                    image("/en.jpg", Some("en"), 50),
                    image("/ko.jpg", Some("ko"), 3),
                ],
                backdrops: vec![
                    image("/titled.jpg", Some("en"), 90),
                    image("/plain-b.jpg", None, 4),
                    image("/plain-a.jpg", None, 9),
                ],
                stills: Vec::new(),
            },
            episode_stills: vec![vec![
                image("/ep.jpg", None, 1),
                image("/plain-a.jpg", None, 1),
            ]],
        });
        assert_eq!(selection.poster_path.as_deref(), Some("/ko.jpg"));
        assert_eq!(selection.backdrop_path.as_deref(), Some("/plain-a.jpg"));
        assert_eq!(
            selection.still_paths,
            vec!["/plain-a.jpg", "/plain-b.jpg", "/ep.jpg"]
        );
    }

    #[test]
    fn empty_images_give_nothing() {
        let selection = select_images(&TmdbImagesForSelection {
            images: TmdbImages::default(),
            episode_stills: Vec::new(),
        });
        assert_eq!(selection.poster_path, None);
        assert_eq!(selection.backdrop_path, None);
        assert!(selection.still_paths.is_empty());
    }
}
