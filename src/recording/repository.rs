use crate::db::DbPool;
use super::model::{Recording, CreateRecording, UpdateRecording};
use sqlx::Error;

pub struct RecordingRepository;

impl RecordingRepository {
    pub async fn find_all(pool: &DbPool) -> Result<Vec<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, label, cover_url FROM recordings ORDER BY year DESC"
        )
        .fetch_all(pool)
        .await
    }

    pub async fn find_by_id(pool: &DbPool, id: i32) -> Result<Option<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, label, cover_url FROM recordings WHERE id = ?"
        )
        .bind(id)
        .fetch_optional(pool)
        .await
    }

    pub async fn find_by_artist(pool: &DbPool, artist_id: i32) -> Result<Vec<Recording>, Error> {
        sqlx::query_as::<_, Recording>(
            "SELECT id, artist_id, title, year, label, cover_url FROM recordings WHERE artist_id = ? ORDER BY year DESC"
        )
        .bind(artist_id)
        .fetch_all(pool)
        .await
    }

    pub async fn create(pool: &DbPool, recording: CreateRecording) -> Result<u64, Error> {
        let result = sqlx::query(
            "INSERT INTO recordings (artist_id, title, year, label, cover_url) VALUES (?, ?, ?, ?, ?)"
        )
        .bind(recording.artist_id)
        .bind(recording.title)
        .bind(recording.year)
        .bind(recording.label)
        .bind(recording.cover_url)
        .execute(pool)
        .await?;

        Ok(result.last_insert_id())
    }

    pub async fn update(pool: &DbPool, id: i32, recording: UpdateRecording) -> Result<u64, Error> {
        let current = Self::find_by_id(pool, id).await?;
        if current.is_none() {
            return Ok(0);
        }
        let current = current.unwrap();

        let result = sqlx::query(
            "UPDATE recordings SET title = ?, year = ?, label = ?, cover_url = ? WHERE id = ?"
        )
        .bind(recording.title.unwrap_or(current.title))
        .bind(recording.year.unwrap_or(current.year))
        .bind(recording.label.or(current.label))
        .bind(recording.cover_url.or(current.cover_url))
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
