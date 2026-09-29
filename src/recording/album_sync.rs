//! 연주자별 새 앨범을 Apple Music 에서 받아 recordings 에 더한다.
//!
//! 1. Apple Music 아티스트 ID 가 없는 연주자는 이미 가진 앨범의 참여 아티스트(없으면 이름 검색)로 찾는다.
//! 2. ID 가 있는 연주자마다 최근 정규 앨범 한 페이지를 받아, apple_music_id 나 upc 가 이미 있는
//!    앨범은 건드리지 않고(참여 연결만 더함) 없는 앨범만 넣는다.

use super::apple_music::{
    artwork_url, pick_album_artist, pick_search_artist, release_year, Album, AppleMusicClient, AppleMusicConfig,
};
use crate::db::DbPool;
use crate::logger::Logger;
use chrono::{Local, NaiveDate};
use sqlx::types::JsonValue;
use sqlx::FromRow;
use tokio::time::{sleep, Duration};

const SYNC_TYPE: &str = "apple_music_albums";
/// 아티스트 ID 를 못 찾은 연주자를 다시 물어보는 간격
const RECHECK_DAYS: i32 = 30;
/// 연주자마다 받아 볼 최근 정규 앨범 수
const ALBUMS_PER_ARTIST: u32 = 25;
/// 이름을 찾을 때 볼 기존 앨범 수
const SAMPLE_ALBUMS: i64 = 3;
/// 서버 시작 후 첫 동기화까지 기다리는 시간 (다른 시작 작업과 겹치지 않게)
const STARTUP_DELAY: Duration = Duration::from_secs(10 * 60);
/// 매일 이 시각(서버 시간)에 돈다. KOPIS 공연 동기화(3시) 다음.
const DAILY_HOUR: u32 = 4;

#[derive(Debug, Default, Clone, PartialEq)]
pub struct AlbumSyncResult {
    pub artists_resolved: u32,
    pub artists_checked: u32,
    pub albums_added: u32,
    pub albums_linked: u32,
    pub errors: u32,
}

/// 새로 넣을 앨범 한 장. Apple Music 응답에서 만든다.
#[derive(Debug, PartialEq)]
pub struct NewAlbumRow {
    pub apple_music_id: String,
    pub title: String,
    pub year: String,
    pub release_date: Option<NaiveDate>,
    pub label: Option<String>,
    pub cover_url: Option<String>,
    pub upc: Option<String>,
    pub track_count: Option<i32>,
    pub is_single: bool,
    pub is_compilation: bool,
    pub genre_names: JsonValue,
    pub copyright: Option<String>,
    pub editorial_notes: Option<String>,
    pub artwork_width: Option<i32>,
    pub artwork_height: Option<i32>,
    pub apple_music_url: Option<String>,
}

fn non_empty(value: Option<&str>) -> Option<String> {
    value.map(str::trim).filter(|v| !v.is_empty()).map(str::to_string)
}

/// 제목·발매 연도가 없는 앨범은 넣지 않는다. 열 길이를 넘는 값은 자른다.
pub fn album_row(album: &Album) -> Option<NewAlbumRow> {
    let attributes = album.attributes.as_ref()?;
    let release = non_empty(attributes.release_date.as_deref())?;
    let year = release_year(&release)?;
    let title = non_empty(Some(&attributes.name))?;
    let artwork = attributes.artwork.as_ref();
    Some(NewAlbumRow {
        apple_music_id: album.id.clone(),
        title: truncate(&title, 300),
        year,
        release_date: NaiveDate::parse_from_str(&release, "%Y-%m-%d").ok(),
        label: non_empty(attributes.record_label.as_deref()).map(|label| truncate(&label, 100)),
        cover_url: artwork.map(|a| artwork_url(&a.url)).filter(|url| url.len() <= 500),
        upc: non_empty(attributes.upc.as_deref()).filter(|upc| upc.len() <= 20),
        track_count: attributes.track_count,
        is_single: attributes.is_single.unwrap_or(false),
        is_compilation: attributes.is_compilation.unwrap_or(false),
        genre_names: JsonValue::from(attributes.genre_names.clone()),
        copyright: non_empty(attributes.copyright.as_deref()),
        editorial_notes: attributes
            .editorial_notes
            .as_ref()
            .and_then(|notes| non_empty(notes.standard.as_deref()).or_else(|| non_empty(notes.short.as_deref()))),
        artwork_width: artwork.and_then(|a| a.width),
        artwork_height: artwork.and_then(|a| a.height),
        apple_music_url: non_empty(attributes.url.as_deref()).filter(|url| url.len() <= 500),
    })
}

fn truncate(value: &str, max_chars: usize) -> String {
    value.chars().take(max_chars).collect()
}

