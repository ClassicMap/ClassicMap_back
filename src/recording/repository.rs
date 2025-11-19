use crate::db::DbPool;
use super::model::{Recording, CreateRecording, UpdateRecording};
use sqlx::Error;

pub struct RecordingRepository;

impl RecordingRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, release_date, label, cover_url, upc, apple_music_id,
             track_count, is_single, is_compilation, genre_names, copyright, editorial_notes,
             artwork_width, artwork_height, spotify_url, apple_music_url, youtube_music_url, external_url
             FROM recordings ORDER BY year DESC"
        )
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, release_date, label, cover_url, upc, apple_music_id,
             track_count, is_single, is_compilation, genre_names, copyright, editorial_notes,
             artwork_width, artwork_height, spotify_url, apple_music_url, youtube_music_url, external_url
             FROM recordings WHERE id = ?"
        )
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    pub async fn find_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, release_date, label, cover_url, upc, apple_music_id,
             track_count, is_single, is_compilation, genre_names, copyright, editorial_notes,
             artwork_width, artwork_height, spotify_url, apple_music_url, youtube_music_url, external_url
             FROM recordings WHERE artist_id = ? ORDER BY year DESC"
        )
        .bind(artist_id)
        .fetch_all(pool)
        .await
    }

    pub async fn create(pool: &DbPool, recording: CreateRecording) -> Result<u64, Error> {
        use sqlx::types::chrono::NaiveDate;

        // release_date 문자열을 NaiveDate로 파싱
        let release_date_parsed = recording.release_date
            .as_ref()
            .and_then(|s| NaiveDate::parse_from_str(s, "%Y-%m-%d").ok());

        let result = sqlx::query(
            "INSERT INTO recordings (artist_id, title, year, release_date, label, cover_url, upc, apple_music_id,
             track_count, is_single, is_compilation, genre_names, copyright, editorial_notes,
             artwork_width, artwork_height, spotify_url, apple_music_url, youtube_music_url, external_url)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        )
        .bind(recording.artist_id)
        .bind(recording.title)
        .bind(recording.year)
        .bind(release_date_parsed)
        .bind(recording.label)
        .bind(recording.cover_url)
        .bind(recording.upc)
        .bind(recording.apple_music_id)
        .bind(recording.track_count)
        .bind(recording.is_single)
        .bind(recording.is_compilation)
        .bind(recording.genre_names)
        .bind(recording.copyright)
        .bind(recording.editorial_notes)
        .bind(recording.artwork_width)
        .bind(recording.artwork_height)
        .bind(recording.spotify_url)
        .bind(recording.apple_music_url)
        .bind(recording.youtube_music_url)
        .bind(recording.external_url)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id())
    }

    pub async fn update(pool: &DbPool, id: i32, recording: UpdateRecording) -> Result<u64, Error> {
        use sqlx::types::chrono::NaiveDate;

        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        // release_date 문자열을 NaiveDate로 파싱
        let release_date_parsed = recording.release_date
            .as_ref()
            .and_then(|s| NaiveDate::parse_from_str(s, "%Y-%m-%d").ok());

        let result = sqlx::query(
            "UPDATE recordings SET title = ?, year = ?, release_date = ?, label = ?, cover_url = ?,
             upc = ?, apple_music_id = ?, track_count = ?, is_single = ?, is_compilation = ?,
             genre_names = ?, copyright = ?, editorial_notes = ?, artwork_width = ?, artwork_height = ?,
             spotify_url = ?, apple_music_url = ?, youtube_music_url = ?, external_url = ?
             WHERE id = ?"
        )
        .bind(recording.title.unwrap_or(current.title))
        .bind(recording.year.unwrap_or(current.year))
        .bind(if recording.release_date.is_some() { release_date_parsed } else { current.release_date })
        .bind(recording.label.or(current.label))
        .bind(recording.cover_url.or(current.cover_url))
        .bind(recording.upc.or(current.upc))
        .bind(recording.apple_music_id.or(current.apple_music_id))
        .bind(recording.track_count.or(current.track_count))
        .bind(recording.is_single.or(current.is_single))
        .bind(recording.is_compilation.or(current.is_compilation))
        .bind(recording.genre_names.or(current.genre_names))
        .bind(recording.copyright.or(current.copyright))
        .bind(recording.editorial_notes.or(current.editorial_notes))
        .bind(recording.artwork_width.or(current.artwork_width))
        .bind(recording.artwork_height.or(current.artwork_height))
        .bind(recording.spotify_url.or(current.spotify_url))
        .bind(recording.apple_music_url.or(current.apple_music_url))
        .bind(recording.youtube_music_url.or(current.youtube_music_url))
        .bind(recording.external_url.or(current.external_url))
        .bind(id)
        .execute(pool)
        .await?;

        Ok(result.rows_affected())
    }

    pub async fn delete(pool: &DbPool, id: i32) -> Result<u64, Error> {
        let result = sqlx::query("DELETE FROM recordings WHERE id = ?")
            .bind(id)
            .execute(pool)
            .await?;

        Ok(result.rows_affected())
    }
}
