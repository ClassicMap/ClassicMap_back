//! 앨범 탭용 목록: 조건으로 거른 앨범, 레이블 목록, 레퍼토리 연주자의 새 앨범.
//! 기존 GET /recordings (전체를 한 번에) 계약은 그대로 두고 새 경로로 연다.

use crate::auth::AuthenticatedUser;
use crate::db::DbPool;
use crate::logger::Logger;
use chrono::Local;
use rocket::http::Status;
use rocket::{serde::json::Json, State};
use serde::{Deserialize, Serialize};
use sqlx::FromRow;

const DEFAULT_LIMIT: i64 = 24;
const MAX_LIMIT: i64 = 60;
const DEFAULT_NEW_DAYS: i64 = 90;
const MAX_NEW_DAYS: i64 = 730;

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct RecordingListItem {
    pub id: i32,
    pub title: String,
    pub year: String,
    pub release_date: Option<String>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: Option<bool>,
    pub is_compilation: Option<bool>,
    /// 발매일이 오늘 뒤인 예약 앨범
    #[sqlx(default)]
    pub is_pre_release: bool,
    pub apple_music_url: Option<String>,
    pub spotify_url: Option<String>,
    pub youtube_music_url: Option<String>,
    pub artist_id: i32,
    pub artist_name: String,
    pub artist_english_name: String,
    pub artist_image_url: Option<String>,
    pub artist_category: String,
}

#[derive(Debug, Serialize, Deserialize, FromRow)]
#[serde(rename_all = "camelCase")]
pub struct RecordingLabel {
    pub label: String,
    pub album_count: i64,
}

#[derive(Debug, Clone, Copy, PartialEq)]
pub enum BrowseSort {
    Release,
    Title,
}

impl BrowseSort {
    pub fn parse(value: Option<&str>) -> Result<Self, ()> {
        match value.map(str::trim).filter(|v| !v.is_empty()) {
            None | Some("release") => Ok(Self::Release),
            Some("title") => Ok(Self::Title),
            Some(_) => Err(()),
        }
    }
}

#[derive(Debug, Default)]
pub struct BrowseFilter<'a> {
    pub artist: Option<i32>,
    pub label: Option<&'a str>,
    pub year: Option<&'a str>,
    pub query: Option<&'a str>,
    pub sort: Option<BrowseSort>,
}

#[derive(Debug, PartialEq)]
pub enum BrowseBind {
    Int(i32),
    Text(String),
}

const LIST_SELECT: &str = "SELECT r.id, r.title, r.year,
     DATE_FORMAT(r.release_date, '%Y-%m-%d') AS release_date,
     r.label, r.cover_url, r.track_count, r.is_single, r.is_compilation,
     r.apple_music_url, r.spotify_url, r.youtube_music_url,
     a.id AS artist_id, a.name AS artist_name, a.english_name AS artist_english_name,
     a.image_url AS artist_image_url, a.category AS artist_category
     FROM recordings r
     JOIN artists a ON a.id = r.artist_id";

/// LIMIT/OFFSET 자리표시자로 끝나는 SQL과 그 앞까지의 바인딩.
pub fn browse_sql(filter: &BrowseFilter<'_>) -> (String, Vec<BrowseBind>) {
    let mut sql = format!("{} WHERE 1=1", LIST_SELECT);
    let mut binds = Vec::new();
    if let Some(artist) = filter.artist {
        sql.push_str(
            " AND EXISTS (SELECT 1 FROM recording_contributors rc WHERE rc.recording_id = r.id AND rc.artist_id = ?)",
        );
        binds.push(BrowseBind::Int(artist));
    }
    if let Some(label) = filter.label.map(str::trim).filter(|v| !v.is_empty()) {
        sql.push_str(" AND r.label = ?");
        binds.push(BrowseBind::Text(label.to_string()));
    }
    if let Some(year) = filter.year.map(str::trim).filter(|v| !v.is_empty()) {
        sql.push_str(" AND r.year = ?");
        binds.push(BrowseBind::Text(year.to_string()));
    }
    if let Some(query) = filter.query.map(str::trim).filter(|v| !v.is_empty()) {
        sql.push_str(" AND (r.title LIKE ? OR r.label LIKE ? OR a.name LIKE ? OR a.english_name LIKE ?)");
        let pattern = format!("%{}%", escape_like(query));
        for _ in 0..4 {
            binds.push(BrowseBind::Text(pattern.clone()));
        }
    }
    sql.push_str(match filter.sort.unwrap_or(BrowseSort::Release) {
        // 발매일이 없는 옛 시드 앨범은 뒤로 (DESC 에서 NULL 은 끝)
        BrowseSort::Release => " ORDER BY r.release_date DESC, r.year DESC, r.id DESC",
        BrowseSort::Title => " ORDER BY r.title ASC, r.id ASC",
    });
    sql.push_str(" LIMIT ? OFFSET ?");
    (sql, binds)
}