#[derive(Debug, FromRow)]
struct UnresolvedArtist {
    id: i32,
    name: String,
    english_name: String,
}

#[derive(Debug, FromRow)]
struct ResolvedArtist {
    id: i32,
    apple_music_artist_id: String,
}

pub struct AlbumSyncScheduler;

impl AlbumSyncScheduler {
    /// 키가 없으면 경고 한 번만 남기고 끈다. 서버는 그대로 뜬다.
    pub fn start(pool: DbPool) {
        let Some(config) = AppleMusicConfig::from_env() else {
            Logger::warn(
                "APPLE_MUSIC",
                "Album sync disabled: APPLE_MUSIC_PRIVATE_KEY / APPLE_MUSIC_KEY_ID / APPLE_MUSIC_TEAM_KEY not set",
            );
            return;
        };
        Logger::info("SCHEDULER", &format!("Apple Music album sync: daily at {}:00", DAILY_HOUR));
        tokio::spawn(async move {
            sleep(STARTUP_DELAY).await;
            // 배포할 때마다 돌지 않게, 마지막 성공이 오늘이 아닐 때만 시작하자마자 한 번 돈다
            if !synced_today(&pool).await {
                Self::run(&pool, &config).await;
            }
            loop {
                sleep(wait_until_hour(DAILY_HOUR)).await;
                Self::run(&pool, &config).await;
            }
        });
    }

    async fn run(pool: &DbPool, config: &AppleMusicConfig) {
        Logger::info("APPLE_MUSIC", "=== Starting album sync ===");
        mark_status(pool, "in_progress", &AlbumSyncResult::default(), None).await;
        match sync_albums(pool, config).await {
            Ok(result) => {
                Logger::success(
                    "APPLE_MUSIC",
                    &format!(
                        "Album sync done: {} artists resolved ({} checked), {} albums added, {} linked, {} errors",
                        result.artists_resolved,
                        result.artists_checked,
                        result.albums_added,
                        result.albums_linked,
                        result.errors
                    ),
                );
                mark_status(pool, "success", &result, None).await;
            }
            Err(e) => {
                Logger::error("APPLE_MUSIC", &format!("Album sync failed: {}", e));
                mark_status(pool, "failed", &AlbumSyncResult::default(), Some(&e)).await;
            }
        }
    }
}

fn wait_until_hour(hour: u32) -> Duration {
    let now = Local::now().naive_local();
    let mut next = now.date().and_hms_opt(hour, 0, 0).unwrap_or(now);
    if now >= next {
        next += chrono::Duration::days(1);
    }
    Duration::from_secs(next.signed_duration_since(now).num_seconds().max(60) as u64)
}

async fn synced_today(pool: &DbPool) -> bool {
    sqlx::query_scalar::<_, i64>(
        "SELECT COUNT(*) FROM sync_metadata
         WHERE sync_type = ? AND status = 'success' AND last_sync_date = CURDATE()",
    )
    .bind(SYNC_TYPE)
    .fetch_one(pool)
    .await
    .map(|count| count > 0)
    .unwrap_or(false)
}

async fn mark_status(pool: &DbPool, status: &str, result: &AlbumSyncResult, error: Option<&str>) {
    let outcome = sqlx::query(
        "INSERT INTO sync_metadata (sync_type, last_sync_date, last_sync_timestamp, status, items_added, items_updated, error_message)
         VALUES (?, CURDATE(), NOW(), ?, ?, ?, ?)
         ON DUPLICATE KEY UPDATE last_sync_date = VALUES(last_sync_date), last_sync_timestamp = VALUES(last_sync_timestamp),
           status = VALUES(status), items_added = VALUES(items_added), items_updated = VALUES(items_updated),
           error_message = VALUES(error_message)",
    )
    .bind(SYNC_TYPE)
    .bind(status)
    .bind(result.albums_added as i32)
    .bind(result.albums_linked as i32)
    .bind(error)
    .execute(pool)
    .await;
    if let Err(e) = outcome {
        Logger::warn("APPLE_MUSIC", &format!("Failed to record sync status: {}", e));
    }
}