fn escape_like(value: &str) -> String {
    value.replace('\\', "\\\\").replace('%', "\\%").replace('_', "\\_")
}

pub fn page(offset: Option<i64>, limit: Option<i64>) -> (i64, i64) {
    (offset.unwrap_or(0).max(0), limit.unwrap_or(DEFAULT_LIMIT).clamp(1, MAX_LIMIT))
}

fn is_valid_year(year: &str) -> bool {
    year.len() == 4 && year.chars().all(|c| c.is_ascii_digit())
}

fn mark_pre_release(mut items: Vec<RecordingListItem>) -> Vec<RecordingListItem> {
    let today = Local::now().date_naive().format("%Y-%m-%d").to_string();
    for item in &mut items {
        item.is_pre_release = item.release_date.as_deref().is_some_and(|date| date > today.as_str());
    }
    items
}

pub async fn find_browse(
    pool: &DbPool,
    filter: &BrowseFilter<'_>,
    offset: i64,
    limit: i64,
) -> Result<Vec<RecordingListItem>, sqlx::Error> {
    let (sql, binds) = browse_sql(filter);
    let mut query = sqlx::query_as::<_, RecordingListItem>(&sql);
    for bind in binds {
        query = match bind {
            BrowseBind::Int(value) => query.bind(value),
            BrowseBind::Text(value) => query.bind(value),
        };
    }
    query.bind(limit).bind(offset).fetch_all(pool).await.map(mark_pre_release)
}

pub async fn find_labels(pool: &DbPool, limit: i64) -> Result<Vec<RecordingLabel>, sqlx::Error> {
    sqlx::query_as::<_, RecordingLabel>(
        "SELECT label, COUNT(*) AS album_count FROM recordings
         WHERE label IS NOT NULL AND TRIM(label) <> ''
         GROUP BY label
         ORDER BY album_count DESC, label ASC
         LIMIT ?",
    )
    .bind(limit)
    .fetch_all(pool)
    .await
}

/// 레퍼토리에 담은 연주자가 참여한 앨범 중 최근 `days` 일 안에 나왔거나 나올 앨범. 최근 순.
pub async fn find_new_for_user(
    pool: &DbPool,
    user_id: i32,
    days: i64,
    offset: i64,
    limit: i64,
) -> Result<Vec<RecordingListItem>, sqlx::Error> {
    let sql = format!(
        "{} WHERE r.release_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
           AND EXISTS (
             SELECT 1 FROM recording_contributors rc
             JOIN user_favorite_artists f ON f.artist_id = rc.artist_id
             WHERE rc.recording_id = r.id AND f.user_id = ?
           )
         ORDER BY r.release_date DESC, r.id DESC
         LIMIT ? OFFSET ?",
        LIST_SELECT
    );
    sqlx::query_as::<_, RecordingListItem>(&sql)
        .bind(days)
        .bind(user_id)
        .bind(limit)
        .bind(offset)
        .fetch_all(pool)
        .await
        .map(mark_pre_release)
}

#[get("/recordings/browse?<artist>&<label>&<year>&<q>&<sort>&<offset>&<limit>")]
pub async fn browse_recordings(
    pool: &State<DbPool>,
    artist: Option<i32>,
    label: Option<String>,
    year: Option<String>,
    q: Option<String>,
    sort: Option<String>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<RecordingListItem>>, Status> {
    let sort = BrowseSort::parse(sort.as_deref()).map_err(|_| Status::BadRequest)?;
    if let Some(year) = year.as_deref().map(str::trim).filter(|v| !v.is_empty()) {
        if !is_valid_year(year) {
            return Err(Status::BadRequest);
        }
    }
    let filter = BrowseFilter {
        artist: artist.filter(|id| *id > 0),
        label: label.as_deref(),
        year: year.as_deref(),
        query: q.as_deref(),
        sort: Some(sort),
    };
    let (offset, limit) = page(offset, limit);
    find_browse(pool, &filter, offset, limit).await.map(Json).map_err(|e| {
        Logger::error("API", &format!("Failed to browse recordings: {}", e));
        Status::InternalServerError
    })
}

#[get("/recordings/labels?<limit>")]
pub async fn get_recording_labels(pool: &State<DbPool>, limit: Option<i64>) -> Result<Json<Vec<RecordingLabel>>, Status> {
    find_labels(pool, limit.unwrap_or(30).clamp(1, 100)).await.map(Json).map_err(|e| {
        Logger::error("API", &format!("Failed to get recording labels: {}", e));
        Status::InternalServerError
    })
}

#[get("/me/recordings/new?<days>&<offset>&<limit>")]
pub async fn get_my_new_recordings(
    pool: &State<DbPool>,
    user: AuthenticatedUser,
    days: Option<i64>,
    offset: Option<i64>,
    limit: Option<i64>,
) -> Result<Json<Vec<RecordingListItem>>, Status> {
    let days = days.unwrap_or(DEFAULT_NEW_DAYS).clamp(1, MAX_NEW_DAYS);
    let (offset, limit) = page(offset, limit);
    find_new_for_user(pool, user.user.id, days, offset, limit).await.map(Json).map_err(|e| {
        Logger::error("API", &format!("Failed to get new recordings: {}", e));
        Status::InternalServerError
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty_filter_sorts_by_release_without_conditions() {
        let (sql, binds) = browse_sql(&BrowseFilter::default());
        assert!(!sql.contains(" AND "));
        assert!(sql.contains("ORDER BY r.release_date DESC"));
        assert!(sql.ends_with("LIMIT ? OFFSET ?"));
        assert!(binds.is_empty());
    }

    #[test]
    fn binds_follow_placeholder_order() {
        let filter = BrowseFilter {
            artist: Some(189),
            label: Some(" Naïve "),
            year: Some("2025"),
            query: Some("ravel_50%"),
            sort: Some(BrowseSort::Title),
        };
        let (sql, binds) = browse_sql(&filter);
        assert_eq!(sql.matches('?').count(), binds.len() + 2);
        assert_eq!(binds[0], BrowseBind::Int(189));
        assert_eq!(binds[1], BrowseBind::Text("Naïve".into()));
        assert_eq!(binds[2], BrowseBind::Text("2025".into()));
        assert_eq!(binds[3], BrowseBind::Text("%ravel\\_50\\%%".into()));
        assert!(sql.contains("ORDER BY r.title ASC"));
    }

    #[test]
    fn sort_and_paging_are_bounded() {
        assert_eq!(BrowseSort::parse(None), Ok(BrowseSort::Release));
        assert_eq!(BrowseSort::parse(Some("title")), Ok(BrowseSort::Title));
        assert!(BrowseSort::parse(Some("popular")).is_err());
        assert_eq!(page(None, None), (0, DEFAULT_LIMIT));
        assert_eq!(page(Some(-5), Some(500)), (0, MAX_LIMIT));
        assert!(is_valid_year("2025"));
        assert!(!is_valid_year("25"));
    }

    #[rocket::async_test]
    async fn new_routes_do_not_collide_with_recording_by_id() {
        let pool = sqlx::mysql::MySqlPoolOptions::new().connect_lazy("mysql://user:pass@localhost/db").unwrap();
        rocket::build()
            .manage(pool)
            .mount(
                "/api",
                routes![
                    crate::recording::api::get_recordings,
                    crate::recording::api::get_recording,
                    browse_recordings,
                    get_recording_labels,
                    get_my_new_recordings
                ],
            )
            .ignite()
            .await
            .expect("routes collide");
    }

    #[test]
    fn pre_release_is_marked_from_release_date() {
        let item = |date: Option<&str>| RecordingListItem {
            id: 1,
            title: "t".into(),
            year: "2027".into(),
            release_date: date.map(str::to_string),
            label: None,
            cover_url: None,
            track_count: None,
            is_single: None,
            is_compilation: None,
            is_pre_release: false,
            apple_music_url: None,
            spotify_url: None,
            youtube_music_url: None,
            artist_id: 1,
            artist_name: "a".into(),
            artist_english_name: "a".into(),
            artist_image_url: None,
            artist_category: "pianist".into(),
        };
        let marked = mark_pre_release(vec![item(Some("2999-01-01")), item(Some("2000-01-01")), item(None)]);
        assert_eq!(marked.iter().map(|i| i.is_pre_release).collect::<Vec<_>>(), vec![true, false, false]);
    }
}