pub async fn sync_albums(pool: &DbPool, config: &AppleMusicConfig) -> Result<AlbumSyncResult, String> {
    let client = AppleMusicClient::new(config.clone())?;
    let mut result = AlbumSyncResult::default();
    resolve_artist_ids(pool, &client, &mut result).await?;

    let artists = sqlx::query_as::<_, ResolvedArtist>(
        "SELECT id, apple_music_artist_id FROM artists WHERE apple_music_artist_id IS NOT NULL ORDER BY id",
    )
    .fetch_all(pool)
    .await
    .map_err(|e| e.to_string())?;

    for artist in artists {
        match client.artist_full_albums(&artist.apple_music_artist_id, ALBUMS_PER_ARTIST).await {
            Ok(albums) => {
                for album in albums.iter().filter_map(album_row) {
                    match store_album(pool, artist.id, &album, client.storefront()).await {
                        Ok(StoreOutcome::Added) => result.albums_added += 1,
                        Ok(StoreOutcome::Linked) => result.albums_linked += 1,
                        Ok(StoreOutcome::AlreadyLinked) => {}
                        Err(e) => {
                            result.errors += 1;
                            Logger::warn("APPLE_MUSIC", &format!("Failed to store album for artist {}: {}", artist.id, e));
                        }
                    }
                }
            }
            Err(e) => {
                result.errors += 1;
                Logger::warn("APPLE_MUSIC", &format!("Failed to fetch albums for artist {}: {}", artist.id, e));
            }
        }
    }
    Ok(result)
}

async fn resolve_artist_ids(pool: &DbPool, client: &AppleMusicClient, result: &mut AlbumSyncResult) -> Result<(), String> {
    let pending = sqlx::query_as::<_, UnresolvedArtist>(
        "SELECT id, name, english_name FROM artists
         WHERE apple_music_artist_id IS NULL
           AND (apple_music_checked_at IS NULL OR apple_music_checked_at < NOW() - INTERVAL ? DAY)
         ORDER BY id",
    )
    .bind(RECHECK_DAYS)
    .fetch_all(pool)
    .await
    .map_err(|e| e.to_string())?;

    for artist in pending {
        result.artists_checked += 1;
        let found = match resolve_one(pool, client, &artist).await {
            Ok(found) => found,
            Err(e) => {
                result.errors += 1;
                Logger::warn("APPLE_MUSIC", &format!("Failed to resolve artist {}: {}", artist.id, e));
                // 일시 오류면 다음 동기화에서 다시 묻도록 확인 시각을 남기지 않는다
                continue;
            }
        };
        if found.is_some() {
            result.artists_resolved += 1;
        }
        sqlx::query("UPDATE artists SET apple_music_artist_id = ?, apple_music_checked_at = NOW() WHERE id = ?")
            .bind(found)
            .bind(artist.id)
            .execute(pool)
            .await
            .map_err(|e| e.to_string())?;
    }
    Ok(())
}

async fn resolve_one(pool: &DbPool, client: &AppleMusicClient, artist: &UnresolvedArtist) -> Result<Option<String>, String> {
    let samples = sqlx::query_scalar::<_, String>(
        "SELECT r.apple_music_id FROM recording_contributors rc
         JOIN recordings r ON r.id = rc.recording_id
         WHERE rc.artist_id = ? AND r.apple_music_id REGEXP '^[0-9]+$'
         ORDER BY rc.is_primary DESC, r.release_date DESC, r.id DESC
         LIMIT ?",
    )
    .bind(artist.id)
    .bind(SAMPLE_ALBUMS)
    .fetch_all(pool)
    .await
    .map_err(|e| e.to_string())?;

    for album_id in &samples {
        let Some(album) = client.album_with_artists(album_id).await? else { continue };
        let artists = album.relationships.and_then(|r| r.artists).map(|p| p.data).unwrap_or_default();
        if let Some(found) = pick_album_artist(&artist.english_name, &artist.name, &artists) {
            return Ok(Some(found.id.clone()));
        }
    }

    // 앨범으로 못 찾았을 때만 이름 검색. 이름 정확 일치 + 클래식 장르 + 그런 사람이 하나뿐일 때만 쓴다.
    if artist.english_name.trim().is_empty() {
        return Ok(None);
    }
    let candidates = client.search_artists(&artist.english_name).await?;
    Ok(pick_search_artist(&artist.english_name, &candidates).map(|found| found.id.clone()))
}

enum StoreOutcome {
    Added,
    Linked,
    AlreadyLinked,
}

async fn store_album(pool: &DbPool, artist_id: i32, album: &NewAlbumRow, storefront: &str) -> Result<StoreOutcome, sqlx::Error> {
    let existing = sqlx::query_scalar::<_, i32>(
        "SELECT id FROM recordings
         WHERE apple_music_id = ? OR (? IS NOT NULL AND upc = ?)
         ORDER BY id LIMIT 1",
    )
    .bind(&album.apple_music_id)
    .bind(&album.upc)
    .bind(&album.upc)
    .fetch_optional(pool)
    .await?;

    let mut tx = pool.begin().await?;
    let outcome = if let Some(recording_id) = existing {
        // 이미 있는 앨범은 내용을 덮지 않고, 이 연주자와의 참여 연결만 없으면 더한다
        let linked = sqlx::query(
            "INSERT IGNORE INTO recording_contributors
             (recording_id, track_id, artist_id, role_code, is_primary, display_order)
             VALUES (?, NULL, ?, 'primary_performer', FALSE, 0)",
        )
        .bind(recording_id)
        .bind(artist_id)
        .execute(&mut *tx)
        .await?;
        if linked.rows_affected() > 0 { StoreOutcome::Linked } else { StoreOutcome::AlreadyLinked }
    } else {
        let inserted = sqlx::query(
            "INSERT INTO recordings (artist_id, title, year, release_date, label, cover_url, upc, apple_music_id,
             track_count, is_single, is_compilation, genre_names, copyright, editorial_notes,
             artwork_width, artwork_height, apple_music_url)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
        )
        .bind(artist_id)
        .bind(&album.title)
        .bind(&album.year)
        .bind(album.release_date)
        .bind(&album.label)
        .bind(&album.cover_url)
        .bind(&album.upc)
        .bind(&album.apple_music_id)
        .bind(album.track_count)
        .bind(album.is_single)
        .bind(album.is_compilation)
        .bind(&album.genre_names)
        .bind(&album.copyright)
        .bind(&album.editorial_notes)
        .bind(album.artwork_width)
        .bind(album.artwork_height)
        .bind(&album.apple_music_url)
        .execute(&mut *tx)
        .await?;
        let recording_id = inserted.last_insert_id();
        sqlx::query(
            "INSERT IGNORE INTO recording_contributors
             (recording_id, track_id, artist_id, role_code, is_primary, display_order)
             VALUES (?, NULL, ?, 'primary_performer', TRUE, 0)",
        )
        .bind(recording_id)
        .bind(artist_id)
        .execute(&mut *tx)
        .await?;
        if let Some(url) = &album.apple_music_url {
            sqlx::query(
                "INSERT IGNORE INTO platform_links (recording_id, platform, storefront, platform_id, url, verified_at)
                 VALUES (?, 'apple_music', ?, ?, ?, NOW(6))",
            )
            .bind(recording_id)
            .bind(storefront)
            .bind(&album.apple_music_id)
            .bind(url)
            .execute(&mut *tx)
            .await?;
        }
        StoreOutcome::Added
    };
    tx.commit().await?;
    Ok(outcome)
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::recording::apple_music::Page;

    fn album(json: &str) -> Album {
        let page: Page<Album> = serde_json::from_str(&format!(r#"{{"data":[{}]}}"#, json)).unwrap();
        page.data.into_iter().next().unwrap()
    }

    #[test]
    fn album_row_maps_catalog_fields() {
        let row = album_row(&album(
            r#"{"id":"1797822937","attributes":{"name":"Ravel: Piano Concertos","releaseDate":"2025-05-16",
            "recordLabel":"Naïve","upc":"3617390936252","trackCount":8,"isSingle":false,"isCompilation":false,
            "genreNames":["Classical","Music"],"copyright":"℗ 2025",
            "artwork":{"url":"https://x/{w}x{h}bb.jpg","width":3000,"height":3000},
            "url":"https://music.apple.com/us/album/x/1797822937","editorialNotes":{"short":"짧은 설명"}}}"#,
        ))
        .unwrap();
        assert_eq!(row.apple_music_id, "1797822937");
        assert_eq!(row.year, "2025");
        assert_eq!(row.release_date, NaiveDate::from_ymd_opt(2025, 5, 16));
        assert_eq!(row.cover_url.as_deref(), Some("https://x/1000x1000bb.jpg"));
        assert_eq!(row.editorial_notes.as_deref(), Some("짧은 설명"));
        assert_eq!(row.genre_names, JsonValue::from(vec!["Classical", "Music"]));
        assert!(!row.is_single);
    }

    #[test]
    fn album_row_accepts_year_only_release() {
        let row = album_row(&album(r#"{"id":"1","attributes":{"name":"Old","releaseDate":"1998"}}"#)).unwrap();
        assert_eq!(row.year, "1998");
        assert_eq!(row.release_date, None);
    }

    #[test]
    fn album_row_skips_missing_title_or_date() {
        assert!(album_row(&album(r#"{"id":"1","attributes":{"name":"No date"}}"#)).is_none());
        assert!(album_row(&album(r#"{"id":"1","attributes":{"name":"  ","releaseDate":"2025-01-01"}}"#)).is_none());
        assert!(album_row(&album(r#"{"id":"1"}"#)).is_none());
    }

    #[test]
    fn album_row_drops_oversized_columns() {
        let long_upc = "1".repeat(30);
        let row = album_row(&album(&format!(
            r#"{{"id":"1","attributes":{{"name":"{}","releaseDate":"2025-01-01","upc":"{}"}}}}"#,
            "가".repeat(400),
            long_upc
        )))
        .unwrap();
        assert_eq!(row.title.chars().count(), 300);
        assert_eq!(row.upc, None);
    }
}
